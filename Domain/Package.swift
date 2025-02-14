// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UseCases",
            targets: ["UseCases"]
        ),
        .library(
            name: "Models",
            targets: ["Models"]
        ),
        .library(
            name: "DomainMocks",
            targets: ["DomainMocks"]
        ),
    ],
    dependencies: [
        .package(path: "../Data"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.8.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UseCases",
            dependencies: [
                "Models",
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "Repositories", package: "Data"),
            ]
        ),
        .target(
            name: "Models",
            dependencies: [
                .product(name: "Networking", package: "Data"),
            ]
        ),
        .target(
            name: "DomainMocks",
            dependencies: [
                "Models",
                .product(name: "Networking", package: "Data"),
                .product(name: "RxSwift", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["UseCases"]
        ),
    ]
)
