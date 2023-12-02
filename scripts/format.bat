@echo off
setlocal

if not defined VIRTUAL_ENV (
    call %~dp0..\venv\venv_setup.bat
)

set src_dir=%~dp0..\src
isort %src_dir% --profile black
black %src_dir% --line-length 80
