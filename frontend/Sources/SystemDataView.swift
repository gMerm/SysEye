import SwiftUI

//This is the view that displays the system data
struct SystemDataView: View {
    @ObservedObject var fetcher = SystemDataFetcher()

    var body: some View {
        VStack {
            Text("SysEye").font(.largeTitle).padding(.top, 20)

            //This is the HStack that contains the progress circles for the system data
            HStack (spacing: 15) {
                ProgressCircle(value: fetcher.systemData.cpu, label: "CPU", color: .red)
                ProgressCircle(value: fetcher.systemData.memory, label: "RAM", color: .green)
                ProgressCircle(value: fetcher.systemData.disk_io, label: "Disk IO", color: .orange)
                ProgressCircle(value: fetcher.systemData.disk_fullness, label: "Disk Fullness", color: .purple)
            }
            .padding()

            //This is the text that displays the temperature under the progress circles
            Text("Temperature: \(fetcher.systemData.temperature, specifier: "%.1f")°C")
                .font(.title2)
                .padding(.top, 5)
                .padding(.bottom, 30)
        }
        .padding(.horizontal, 20)
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
