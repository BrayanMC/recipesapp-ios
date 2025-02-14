// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Features",
            targets: ["Features"]
        ),
        .library(
            name: "UIComponents",
            targets: ["UIComponents"]
        ),
        .library(
            name: "Helpers",
            targets: ["Helpers"]
        ),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(path: "../Core"),
        .package(path: "../Domain"),
        .package(path: "../DIContainer"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Features",
            dependencies: [
                "UIComponents",
                "Helpers",
                .product(name: "Dependencies", package: "Core"),
                .product(name: "Factories", package: "Core"),
                .product(name: "DIContainer", package: "DIContainer"),
                .product(name: "Models", package: "Domain"),
                .product(name: "UseCases", package: "Domain"),
            ],
            path: "Sources/Features",
            resources: [
                .process("Home/View/HomeViewController.storyboard"),
                .process("Home/View/RecipeCell/RecipeCellView.xib"),
                .process("Detail/View/RecipeDetailViewController.storyboard"),
                .process("Detail/View/IngredientCell/IngredientCellView.xib"),
                .process("Map/View/MapViewController.storyboard"),
            ]
        ),
        .target(
            name: "UIComponents",
            dependencies: [
                .product(name: "CommonHelpers", package: "Common"),
                .product(name: "CommonManagers", package: "Common"),
                .product(name: "CommonExtensions", package: "Common"),
            ]//,
            //path: "Sources/UIComponents",
            //resources: [
            //    .process("TextFields/CustomTextField/CustomTextField.xib"),
            //   .process("Resources/Fonts/MuseoSans-300.otf"),
            //   .process("Resources/Fonts/MuseoSans-500.otf"),
            //   .process("Resources/Fonts/MuseoSans-700.otf"),
            //]
        ),
        .target(
            name: "Helpers"
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["Features"]
        ),
    ]
)
