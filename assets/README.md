# `assets/` 视觉资产说明

`assets/` 保存本第三方非官方支援模板使用的 HIRO2026 Logo、Mark 与小型排版资产。

当前入口：

```text
assets/hiro2026-logo.png
assets/hiro2026-mark.png
```

当前 `hiro2026-logo.png` 为 1065×325 不透明 PNG，供 `feature`、`symposium` 与 `essay` 三种标题页排版使用。

`hiro-core.sty` 会在标题页与 masthead 中解析这些文件；找不到图片时使用文本 fallback，因此没有这些视觉资产时仍可完成完整结构编译。

## 使用范围

HIRO2026 Logo 发布方通过公开笔记《HIRO2026——会议logo公开》说明，可自由取用 HIRO2026 Logo 进行使用或创作。公开说明另将发布稿件时携带相关话题表述为自愿建议，并非强制条件。

- 发布账号：`cocop`
- 公开笔记 ID：`6a82f39c00000000080104dc`
- [公开页面](https://www.xiaohongshu.com/explore/6a82f39c00000000080104dc)
- [原始短链接](https://xhslink.cn/o/65PCwRgdHc4)
- 仓库许可记录：[`LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt`](../LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt)

本仓库由维护者个人发起，面向篠泽广研讨会（HIRO2026）的第三方排版需求。上述素材许可不表示本项目获得 HIRO2026 官方、`idol-master.top`、活动主办方、《偶像大师》官方或相关权利方的委托、合作、代表身份或认可。

具体文章使用的游戏截图、卡面、照片、扫描件、PV / MV 画面等由作者自己的文档目录管理，不应作为模板依赖放入本目录。

## 许可证边界

仓库根目录 [`LICENSE`](../LICENSE) 的 LPPL-1.3c 许可适用于 [`manifest.txt`](../manifest.txt) 所列的本项目源码、文档、示例与测试。**该许可不覆盖本目录的 Logo、Mark、含图预览、第三方商标或作品素材。**

本仓库以自定义 SPDX LicenseRef `LicenseRef-HIRO2026-Logo-Public-Use` 忠实记录上述公开使用与创作许可，不将其扩大解释为 CC、LPPL 或其他标准许可证。它不覆盖作品名称、角色名称、其他图像、商标或官方身份。

为便于核验，当前文件摘要为：

- `hiro2026-logo.png`：SHA-256 `3DE69BE0CD0F8C636AFDCAE8F879C30D03CE30A7985467A9A745610C366E45CE`；
- `hiro2026-mark.png`：SHA-256 `A80DA21D875B3807A16065A4EC29B291DE483837F65DA7F6F9D06BA25D2F2B0A`。

> 防退化说明：上述哈希必须由仓内二进制文件直接计算，后续替换或重新导出素材时不得沿用旧值；素材未变化时也不得手工改写哈希。

## 字体

字体二进制不进入本仓库。字体发现、CJK / Japanese 字体角色与 fallback 由 [AtelierTeX](https://github.com/54wsdf/AtelierTeX) 从用户系统和 TeX 环境解析。
