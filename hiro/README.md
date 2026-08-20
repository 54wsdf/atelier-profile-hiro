# `hiro/` 模块说明

`hiro/` 保存本第三方非官方支援模板的排版模块。它们使用 AtelierTeX 的公共语义与字体角色，并提供面向篠泽广研讨会主题长文的标题页、章节视觉、叙事环境、图表和参考文献渲染。

用户入口：

```latex
\documentclass[titlelayout=feature]{hiro2026}
\documentclass[titlelayout=symposium]{hiro2026}
\documentclass[profile=essay,titlelayout=essay]{hiro2026}
```

## 模块一览

| 文件 | 主要作用 |
| --- | --- |
| `hiro-core.sty` | HIRO2026 元数据、A4 参数、配色、章节编号、页眉页脚、Logo 路径 |
| `hiro-fonts.sty` | `Hiro*` 字体别名 |
| `hiro-languages.sty` | 多语种接口 |
| `hiro-narrative.sty` | quote、scene、interlude、dialogue、epigraph、coda |
| `hiro-tables.sty` | 表格视觉 |
| `hiro-figures.sty` | 图片、占位与图注视觉 |
| `hiro-layout-editorial.sty` | 将 HIRO 元数据与刊头资产映射到 AtelierTeX 标题页注册表，并提供摘要 |
| `hiro-layout-essay.sty` | 将 deck、可选头图与随笔照片接口映射到 AtelierTeX |
| `hiro-bibliography.sty` | GB/T 7714 + ATX-ACGN-REF renderer |

## `hiro-core.sty`

基础 publication identity 包括：

- A4 单栏几何；
- `HiroInk`、`HiroGray`、`HiroRule` 等视觉色；
- HIRO2026 / 篠泽广研讨会刊头；
- 第三方模板标识；
- `\HIROPaperType`、`\HIROPaperID`、`\HIROShortTitle`、`\HIROSubtitle` 等文章元数据；
- Logo / Mark 相对路径；
- 中文章节编号；
- `hirostyle` / `hirofirst` 页眉页脚。

## `hiro-fonts.sty`

`HiroSCFamily`、`HiroTCFamily`、`HiroJPFamily`、`HiroSCSans` 等别名映射到 AtelierTeX 的字体角色。公共字体发现与 fallback 由 AtelierTeX 维护。

中文姓名使用 `\HiroNameHans`，日文正式姓名使用 `\HiroNameJapanese`。这两个
语义接口确保共享汉字按内容语种进入同一字体族，避免大字号标题出现单字字重、
字面或基线差异；不要通过替换姓名用字、单字缩放或局部假粗体处理。

## `hiro-languages.sty`

负责 `HiroOriginal`、`HiroTranslation` 等多语种接口与 AtelierTeX 语言层之间的映射。

## `hiro-narrative.sty`

主要环境：

- `hiroquote` + `\hiroquotesource{...}`；
- `hiropullquote`；
- `hironote`；
- `HiroScene`；
- `HiroInterlude`；
- `HiroEpigraph`；
- `HiroDialogue` + `\HiroSpeaker`；
- `\HiroSceneBreak`；
- `HiroCoda`。

这些环境组织长文阅读节奏，并与 `section/subsection` 的论证结构并行。

## `hiro-layout-editorial.sty`

负责把 Logo、publication name、主标题、副标题、英文标题、作者与单位映射到 AtelierTeX 公共标题页槽位，并提供摘要与关键词。`feature`、`symposium`、`essay` 的结构 renderer 位于 AtelierTeX；本模块不保存重复骨架。

新增平行标题页时，先在 AtelierTeX 通过 `\AtelierDeclareTitleLayout` 注册，再让 HIRO 复用同一元数据映射。

## `hiro-bibliography.sty`

HIRO2026 调用 AtelierTeX 的公共 ACGN bibliography semantics，并为 `verba` media tag 提供活动主题下的 renderer。

```bibtex
verba = {GAME}
verba = {COMM · STEP1/EP08}
verba = {MUSIC · TRACK}
```

详细约定见 [`../docs/BIBLIOGRAPHY.md`](../docs/BIBLIOGRAPHY.md)。

## 模板边界

本目录只包含可供作者使用的排版接口与视觉实现，不包含具体文章正文或个人资料。
