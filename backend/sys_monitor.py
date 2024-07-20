import psutil
import sqlite3
import json
from mactemperatures import get_thermal_readings
from datetime import datetime
from flask import Flask, jsonify

#initialize the Flask app
app = Flask(__name__)

#create the database that will hold the system data regarding CPU usage, memory usage
#and disk usage
def create_database():
    conn = sqlite3.connect('sys_monitor.db')
    c = conn.cursor()
    c.execute('''
              CREATE TABLE IF NOT EXISTS perf_data (
                  timestamp TEXT,
                  cpu REAL,
                    memory REAL,
                    disk_io REAL,
                    temperature REAL,
                    disk_fullness REAL
              )
              ''')
    conn.commit()
    conn.close()
    

#insert the system data into the database
def insert_data(cpu, memory, disk_io, temperature, disk_fullness):
    conn = sqlite3.connect('sys_monitor.db')
    c = conn.cursor()
    c.execute('''
              INSERT INTO perf_data (timestamp, cpu, memory, disk_io, temperature, disk_fullness)
              VALUES (?, ?, ?, ?, ?, ?)
              ''', (datetime.now().isoformat(), cpu, memory, disk_io, temperature, disk_fullness)
    )
    conn.commit()
    conn.close()

#function to get the temperature of the CPU
#get all temperature readings using the mactemperatures library
def get_temperature():
    try:
        readings = get_thermal_readings()  
        if readings:
            temps = [abs(temp) for temp in readings.values() if isinstance(temp, (int, float))]
            if temps:
                average_temp = sum(temps) / len(temps)
                return average_temp
        return None
    except Exception as e:
        print(f"Temperature retrieval error: {e}")
        return None


#function to get the system data from the computer
#cpu = CPU usage
#memory = memory usage
#disk_io = disk usage now
#temp = temperature of the CPU
#disk_fullness = percentage of disk used
def get_sys_data():
    cpu = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory().percent
    disk_io = psutil.disk_usage('/').percent
    temp = get_temperature()
    
    hdd = psutil.disk_usage('/System/Volumes/Data')
    total_space = hdd.total / (2**30)  
    used_space = hdd.used / (2**30)    
    free_space = hdd.free / (2**30)
    percent_used = (total_space - free_space) / total_space * 100
        
    #insert the data into the database
    insert_data(cpu, memory, disk_io, temp, percent_used)
    
    #return the data as a JSON object
    data = {'cpu': cpu, 'memory': memory, 'disk_io': disk_io, 'temperature': temp, 'disk_fullness': percent_used}
    return json.dumps(data)


#route to get the system data
@app.route('/data', methods=['GET'])
def data():
    return jsonify(get_sys_data())


if __name__ == "__main__":
    create_database()
    app.run(host='0.0.0.0', port=5001, debug=False)