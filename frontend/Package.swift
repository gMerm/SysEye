// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SysMonitorApp",
    platforms: [
        .macOS(.v11) 
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "SysMonitorApp",
            dependencies: []
        ),
    ]
)
