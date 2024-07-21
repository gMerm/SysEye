# SysEye

**SysEye** is a system monitoring tool consisting of a backend service and a frontend client. The backend collects system performance metrics and stores them, while the frontend fetches and displays this data.

## Overview

### Backend

- **File:** `sys_monitor.py`
- **Description:** Collects system performance metrics (CPU, memory, disk I/O, temperature, and disk fullness), stores them in an SQLite database, and exposes them via a REST API.
- **Dependencies:** `Flask`, `psutil`, `mactemperatures`

### Frontend

- **File:** `Sources/main.swift`
- **Description:** Fetches data from the backend API and prints it to the console.
- **Dependencies:** `Alamofire`

## Setup

### Backend Setup

1. **Install Dependencies**

   Ensure you have Python installed. Install the necessary Python packages using `requirements.txt`:
   ```bash
   pip install -r backend/requirements.txt

2. **Run the Backend**

   Navigate to the backend directory and start the server:
   ```bash
   python sys_monitor.py

### Frontend Setup

1. **Install Swift and Dependencies**

   Ensure Swift is installed on your machine. You will need to use Swift Package Manager to manage dependencies.

2. **Build the Frontend**

   Navigate to the frontend directory and build the Swift application:
   ```bash
   swift build

3. **Run the Frontend**

   Execute the built application:
   ```bash
   swift run

### Run it as a service

1. **Create log dir**

   ```bash
   mkdir -p ~/SysEye/logs

2. **Run the Backend**

   Navigate to the Directory Containing the Python Script and run the Python Script Using nohup:
   ```bash
   nohup python3 sys_monitor.py > ~/SysEye/logs/sys_monitor.log 2>&1 &

3. **Build the Frontend**

   Navigate to the frontend directory and build the Swift application:
   ```bash
   swift build

4. **Run the Frontend**

   ```bash
   nohup ./SysMonitorApp > ~/SysEye/logs/sys_monitorapp.log 2>&1 &
   
## Contributing

Contributions are welcome! Please open issues or submit pull requests if you encounter any bugs or have suggestions for improvements.

   
