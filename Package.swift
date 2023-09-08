// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ZZImageSlider",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ZZImageSlider",
            targets: ["ZZImageSlider"]),
        .library(
            name: "ZZImageSliderSwiftUI",
            targets: ["ZZImageSliderSwiftUI"]),
    ],
    targets: [
        .target(
            name: "ZZImageSlider"
        ),
        .target(
            name: "ZZImageSliderSwiftUI"
        ),
    ]
)

package.targets.append(
    .testTarget(
        name: "ZZImageSliderSwiftUITests",
        dependencies: ["ZZImageSliderSwiftUI"]
    )
)
