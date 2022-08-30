// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Language",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Language",
            type: .static,
            targets: ["Language"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Language",
            dependencies: [],
            path: "Sources"
        )
    ]
)
