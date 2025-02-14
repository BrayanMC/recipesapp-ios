// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CommonExtensions",
            targets: ["CommonExtensions"]
        ),
        .library(
            name: "CommonProtocols",
            targets: ["CommonProtocols"]
        ),
        .library(
            name: "CommonHelpers",
            targets: ["CommonHelpers"]
        ),
        .library(
            name: "CommonManagers",
            targets: ["CommonManagers"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.30.4")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CommonExtensions",
            dependencies: [
                .product(name: "SDWebImage", package: "SDWebImage"),
                .product(name: "SkeletonView", package: "SkeletonView")
            ]
        ),
        .target(
            name: "CommonProtocols",
            dependencies: []
        ),
        .target(
            name: "CommonHelpers",
            dependencies: []
        ),
        .target(
            name: "CommonManagers",
            dependencies: []
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: ["CommonExtensions"]
        ),
    ]
)
