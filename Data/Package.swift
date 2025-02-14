// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        ),
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
        .library(
            name: "DataMocks",
            targets: ["DataMocks"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.8.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.0.5")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Repositories",
            dependencies: [
                "Networking",
                .product(name: "RxSwift", package: "RxSwift"),
            ]
        ),
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "RxSwift", package: "RxSwift"),
            ]
        ),
        .target(
            name: "DataMocks",
            dependencies: [
                "Repositories",
                "Networking",
                .product(name: "RxSwift", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Repositories"]
        ),
    ]
)
