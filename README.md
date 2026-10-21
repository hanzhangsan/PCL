# PCL 下载修复版

本项目是第三方基于 [Plain Craft Launcher（PCL）](https://github.com/Meloong-Git/PCL) 独立修改的产物。原作者为龙腾猫跃；本修改版不代表原作者或官方发布。

- [支持原作者龙腾猫跃](https://meloong.com/afd/a/LTCat)
- [修改版源码](https://github.com/hanzhangsan/PCL/tree/fix/disable-updates-enable-mc-download)
- 保留并遵循原仓库的 [LICENCE](LICENCE) 及其链接的《PCL 分发有限许可》和《PCL 存储库合理使用指南》；不将本项目重新许可为 MIT、GPL 或 CC BY-SA。
- 修改内容：恢复 Minecraft 下载入口，禁用启动器更新，明确第三方修改版标识。保留蓝色主题、原作者署名和赞助链接，以及 `McLaunchPrecheck` 中的正版购买与赞助劝导。

## 构建与使用

在 GitHub Actions 的 Build 工作流下载 Release 构建产物，完整解压后运行 `PCL 下载修复版.exe`。需要 Windows 和 .NET Framework 4.8。程序不会自动更新，请从上面的修改版源码仓库手动获取新版本。

微软登录需要自行申请 Client ID，并在运行前配置环境变量 `PCL_MS_CLIENT_ID`。CurseForge 功能类似，需要 `PCL_CURSEFORGE_API_KEY`；下载原版 Minecraft 不需要这两个值。工作流不嵌入仓库机密。

修改版源码、原 LICENCE、依赖许可及构建提交信息随程序包提供。Actions 编译成功不等于已完成游戏下载测试；实际验证结果以工作流日志和交付说明为准。

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
