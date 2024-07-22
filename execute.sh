#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Check if Python exists
if ! command_exists python3; then
    echo "Python3 is not installed. Please install Python3 and try again."
    exit 1
fi

# 2. Create virtual environment
if [ ! -d "backend/venv" ]; then
    python3 -m venv backend/venv
    echo "Virtual environment created."
else
    echo "Virtual environment already exists."
fi

# 3. Activate virtual environment and install requirements
source backend/venv/bin/activate
pip install -r backend/requirements.txt
deactivate
echo "Python dependencies installed."

# 4. Create log directory
mkdir -p ~/SysEye/logs
echo "Log directory created at ~/SysEye/logs."

# 5. Run the backend Python script with nohup
cd backend
source venv/bin/activate
nohup python3 sys_monitor.py > ~/SysEye/logs/sys_monitor.log 2>&1 &
deactivate
cd ..
echo "Backend Python script is running."

# 6. Navigate to the frontend directory and build the Swift application
cd frontend
swift build
if [ $? -ne 0 ]; then
    echo "Swift build failed. Please check the build logs for errors."
    exit 1
fi
echo "Swift application built successfully."

# 7. Run the Swift application with nohup
cd .build/debug
nohup ./SysMonitorApp > ~/SysEye/logs/sys_monitorapp.log 2>&1 &
echo "Swift application is running."

echo "Setup completed successfully."
