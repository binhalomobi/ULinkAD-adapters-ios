# ULinkAD-adapters-ios

ULinkAD 聚合 SDK 的第三方 Mediation 适配器（二进制 xcframework 分发）。

## 包含的适配器

| 适配器 | CocoaPods | SPM 产品 | 依赖 |
|---|---|---|---|
| Mediatom | `ULinkMediatomAdapter` 1.0.1 | `ULinkMediatomAdapter` | ULinkAD 2.0.2、MediatomiOS |
| TopOn(Taku) | `ULinkTakuAdapter` 1.0.0 | `ULinkTakuAdapter` | ULinkAD 2.0.2、AnyThinkiOS 6.5.84 |

## CocoaPods 接入（推荐）

```ruby
pod 'ULinkAD', '2.0.2'

# 按需二选一或都接
pod 'ULinkMediatomAdapter', '1.0.1'
pod 'ULinkTakuAdapter', '1.0.0'
```

每个适配器会自动带上自己的 `ULinkAD` 与 Mediation SDK 依赖，`-ObjC` 也已通过 podspec 自动注入，无需任何额外配置。

## SPM 接入

```swift
.package(url: "https://github.com/binhalomobi/ULinkAD-adapters-ios.git", from: "1.1.0")
```

在 target 的 **Frameworks, Libraries, and Embedded Content** 中只添加你实际使用的那一个产品：`ULinkMediatomAdapter` 或 `ULinkTakuAdapter`。没添加的产品不会被链接，`ULinkAD` 会随任一产品自动引入，**无需**再单独添加。

### 必须手动完成的两步（Mediatom）

Mediatom 官方仅提供 CocoaPods 与离线 framework 两种分发方式，**不支持 SPM**，而适配器的公开头文件引用了其 `MSaas` 模块。因此走 SPM 时以下两步必须手动完成，否则无法编译或适配器不生效。

#### 1. 引入 MSaas.xcframework

获取方式（二选一）：

- 从 Mediatom 官网下载离线 SDK 包，取出 `MSaas.xcframework`
- 或先用 CocoaPods 装一次 `MediatomiOS`，从 `Pods/MediatomiOS/MediatomiOS/MSaas.xcframework` 取出

然后：

1. 把 `MSaas.xcframework` 拖入 Xcode 工程
2. 在 target 的 **General → Frameworks, Libraries, and Embedded Content** 中确认其为 **Do Not Embed**（Mediatom 为静态库，嵌入会导致重复符号）
3. 在 **Build Settings → Framework Search Paths** 中加入该 framework 所在目录，例如：

```
$(PROJECT_DIR)/Frameworks
```

> 如果工程本身已经通过 CocoaPods 接入 `MediatomiOS`，不要重复引入，直接跳到第 2 步。

#### 2. 添加 `-ObjC` 链接参数

在 target 的 **Build Settings → Other Linker Flags** 中添加：

```
-ObjC
```

（注意大小写，是 `-ObjC` 而不是 `-objc`）

这一步不能省略。适配器是静态库，`CustomULink*Manager` 这些类由 Mediatom 在运行时按类名反射创建，工程里没有代码直接引用它们。缺少 `-ObjC` 时链接器会把它们当作无用代码裁掉，表现为**编译通过、运行时不报错但广告始终不填充**。

### 必须手动完成的两步（TopOn / Taku）

TopOn 的 `AnyThinkiOS` 同样只提供 CocoaPods 与离线 framework 分发，SPM 下需要手动补齐：

1. 引入 `AnyThinkSDK.xcframework`（从 TopOn 官方包或 `Pods/AnyThinkiOS` 中获取），设为 **Do Not Embed**，并把所在目录加入 **Framework Search Paths**
2. 在 **Other Linker Flags** 中添加 `-ObjC`（原因同上，`UlinkCustom*Adapter` 类靠反射创建）

> Taku 平台除主 SDK 外还需按需引入各广告平台的 adapter（如 `AnyThink*Adapter`），这部分与是否使用 SPM 无关。

### 常见问题

| 现象 | 原因 | 解决 |
|---|---|---|
| `'MSaas/MSaas.h' file not found` | 未引入 Mediatom SDK，或 Framework Search Paths 未配置 | 按 Mediatom 第 1 步引入并配置搜索路径 |
| `'AnyThinkSDK/AnyThinkSDK.h' file not found` | 未引入 TopOn SDK，或 Framework Search Paths 未配置 | 按 Taku 第 1 步引入并配置搜索路径 |
| 运行时不报错但广告不填充 | 缺少 `-ObjC`，适配器类被裁掉 | 在 Other Linker Flags 添加 `-ObjC` 后清理重编 |
| `duplicate symbol` 链接错误 | Mediation SDK 被设为 Embed，或同时存在两份 | 改为 Do Not Embed，并删除重复副本 |
| Swift Package 解析失败 | 网络无法访问 GitHub | 配置代理后 File → Packages → Reset Package Caches |

## 要求

- iOS 12.0+
- Xcode 14+

## License

Commercial. 版权归 Halomobi 所有，未经授权不得分发。
