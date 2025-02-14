// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponents",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UIComponents",
            targets: ["UIComponents"]
        ),
    ],
    dependencies: [
        .package(path: "../Common"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UIComponents",
            dependencies: [
                .product(name: "CommonHelpers", package: "Common"),
                .product(name: "CommonManagers", package: "Common"),
                .product(name: "CommonExtensions", package: "Common"),
            ],
            path: "Sources/UIComponents",
            resources: [
                .process("TextFields/CustomTextField/CustomTextField.xib"),
            //   .process("Resources/Fonts/MuseoSans-300.otf"),
            //   .process("Resources/Fonts/MuseoSans-500.otf"),
            //   .process("Resources/Fonts/MuseoSans-700.otf"),
            ]
        ),
        .testTarget(
            name: "UIComponentsTests",
            dependencies: ["UIComponents"]
        ),
    ]
)
