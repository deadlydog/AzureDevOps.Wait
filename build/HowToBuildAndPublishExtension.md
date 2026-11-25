# How to build and publish the Azure DevOps extension's VSIX package

## Automated builds and deployment

The building and publishing of this extension is done via Azure DevOps pipelines.

Every time a change is committed to the `main` branch [a new build][AzureDevOpsBuildPipelineUrl] is made.

If the build succeeds, [a new release][AzureDevOpsReleasePipelineUrl] will automatically be created which will publish the new version to [the Azure DevOps marketplace][ExtensionsAzureDevOpsMarketplaceUrl].

### YAML build pipeline

The build is defined in [`pipelines/azure-devops-build.yaml`](../pipelines/azure-devops-build.yaml).
It replaces the classic build pipeline, keeping the same `1.2.$(Rev:r)` version numbering, VSIX packaging, and `drop` build artifact, so the existing release pipeline can keep consuming the artifact.
It runs on a Windows agent for every commit and pull request to the `main` branch, and:

1. Installs Node.js 20.
1. Runs `npm run package` in `src/Tasks/Wait`, which installs the dependencies, compiles the TypeScript, runs the tests (failing the build if any fail), and removes the devDependencies so only runtime dependencies are packaged.
1. Packages the extension into a VSIX file using the build number as the extension and task version.
1. Publishes the VSIX file as the `drop` build artifact.

The packaging steps require the [Azure DevOps Extension Tasks][AzureDevOpsExtensionTasksUrl] extension to be installed in the Azure DevOps organization.

To start using it, create a new pipeline in Azure DevOps from the existing YAML file `pipelines/azure-devops-build.yaml` in this repository, then update the release pipeline's artifact source to point to the new build pipeline and disable the classic one.

**Important:** Until that is done, the classic build pipeline is still the one that runs.
It still runs the old `Pester Test Runner` step and packages the VSIX without building the task, so the VSIX it produces would not contain the compiled task or its `node_modules` dependencies.
Do not rely on the automated build and release to publish working versions of the extension until the YAML pipeline is set up.

## Manual builds and deployments

If you want to manually build and publish a new version of the extension, you can follow these steps.

### Prerequisites

You need to have Node.js installed. [Get it here][NodeJsDownloadUrl].

Once node is installed, install the TFS Cross Platform Command Line Interface (tfx-cli) with the command:

```cmd
npm i -g tfx-cli
```

### Building and testing the task

The task is written in TypeScript and lives in `src/Tasks/Wait`.
From that directory, run:

```cmd
npm install
npm test
```

`npm test` compiles the TypeScript into the `dist` directory and runs the unit tests.

To run the task locally, provide its inputs as `INPUT_<NAME>` environment variables. For example, in PowerShell:

```powershell
$env:INPUT_VALUE = '5'
$env:INPUT_UNIT = 'seconds'
node dist/src/index.js
```

Before packaging, run `npm run package`, which does a clean install, builds and tests the task, and then removes the devDependencies so that only the runtime dependencies are included in the VSIX package.

### Creating the VSIX package

#### Automated process to create the VSIX package

You can simply run the `New-Version.ps1` script to create a new VSIX package.
It will prompt you for the version number, build the task, and then create the VSIX file for you.

#### Manual process to create the VSIX package

Before creating the VSIX package be sure to update the `version` element in the `vss-extension.json` and `task.json` files appropriately, and run `npm run package` from the `src/Tasks/Wait` directory.

To create the VSIX package file, run the following command from the directory containing the `vss-extension.json` file:

```cmd
tfx extension create --manifest-globs vss-extension.json
```

### Publishing the VSIX package

You can manually publish a new version of the extension at [my personal Azure DevOps Marketplace extensions page][MyAzureDevOpsMarketplaceExtensionsUrl].

<!-- Links -->
[ExtensionsAzureDevOpsMarketplaceUrl]: https://marketplace.visualstudio.com/items?itemName=deadlydog.WaitBuildAndReleaseTask
[AzureDevOpsBuildPipelineUrl]: https://dev.azure.com/deadlydog/OpenSource/_build?definitionId=21
[AzureDevOpsReleasePipelineUrl]: https://dev.azure.com/deadlydog/OpenSource/_release?view=all&definitionId=3
[MyAzureDevOpsMarketplaceExtensionsUrl]: https://marketplace.visualstudio.com/manage/publishers/deadlydog
[NodeJsDownloadUrl]: https://nodejs.org/en/download
[AzureDevOpsExtensionTasksUrl]: https://marketplace.visualstudio.com/items?itemName=ms-devlabs.vsts-developer-tools-build-tasks