// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "frontend",
    platforms: [
        .macOS(.v13) 
    ],
    dependencies: [
        // Add Alamofire as a dependency
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0"),
    ],
    targets: [
        // Define the executable target and specify Alamofire as a dependency
        .executableTarget(
            name: "frontend",
            dependencies: ["Alamofire"]
        ),
    ]
)
