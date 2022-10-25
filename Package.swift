// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PackageExample",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "PackageExample",
            targets: ["PackageExample"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        .target(
            name: "PackageExample",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto")
            ]),
        .testTarget(
            name: "PackageExampleTests",
            dependencies: ["PackageExample"]),
    ]
)

