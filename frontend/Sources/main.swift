import Foundation
import Alamofire

//struct that will handle the data from the API
struct SystemData: Decodable {
    let cpu: Double
    let memory: Double
    let disk_io: Double
    let temperature: Double?
    let disk_fullness: Double
}

let url = "http://localhost:5001/data"

//Make the request and handle response as a String
AF.request(url).responseString { response in
    switch response.result {
    case .success(let jsonString):
        print("Raw JSON String: \(jsonString)")
        
    case .failure(let error):
        print("Error: \(error)")
    }
}

//keep the program running to ensure the request is processed
RunLoop.main.run()
