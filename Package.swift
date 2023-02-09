// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "EmceePluginSupport",
    platforms: [
        .macOS(.v11),
    ],
    products: [
        .library(name: "EmceePlugin", targets: ["EmceePlugin"]),
        .library(name: "EmceePluginModels", targets: ["EmceePluginModels"]),
    ],
    dependencies: [
        .package(name: "CommandLineToolkit", url: "https://github.com/avito-tech/CommandLineToolkit.git", from: "1.0.20"),
        .package(name: "Starscream", url: "https://github.com/daltoniam/Starscream.git", from: "3.0.6"),
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
            ]
        ),
        .target(
            name: "EmceePluginModels"
        )
    ]
)
