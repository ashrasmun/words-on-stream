import os
import subprocess


def run_py(command: str) -> subprocess.CompletedProcess:
    py_ver = os.environ["min_py_version"]
    cmd = f"py -{py_ver} {command}"
    return subprocess.run(
        cmd,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

def main():
    print("Updating pip...")
    run_py("-m pip install --upgrade pip")
    print("Checking for virtualenv module...")
    p = run_py("-m virtualenv")

    if p.returncode != 0:
        print("Installing virtualenv module...")
        run_py("-m pip install virtualenv")

    venv_name = os.environ["venv_name"]
    venv_dir = os.path.join(__file__, "..", venv_name)

    if not os.path.isdir(venv_dir):
        print("Creating virtual environment...")
        run_py(f"-m virtualenv {venv_dir}")


if __name__=="__main__":
    main()
