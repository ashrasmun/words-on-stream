@echo off
rem Do not setlocal because it prevents the virtual environment from being
rem activated

rem Minimal version of python required to create the virtual environment and
rem invoke the script.
set min_py_version=3.12

rem Name of the virtual environment. Should be transparent for the user.
set venv_name=env

:: -------------------------------- details -------------------------------- ::

where python 2>nul 1>nul

if errorlevel 1 (
    echo You need to install Python %min_py_version% before setting up the
    echo virtual environment.
    exit /b 1
)

python -V > temp.txt
set /p version_string=<temp.txt
del temp.txt

if "%version_string:~0,8%" NEQ "Python %min_py_version:~0,1%" (
    echo You need to install Python %min_py_version% before setting up the
    echo virtual environment.
    exit /b 1
)

pushd %~dp0
    py -%min_py_version% venv_setup.py
    call %venv_name%\Scripts\activate
    echo Installing project dependencies based on pyproject.toml...
    pip install ..[dev] 1>nul
popd
