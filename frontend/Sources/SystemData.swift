import Foundation
import Combine

//THIS FILE BRINGS THE DATA FROM THE .API AND HANDLES IT
//struct that will handle the data from the API
struct SystemData: Decodable {
    let cpu: Double
    let memory: Double
    let disk_io: Double
    let temperature: Double
    let disk_fullness: Double
}

//class that will fetch the data from the API every 5 seconds and update the data
class SystemDataFetcher: ObservableObject {
    @Published var systemData = SystemData(cpu: 0, memory: 0, disk_io: 0, temperature: 0, disk_fullness: 0)
    var cancellable: AnyCancellable?

    init() {
        fetchData()
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            self.fetchData()
        }
    }

    func fetchData() {
        guard let url = URL(string: "http://localhost:5001/data") else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: SystemData.self, decoder: JSONDecoder())
            .replaceError(with: SystemData(cpu: 0, memory: 0, disk_io: 0, temperature: 0, disk_fullness: 0))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                self?.systemData = data
            })
    }
}
