REM ┌─────────────────────────────────────────────────────────┐
REM │                                                         │
REM │  https://github.com/MarvinJWendt/windows-sandbox-setup  │
REM │                                                         │
REM └─────────────────────────────────────────────────────────┘

REM This script is called on every sandbox.
REM It is used to allow the sandbox to run PowerShell scripts.
REM The PowerShell script is the actual setup.

@echo off

REM Run setup powershell script
Powershell -noprofile -executionpolicy bypass -file C:\Users\WDAGUtilityAccount\Desktop\share\readonly\scripts\setup.ps1