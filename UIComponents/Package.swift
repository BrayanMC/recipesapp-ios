// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponents",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DesignSystem",
            path: "Sources/DesignSystem",
            resources: [
                .process("TextFields/CustomTextField/CustomTextField.xib"),
                .process("Resources/Assets/Assets.xcassets"),
                .process("Resources/Assets/Colors.xcassets"),
            ]
        ),
        .testTarget(
            name: "UIComponentsTests",
            dependencies: ["DesignSystem"]
        ),
    ]
)
