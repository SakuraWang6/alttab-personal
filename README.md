# AltTab Personal

基于 [lwouis/alt-tab-macos](https://github.com/lwouis/alt-tab-macos) 的独立自用分支，保留上游窗口切换功能和 GPL-3.0 许可。

此分支长期提供窗口搜索、缩略图 / 图标 / 标题列表、自适应面板大小、多组快捷键及搜索相关快捷键。无需账号、密钥、试用计时或在线激活。应用名称为 **AltTab Personal**，Bundle ID 为 `local.alttab.personal`，配置与官方版分开保存。

官方自动更新、授权验证、崩溃上传和反馈上传在此分支中停用；后续更新由源码重新编译。此项目是修改过的独立构建，不代表上游项目或官方 Pro 许可。

## 安装与使用

1. 打开 DMG，将 **AltTab Personal.app** 拖入“应用程序”。
2. 如正在运行官方 AltTab，先退出它，避免快捷键冲突。
3. 启动后，在系统设置的“隐私与安全性”中，允许 **AltTab Personal** 使用“辅助功能”和“屏幕录制”。仅切换窗口可跳过录屏，但缩略图需要此权限。
4. 默认使用 **Option + Tab** 切换窗口；在“设置 → 控制”中可改为 **Command + Tab**。
5. 切换界面中的搜索、图标 / 标题样式、自动大小和额外快捷键均可直接设置使用。

本地包使用 ad-hoc 签名，没有 Apple Developer ID 公证。从 GitHub 下载后若被系统阻止，请到“系统设置 → 隐私与安全性”选择“仍要打开”。重新编译后 macOS 可能要求重新授予权限。

## 从源码构建

需要 macOS 与完整的 Xcode。依赖均保存在 `vendor/`，无需额外安装软件包。运行：

```sh
bash scripts/build_personal.sh
```

脚本检查生成资源，构建 arm64 + x86_64 Universal Release，并使用 ad-hoc 本地签名验证产物。输出在 `.personal-build/DerivedData/Build/Products/Release/AltTab Personal.app`。它不修改钥匙串，不安装应用，不上传公证，也不使用上游开发者证书。

上游回归测试和自用版长期启用 / 无授权 I/O 测试：

```sh
bash ai/test.sh
```

## 来源及许可

初始上游提交：`2d4f4c8fab1eeb3ec08f32abdf541713b68d89d0`。

主要修改为独立产品标识、自用版功能状态、停用官方在线服务、界面说明及本地构建脚本。窗口枚举、切换、搜索和视图实现来自上游；版权及第三方致谢保留于应用和源码中。

本分支使用 [GPL-3.0](LICENCE.md)。第三方依赖保留各自的许可，见 `vendor/` 与应用“致谢”。
