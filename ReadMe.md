# Wait Azure DevOps Extension

This is an Azure DevOps extension that allows you to pause a build or release flow for the specified length of time. You can find it on [the Azure DevOps Marketplace here][AzureDevOpsMarketplaceExtensionUrl].

You specify the number of milliseconds, seconds, or minutes that you want the process to wait for, and it will pause for that length of time.

**Note:** This extension currently only supports *Windows* agents, but there are plans to also support Linux and Mac agents in the future.

Current build status: [![Build Status](https://dev.azure.com/deadlydog/OpenSource/_apis/build/status/AzureDevOps.Wait?branchName=master)](https://dev.azure.com/deadlydog/OpenSource/_build/latest?definitionId=21&branchName=master)
[![Deployment Status](https://vsrm.dev.azure.com/deadlydog/_apis/public/Release/badge/baf297a4-1582-49bd-b9ca-6d38492faafa/3/3)](https://dev.azure.com/deadlydog/OpenSource/_release?definitionId=3)

## Screenshot

![Screenshot][ScreenshotImage]

## Issues

If you find any problems with this extension, please [create an Issue for it][GitHubIssuesUrl].

## Donate

Buy me a poutine for providing this extension open source and for free :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=CZP8CU53RJ29W)

<!-- Links -->
[ScreenshotImage]: src/Images/Screenshot.png
[AzureDevOpsMarketplaceExtensionUrl]: https://marketplace.visualstudio.com/items?itemName=deadlydog.WaitBuildAndReleaseTask
[GitHubIssuesUrl]: https://github.com/deadlydog/AzureDevOps.Wait/issues