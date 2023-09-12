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
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.12.0"
        )
    ],
    targets: [
        .target(
            name: "ZZImageSlider"
        ),
        .target(
            name: "ZZImageSliderSwiftUI"
        ),
        .target(
          name: "TestHelper"
        )
    ]
)

package.targets.append(contentsOf: [
    .testTarget(
        name: "ZZImageSliderSwiftUITests",
        dependencies: [
            "ZZImageSliderSwiftUI",
            "TestHelper"
        ]
    ),
    .testTarget(
        name: "SnapshotTests",
        dependencies: [
            "ZZImageSliderSwiftUI",
            "TestHelper",
            .product(
                name: "SnapshotTesting",
                package: "swift-snapshot-testing"
            )
        ]
    )
])
