// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Base",
            targets: ["Base"]
        ),
        .library(
            name: "Factories",
            targets: ["Factories"]
        ),
        .library(
            name: "Dependencies",
            targets: ["Dependencies"]
        ),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../DIContainer")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Base",
            dependencies: [
                .product(name: "CommonExtensions", package: "Common"),
                .product(name: "CommonManagers", package: "Common"),
                .product(name: "CommonHelpers", package: "Common")
            ]
        ),
        .target(
            name: "Factories",
            dependencies: [
                "Dependencies",
                "Base",
                .product(name: "DIContainer", package: "DIContainer")
            ]
        ),
        .target(
            name: "Dependencies",
            dependencies: [
                "Base"
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Base"]
        ),
    ]
)
