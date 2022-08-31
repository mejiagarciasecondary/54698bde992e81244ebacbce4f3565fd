// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Common",
            type: .static,
            targets: ["Common"]
        ),
    ],
    dependencies: [
        .package(path: "../Language")
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: [
                .product(name: "Language", package: "Language")
            ],
            path: "Sources"
        )
    ]
)
