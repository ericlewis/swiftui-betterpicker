// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftui-betterpicker",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "swiftui-betterpicker",
            targets: ["swiftui-betterpicker"]),
    ],
    targets: [
        .target(
            name: "swiftui-betterpicker",
            dependencies: []),
    ]
)
