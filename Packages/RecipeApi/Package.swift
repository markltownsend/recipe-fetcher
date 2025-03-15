// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RecipeApi",
    platforms: [.iOS("16.6")],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RecipeApi",
            targets: ["RecipeApi"]),
    ],
    dependencies: [
        .package(path: "../Network"),
        .package(path: "../Model"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RecipeApi",
            dependencies: [
                "Network",
                "Model"
            ]
        ),
        .testTarget(
            name: "RecipeApiTests",
            dependencies: ["RecipeApi"]
        ),
    ]
)
