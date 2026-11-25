# ULinkAD-adapters-ios

ULinkAD 聚合 SDK 的第三方 Mediation 适配器（二进制 xcframework 分发）。

## 包含的适配器

| 适配器 | CocoaPods | SPM 产品 | 依赖 |
|---|---|---|---|
| Mediatom | `ULinkMediatomAdapter` 1.0.2 | `ULinkMediatomAdapter` | ULinkAD 2.0.2、MediatomiOS |
| TopOn(Taku) | `ULinkTakuAdapter` 1.0.1 | `ULinkTakuAdapter` | ULinkAD 2.0.2、AnyThinkiOS 6.5.84 |

> 适配器头文件已私有化：`ULinkXxxAdapter` 模块不暴露任何 Mediation SDK 头文件，SPM 下无需为适配器配置 Framework Search Paths。适配器实现类由 Mediation 平台在运行时按类名反射创建。

## CocoaPods 接入（推荐）

```ruby
pod 'ULinkAD', '2.0.2'

# 按需二选一或都接
pod 'ULinkMediatomAdapter', '1.0.2'
pod 'ULinkTakuAdapter', '1.0.1'
```

每个适配器会自动带上自己的 `ULinkAD` 与 Mediation SDK 依赖，`-ObjC` 也已通过 podspec 自动注入，无需任何额外配置。

## SPM 接入

```swift
.package(url: "https://github.com/binhalomobi/ULinkAD-adapters-ios.git", from: "1.2.0")
```

在 target 的 **Frameworks, Libraries, and Embedded Content** 中只添加你实际使用的那一个产品：`ULinkMediatomAdapter` 或 `ULinkTakuAdapter`。没添加的产品不会被链接，`ULinkAD` 会随任一产品自动引入，**无需**再单独添加。

### SPM 下仍需你自己完成的事

适配器只包含桥接代码，Mediation 平台自身的 SDK 无法由 SPM 声明，需要你按平台方式接入：

| 平台 | 需要接入的 SDK | 说明 |
|---|---|---|
| Mediatom | `MSaas.xcframework` | 从 Mediatom 离线包或 `Pods/MediatomiOS` 获取，设为 Do Not Embed |
| TopOn(Taku) | `AnyThinkSDK.xcframework` | 从 TopOn 离线包或 `Pods/AnyThinkiOS` 获取，设为 Do Not Embed，另需按需引入各广告平台 adapter |

此外必须在 target 的 **Build Settings → Other Linker Flags** 中添加：

```
-ObjC
```

（注意大小写，是 `-ObjC` 而不是 `-objc`）

适配器是静态库，适配器类由 Mediation 平台在运行时按类名反射创建，工程里没有代码直接引用它们。缺少 `-ObjC` 时链接器会把它们当作无用代码裁掉，表现为**编译通过、运行时不报错但广告始终不填充**。

## 常见问题

| 现象 | 原因 | 解决 |
|---|---|---|
| 链接 `Undefined symbol: _OBJC_CLASS_$_ATBaseMediationAdapter` | 未接入 TopOn SDK | 引入 `AnyThinkSDK.xcframework`（Taku 本身也必须集成） |
| 链接 `Undefined symbol: _OBJC_CLASS_$_MSaas...` | 未接入 Mediatom SDK | 引入 `MSaas.xcframework` |
| 运行时不报错但广告不填充 | 缺少 `-ObjC`，适配器类被裁掉 | 在 Other Linker Flags 添加 `-ObjC` 后清理重编 |
| `duplicate symbol` 链接错误 | Mediation SDK 被设为 Embed，或同时存在两份 | 改为 Do Not Embed，并删除重复副本 |
| Swift Package 解析失败 | 网络无法访问 GitHub | 配置代理后 File → Packages → Reset Package Caches |

## 要求

- iOS 12.0+
- Xcode 14+

## License

Commercial. 版权归 Halomobi 所有，未经授权不得分发。
