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
        )
    ],
    dependencies: [
        .package(url: "https://github.com/binhalomobi/ULinkAD-ios.git", from: "2.0.1")
    ],
    targets: [
        .binaryTarget(
            name: "ULinkMediatomAdapterBinary",
            url: "https://github.com/binhalomobi/ULinkAD-adapters-ios/releases/download/1.0.0/ULinkMediatomAdapter-1.0.0.zip",
            checksum: "f592071ae9b834a3d2badc54b336f4594819f43d0108d52c86fd2a293d5af595"
        ),
        .target(
            name: "ULinkMediatomAdapterWrapper",
            dependencies: [
                "ULinkMediatomAdapterBinary",
                .product(name: "ULinkAD", package: "ULinkAD-ios")
            ]
        )
    ]
)
