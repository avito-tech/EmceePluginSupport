// swift-tools-version:5.9
import PackageDescription
let package = Package(
    name: "EmceePluginSupport",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(name: "EmceePlugin", targets: ["EmceePlugin"]),
        .library(name: "EmceePluginModels", targets: ["EmceePluginModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/avito-tech/CommandLineToolkit.git", from: "2.0.0"),
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "3.0.6"),
    ],
    targets: [
        .target(
            name: "EmceePlugin",
            dependencies: [
                .product(name: "CLTLogging", package: "CommandLineToolkit"),
                .product(name: "CLTLoggingModels", package: "CommandLineToolkit"),
                .product(name: "DateProvider", package: "CommandLineToolkit"),
                .product(name: "DI", package: "CommandLineToolkit"),
                .product(name: "FileSystem", package: "CommandLineToolkit"),
                .product(name: "JSONStream", package: "CommandLineToolkit"),
                .product(name: "Starscream", package: "Starscream"),
                .product(name: "SynchronousWaiter", package: "CommandLineToolkit"),
                "EmceePluginModels",
                "SimulatorVideoRecorder",
            ]
        ),
        .target(
            name: "EmceePluginModels"
        ),
        .target(
            name: "SimulatorVideoRecorder",
            dependencies: [
                .product(name: "PathLib", package: "CommandLineToolkit"),
                .product(name: "ProcessController", package: "CommandLineToolkit"),
            ]
        ),
    ]
)
