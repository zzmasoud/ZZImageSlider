// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ZZImageSlider",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "ZZImageSlider",
            targets: ["ZZImageSlider"]),
    ],
    targets: [
        .target(
            name: "ZZImageSlider",
            path: "Sources/Classes")
    ],
    swiftLanguageVersions: [.v5]
)
