import SwiftUI

//This is the view that displays the system data
struct SystemDataView: View {
    @ObservedObject var fetcher = SystemDataFetcher()
    @State private var selectedSensor = "ISP MTR Temp Sensor5"
    @State private var isHovering = false

    var body: some View {
        VStack {
            Text("SysEye").font(.largeTitle).padding(.top, 50)

            let cpu = fetcher.systemData.cpu
            let memory = fetcher.systemData.memory
            let disk_io = fetcher.systemData.disk_io
            let disk_fullness = fetcher.systemData.disk_fullness
            let temperature = fetcher.systemData.temperature
            
            let cpu_color = getColor(for: Int(cpu))
            let memory_color = getColor(for: Int(memory))
            let disk_io_color = getColor(for: Int(disk_io))
            let disk_fullness_color = getColor(for: Int(disk_fullness))
            let temperature_color = getColor(for: Int(temperature))

            //This is the HStack that contains the progress circles for the system data
            HStack (spacing: 15) {
                ProgressCircle(value: fetcher.systemData.cpu, label: "CPU", color: cpu_color)
                ProgressCircle(value: fetcher.systemData.memory, label: "RAM", color: memory_color)
                ProgressCircle(value: fetcher.systemData.disk_io, label: "Disk IO", color: disk_io_color)
                ProgressCircle(value: fetcher.systemData.disk_fullness, label: "Disk Fullness", color: disk_fullness_color)
            }
            .padding()

            //temperature
            HStack(spacing: 0) {
                Text("Temperature: ")
                    .font(.title2)
                Text("\(temperature, specifier: "%.1f")°C")
                    .font(.title2)
                    .foregroundColor(temperature_color) 
            }
            .padding(.top, 5)
            .padding(.bottom, 10)         

            //This is the dropdown menu that allows the user to select a sensor
            HStack {
                Text("Select a sensor: ")
                Picker("", selection: $selectedSensor) {
                    ForEach(fetcher.systemData.sensors.keys.sorted(), id: \.self) { sensor in
                        Text(sensor)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.top, 5)
            .padding(.bottom, 5)

            //This is the text that displays the value of the selected sensor
            HStack {
                Text("Sensor Temp: ")
                Text("\(selectedSensor): \(fetcher.systemData.sensors[selectedSensor] ?? 0, specifier: "%.1f")°C")
                    .foregroundColor(getColor(for: Int(fetcher.systemData.sensors[selectedSensor] ?? 0)))
            }
            .padding(.top, 5)
            .padding(.bottom, 60)


            
        }
        .padding(.horizontal, 20)
    }

    //based on the value, this function returns a color for the progress circle or text
    func getColor(for value: Int) -> Color {
        if value >= 90 {
            return .red
        } else if value >= 75 {
            return .orange
        } else {
            return .blue
        }
    }
}

//This is the view that displays the progress circle
struct ProgressCircle: View {
    var value: Double
    var label: String
    var color: Color

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 8.0)
                    .opacity(0.3)
                    .foregroundColor(color)
                    .frame(width: 80, height: 80) //Smaller circle size

                Circle()
                    .trim(from: 0.0, to: CGFloat(min(value / 100.0, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: value)
                    .frame(width: 80, height: 80) //Smaller circle size

                Text(String(format: "%.0f%%", min(value, 100.0)))
                    .font(.title3) //Smaller font size
                    .bold()
            }
            .padding(.bottom, 5) //Less spacing between circle and label
            Text(label)
                .font(.caption)
        }
        .padding()
    }
}

struct SystemDataView_Previews: PreviewProvider {
    static var previews: some View {
        SystemDataView()
    }
}
