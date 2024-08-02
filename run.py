import os
import platform
import subprocess

APP_NAME = "VerifyTriangle"
SOURCE_FILES = ["v_triangle.swift"]

def compile_and_run():
    system = platform.system()
    if system == "Windows":
        print("Compiling for Windows...")
        subprocess.run(["swiftc"] + SOURCE_FILES + ["-o", f"{APP_NAME}.exe"])
        print("Running on Windows...")
        subprocess.run([f"{APP_NAME}.exe"])
    elif system == "Darwin":
        print("Compiling for macOS...")
        subprocess.run(["swiftc"] + SOURCE_FILES + ["-o", APP_NAME])
        print("Running on macOS...")
        subprocess.run([f"./{APP_NAME}"])
    else:
        print(f"Unsupported OS: {system}")

def clean():
    system = platform.system()
    if system == "Windows":
        print("Cleaning up...")
        os.remove(f"{APP_NAME}.exe")
    elif system == "Darwin":
        print("Cleaning up...")
        os.remove(APP_NAME)

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "clean":
        clean()
    else:
        compile_and_run()
