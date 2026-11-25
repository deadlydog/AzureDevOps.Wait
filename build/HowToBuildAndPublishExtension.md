# How to build and publish the Azure DevOps extension's VSIX package

## Automated builds and deployment

The building and publishing of this extension is done via Azure DevOps pipelines.

Every time a change is committed to the `master` branch [a new build][AzureDevOpsBuildPipelineUrl] is made.

If the build succeeds, [a new release][AzureDevOpsReleasePipelineUrl] will automatically be created which will publish the new version to [the Azure DevOps marketplace][ExtensionsAzureDevOpsMarketplaceUrl].

### Required build pipeline change for the TypeScript task

**Important:** The task is now written in TypeScript, but the classic build pipeline has not been updated for it yet.
It still runs the old `Pester Test Runner` step and packages the VSIX without building the task, so the VSIX it produces would not contain the compiled task or its `node_modules` dependencies.
Do not rely on the automated build and release to publish working versions of the extension until the pipeline has been updated as follows:

1. Remove the `Pester Test Runner` step (there are no longer any Pester tests).
1. Before the `Package Extension into a VSIX file` step, add an `npm` step (or a command line step) that runs `npm run package` with the working directory set to `src\Tasks\Wait`.
   This installs the dependencies, compiles the TypeScript, runs the tests (failing the build if any fail), and removes the devDependencies so only runtime dependencies are packaged.
   The agent needs Node.js 20 or later; add a `Use Node.js` step before it if required.

The `Publish Test Results` and `Publish code coverage` steps were for the Pester output and no longer find any files; they can be removed.

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