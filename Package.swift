// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "ULinkAD-adapters-ios",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ULinkMediatomAdapter",
            targets: ["ULinkMediatomAdapterWrapper"]
        ),
        .library(
            name: "ULinkTakuAdapter",
            targets: ["ULinkTakuAdapterWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/binhalomobi/ULinkAD-ios.git", from: "2.0.2")
    ],
    targets: [
        .binaryTarget(
            name: "ULinkMediatomAdapterBinary",
            url: "https://github.com/binhalomobi/ULinkAD-adapters-ios/releases/download/1.2.0/ULinkMediatomAdapter-1.0.2.zip",
            checksum: "795e9ddd69aff3d21dbae0d355bf5ee5852e2902802b49a2a2d59e0d4b92be00"
        ),
        .target(
            name: "ULinkMediatomAdapterWrapper",
            dependencies: [
                "ULinkMediatomAdapterBinary",
                .product(name: "ULinkAD", package: "ULinkAD-ios")
            ]
        ),
        .binaryTarget(
            name: "ULinkTakuAdapterBinary",
            url: "https://github.com/binhalomobi/ULinkAD-adapters-ios/releases/download/1.2.0/ULinkTakuAdapter-1.0.1.zip",
            checksum: "2a392ce9cea0cf1dd8f24aaf1952c61fa6c9d3e2f9a4fae191e7a73cc851a3d1"
        ),
        .target(
            name: "ULinkTakuAdapterWrapper",
            dependencies: [
                "ULinkTakuAdapterBinary",
                .product(name: "ULinkAD", package: "ULinkAD-ios")
            ]
        )
    ]
)
