# 项目定位

`atelier-profile-hiro` 是维护者个人发起、面向 **篠泽广研讨会（HIRO2026）** 的第三方非官方 LaTeX 支援项目。

活动页面：<https://idol-master.top/sites/hiro2026>

本项目仅为活动主题长文提供排版、叙事结构与跨媒介参考文献支持。它不是官方模板，与 HIRO2026 官方、活动主办方、`idol-master.top`、《偶像大师》官方及相关权利方无隶属、委托、合作或代表关系。活动日程、征稿要求、投稿方式和最终规则以活动页面公布的信息为准。

仓内 `hiro2026-logo.png` 与 `hiro2026-mark.png` 已获原作者许可，可进行二次创作并用于本项目公开展示和模板分发。该许可只解决本项目中的素材使用，不赋予项目官方身份，也不自动扩展为作品、角色或商标的其他许可。

## 与 HIRO2026 的关系

本仓库专门围绕 HIRO2026 的写作与展示场景开发，包括：

- HIRO2026 主题刊头与标题页；
- A4 长文、章节、页眉页脚的 publication presentation；
- `HiroScene`、`HiroInterlude`、`HiroDialogue`、`HiroEpigraph` 等叙事环境；
- 针对游戏剧情、角色档案、音乐、Live、动画、漫画等材料的跨媒介书目呈现；
- 示例中使用篠泽广与《学园偶像大师》相关公开资料展示实际引用方式。

本仓库不是 HIRO2026 官方模板，也不代表 `idol-master.top`、活动主办方或《偶像大师》官方。它纯属维护者个人制作的排版支援工具，不在仓库中复制或解释活动规则。

## 与 AtelierTeX 的关系

[AtelierTeX](https://github.com/54wsdf/AtelierTeX) 是面向 ACGN / 二次元 / 跨媒介人文研究的多语种长篇 LaTeX 基础框架。它维护可复用的字体、多语种、基础布局、叙事语义、图表语义与 ATX-ACGN-REF 跨媒介引用能力。

`atelier-profile-hiro` 是 AtelierTeX 的下游排版扩展：

```text
AtelierTeX
通用基础框架
        ↓
atelier-profile-hiro
HIRO2026 非官方支援排版扩展
        ↓
作者自己的 HIRO2026 文稿
```

职责划分：

| 层 | 职责 |
| --- | --- |
| AtelierTeX | 通用 ACGN 语义、字体、多语种、长文布局、图表、基础叙事、ATX-ACGN-REF |
| HIRO2026 扩展 | 活动主题刊头、标题页、章节视觉、HIRO 叙事环境与参考文献呈现 |
| 作者文稿 | 正文、论证、图像、数据、引用条目和作者自己的研究材料 |

可被多个项目复用的能力应优先进入 AtelierTeX；仅服务 HIRO2026 publication identity 或视觉呈现的功能保留在本仓库。

## 仓库范围

本仓库保存：

- `hiro2026.cls` 与 HIRO 专用 `.sty`；
- 可编译的公开 specimen 源文件；
- 文档与测试脚本；
- 可随模板分发的视觉资产；
- 由 specimen PDF 实际输出生成的 README 渲染预览图。

本仓库不保存作者实际稿件、稿件专属书目或内部工作记录。

使用者的文章正文、研究资料以及仅服务某一篇具体文章的内容不属于模板仓库。

## 第三方状态与名称

“THE IDOLM@STER”“学園アイドルマスター”“篠澤 広 / 篠泽广”等作品、角色、项目名称与相关商标归各自权利人所有。它们在本仓库中用于说明模板适用场景、提供主题示例与标识引用对象。

模板源码许可见 [`LICENSE`](LICENSE)。视觉资产及第三方素材的说明见 [`assets/README.md`](assets/README.md)。

## 维护者

当前维护者：**54wsdf**

- HIRO2026 profile：<https://github.com/54wsdf/atelier-profile-hiro>
- AtelierTeX：<https://github.com/54wsdf/AtelierTeX>
