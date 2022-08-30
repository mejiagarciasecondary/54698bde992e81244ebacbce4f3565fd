// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Networking",
            type: .static,
            targets: ["Networking"]
        )
    ],
    dependencies: [
        .package(path: "../Language"),
        .package(path: "../Common")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Language", package: "Language"),
                .product(name: "Common", package: "Common")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"],
            path: "Tests"
        )
    ]
)
