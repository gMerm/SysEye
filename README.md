# SysEye

**SysEye** is a system monitoring tool consisting of a backend service and a frontend client. The backend collects system performance metrics and stores them, while the frontend fetches and displays this data.

## Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
   - [Backend Setup](#backend-setup)
   - [Frontend Setup](#frontend-setup)
3. [Usage](#usage)
4. [Example Output](#example-output)
5. [Troubleshooting](#troubleshooting)
6. [Contributing](#contributing)
7. [License](#license)
8. [Contact](#contact)

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
   Ensure you have Python installed. Install the necessary Python packages:
   ```bash
   pip install Flask psutil mactemperatures
