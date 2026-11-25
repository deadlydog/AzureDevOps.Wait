# Change Log

This page is a list of *notable* changes made to the Wait Azure DevOps extension.

## Unreleased

- feature: Rewrite the task in TypeScript using `azure-pipelines-task-lib` so it runs on Windows, Linux, and macOS agents (Node20_1 execution handler, with Node16 fallback).
- fix: The task now fails with a clear error message when `Value` is not a whole number, or `Unit` is not supported.

## October 23, 2019 - v1.2.28

- fix: Update extension to use new execution handler to avoid deprecation warning from Azure DevOps.

## February 25, 2019 - v1.2.1

- feature: Include the time we started waiting, and when the waiting will finish.

## May 14, 2018 - v1.0.0

- Extension released publicly.
