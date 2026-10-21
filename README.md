# PCL 下载修复版

本项目是第三方基于 [Plain Craft Launcher（PCL）](https://github.com/Meloong-Git/PCL) 独立修改的产物。原作者为龙腾猫跃；本修改版不代表原作者或官方发布。

- [支持原作者龙腾猫跃](https://meloong.com/afd/a/LTCat)
- [修改版源码](https://github.com/hanzhangsan/PCL/tree/main)
- 保留并遵循原仓库的 [LICENCE](LICENCE) 及其链接的《PCL 分发有限许可》和《PCL 存储库合理使用指南》；不将本项目重新许可为 MIT、GPL 或 CC BY-SA。
- 修改内容：恢复 Minecraft 下载入口，禁用启动器更新，明确第三方修改版标识。保留蓝色主题、原作者署名和赞助链接，以及 `McLaunchPrecheck` 中的正版购买与赞助劝导。

## 构建与使用

需要 Windows 和 .NET Framework 4.8。

1. 打开修改版的 [Releases 下载页](https://github.com/hanzhangsan/PCL/releases/latest)，下载 `PCL-Download-Fix-Release.zip`。
2. 完整解压后运行 `PCL 下载修复版.exe`。开发构建也可从 [main 分支的 Build 工作流](https://github.com/hanzhangsan/PCL/actions/workflows/build.yml?query=branch%3Amain) 中下载 Release 产物，下载 Actions 产物可能需要登录 GitHub。
3. 保留同目录中的 DLL、`PCL 下载修复版.exe.config`、许可及说明文件；可根据 `SHA256.txt` 校验程序。

程序不会自动更新，请从上面的修改版源码仓库手动获取新版本。Minecraft 版本列表刷新、游戏更新提示和游戏文件下载仍然保留。这里只提供修改版构建说明，下方上游介绍中的下载链接指向原作者发布的程序。

微软登录需要自行申请 Client ID，并在运行前配置环境变量 `PCL_MS_CLIENT_ID`。CurseForge 功能类似，需要 `PCL_CURSEFORGE_API_KEY`；下载原版 Minecraft 不需要这两个值。工作流不嵌入仓库机密。

修改版源码、原 LICENCE、依赖许可及构建提交信息随程序包提供。Actions 编译成功不等于已完成游戏下载测试；实际验证结果以工作流日志和交付说明为准。

## 从源码构建与验证

使用 Visual Studio 2022 的 MSBuild、.NET SDK 9（C# 13）和 .NET Framework 4.8 开发包，在仓库根目录运行：

```powershell
git submodule update --init --recursive
dotnet restore PCLCS/PCLCS.csproj
msbuild "Plain Craft Launcher 2/Plain Craft Launcher 2.vbproj" -p:Configuration=Release
```

`MeloongCore` 使用仓库记录的固定提交，其 Apache 2.0 许可单独保留，不改变 PCL 自身的许可。

Build 工作流只编译 Debug 和 Release、打包，并验证 `--update` 在没有其他参数时直接退出、不会替换程序；CI/CD 不执行 Minecraft 下载测试。

`.github/scripts/verify-download.ps1` 保留为可选的手动下载验证工具，不由工作流调用。它通过 PCL 原版下载加载器安装 Minecraft 1.20.1，下载客户端、支持库和资源，并检查客户端、资源索引及全部资源的 SHA-1。此工具不涵盖微软登录、实际启动游戏或所有第三方模组加载器。

---

以下保留上游项目介绍。

# Plain Craft Launcher

[![Stars](https://img.shields.io/github/stars/Meloong-Git/PCL?style=flat&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEiIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiI+PHBhdGggZD0iTTggLjI1YS43NS43NSAwIDAgMSAuNjczLjQxOGwxLjg4MiAzLjgxNSA0LjIxLjYxMmEuNzUuNzUgMCAwIDEgLjQxNiAxLjI3OWwtMy4wNDYgMi45Ny43MTkgNC4xOTJhLjc1MS43NTEgMCAwIDEtMS4wODguNzkxTDggMTIuMzQ3bC0zLjc2NiAxLjk4YS43NS43NSAwIDAgMS0xLjA4OC0uNzlsLjcyLTQuMTk0TC44MTggNi4zNzRhLjc1Ljc1IDAgMCAxIC40MTYtMS4yOGw0LjIxLS42MTFMNy4zMjcuNjY4QS43NS43NSAwIDAgMSA4IC4yNVoiIGZpbGw9IiNlYWM1NGYiLz48L3N2Zz4=&logoSize=auto&label=Stars&labelColor=444444&color=eac54f)](https://github.com/Meloong-Git/PCL/)
[![Issues](https://img.shields.io/github/issues/Meloong-Git/PCL?style=flat&label=Issues&labelColor=444444&color=1F883D)](https://github.com/Meloong-Git/PCL/issues)
[![哔哩哔哩](https://img.shields.io/badge/动态-BiliBili-00A4DB?style=flat&labelColor=444444&logoSize=auto)](https://space.bilibili.com/11343203/dynamic)
[![爱发电](https://img.shields.io/badge/赞助-爱发电-946ce6?style=flat&labelColor=444444&logoSize=auto)](https://meloong.com/afd/a/LTCat)

包含 PCL 的大部分源代码，包括 UI 库、动画模块、下载模块、Minecraft 启动模块等！<br/>
代码并不是实时更新的，它会在每次 PCL 发布更新时同步一次。<br/>
非常感谢社区的大力支持！

<br/>

### 相关资源
- [PCL 下载](https://meloong.com/pcl)：下载可免费使用的正式版 PCL！
- [PCL 功能投票](https://github.com/Meloong-Git/PCL/discussions/2)：来参加投票吧，开发者会优先处理票数较高的项目！
- [帮助文档库](https://github.com/LTCatt/PCL2Help)：PCL 内置帮助文档的存储库
