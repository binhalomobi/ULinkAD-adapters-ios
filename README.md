# ULinkAD-adapters-ios

ULinkAD 聚合 SDk 的第三方 Mediation 适配器（二进制 xcframework 分发）。

## 包含的适配器

| 适配器 | CocoaPods | SPM 产品 | 依赖 |
|---|---|---|---|
| Mediatom | `ULinkMediatomAdapter` | `ULinkMediatomAdapter` | ULinkAD 2.0.1+、MediatomiOS |

## CocoaPods 接入

```ruby
pod 'ULinkAD', '2.0.1'
pod 'ULinkMediatomAdapter', '1.0.0'
```

`ULinkMediatomAdapter` 会自动带上 `ULinkAD` 与 `MediatomiOS` 依赖，无需手动声明。

## SPM 接入

```swift
.package(url: "https://github.com/binhalomobi/ULinkAD-adapters-ios.git", from: "1.0.0")
```

选择产品 `ULinkMediatomAdapter`。

**前置条件**：适配器的公开头文件引用 Mediatom 的 `MSaas` 模块，而 Mediatom 官方未提供 SPM 分发。使用 SPM 时，需要在工程中另行引入 `MSaas.xcframework`（从 MediatomiOS 的 CocoaPods 产物或官网离线包获取），并：

1. 在 Build Settings → Other Linker Flags 添加 `-ObjC`（Mediatom 官方集成要求）
2. 确保 `MSaas.xcframework` 的路径在 Framework Search Paths 中

CocoaPods 接入方式没有这个额外步骤，推荐优先使用 CocoaPods。

## 要求

- iOS 12.0+
- Xcode 14+

## License

Commercial. 版权归 Halomobi 所有，未经授权不得分发。
