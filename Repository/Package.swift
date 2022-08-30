// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Repository",
            targets: ["Repository"]
        )
    ],
    dependencies: [
        .package(path: "../Networking"),
        .package(path: "../Common"),
        .package(path: "../Language")
    ],
    targets: [
        .target(
            name: "Repository",
            dependencies: [
                .product(name: "Networking", package: "Networking"),
                .product(name: "Common", package: "Common"),
                .product(name: "Language", package: "Language")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "RepositoryTests",
            dependencies: ["Repository"],
            path: "Tests"
        )
    ]
)
