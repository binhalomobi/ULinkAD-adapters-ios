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
            url: "https://github.com/binhalomobi/ULinkAD-adapters-ios/releases/download/1.1.0/ULinkMediatomAdapter-1.0.1.zip",
            checksum: "07b335aced8dedd21414f24db5b439ee37dba324892577a3ff5e69c252bbb5c5"
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
            url: "https://github.com/binhalomobi/ULinkAD-adapters-ios/releases/download/1.1.0/ULinkTakuAdapter-1.0.0.zip",
            checksum: "ad5e7b4e8fd8052fe8d940152f31b4f30e43b175ca2ba853d3a66a835184cad6"
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
