// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProcessManagerCorePackage",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "ProcessManagerCore", targets: ["ProcessManagerCore"]),
    ],
    targets: [
        .target(
            name: "ProcessManagerCore",
            dependencies: []
        ),
    ]
)
