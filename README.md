# Windows Sandbox Setup

> **The Windows Sandbox is a feature in Windows Pro and Windows Enterprise.** It is a lightweight desktop environment. It is designed to run untrusted software in isolation from the host operating system. It is a great tool for testing software, and for running software that you don't trust.

This repository contains scripts and configurations to make Windows Sandboxes more user-friendly.

## Installation

To download all assets, you need to run the `setup.ps1` script.

This must only be done once. After that, you can run the `update.ps1` script to update the assets.

## Running a Sandbox

We have different pre-configured sandboxes in the `sandboxes` directory. You can run a sandbox by double-clicking the sandbox configuration file.

### Sandbox Configurations

<!-- configs:start -->

| Name | Protected Client | vGPU | Memory | Networking | Clipboard Redirection | Printer Redirection | Video Input | Audio Input |
| ---- | ---------------- | ---- | ------ | ---------- | --------------------- | ------------------- | ----------- | ----------- |
| default | ❌ | ❌ | 4000 | ✔️ | ✔️ | ❌ | ❌ | ✔️ |
| default with vGPU | ❌ | ✔️ | 4000 | ✔️ | ✔️ | ❌ | ❌ | ✔️ |
| performance | ❌ | ❌ | 8000 | ✔️ | ✔️ | ❌ | ❌ | ✔️ |
| performance with vGPU | ❌ | ✔️ | 8000 | ✔️ | ✔️ | ❌ | ❌ | ✔️ |
| secure | ✔️ | ❌ | 4000 | ❌ | ❌ | ❌ | ❌ | ❌ |
| secure with networking | ✔️ | ❌ | 4000 | ✔️ | ❌ | ❌ | ❌ | ❌ |
| unsecure | ❌ | ❌ | 4000 | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |
| unsecureperformance | ❌ | ❌ | 8000 | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |
| unsecureperformancevGPU | ❌ | ✔️ | 8000 | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |

<!-- configs:end -->

## Transfering files to and from a Sandbox

You have two ways to communicate with the sandbox. You can use the `share\transfer` directory, or you can use the `share\readonly` directory.

## Using the `share\transfer` directory

The `share\transfer` directory is a shared directory between the host and the sandbox. You can use this directory to transfer files to and from the sandbox.

**CAUTION:** This directory can be used to transfer files from the sandbox to the host. A malicious program in the sandbox, could delete all files in this directory.

## Using the `share\readonly` directory

This directory is read-only for the sandbox.

You can use this directory to store files that you want to be available to the sandbox, but that you don't want to be modified by the sandbox.


