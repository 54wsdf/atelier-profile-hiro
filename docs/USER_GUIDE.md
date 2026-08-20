# HIRO2026 第三方模板使用说明

`atelier-profile-hiro` 是维护者个人发起、面向 [篠泽广研讨会（HIRO2026）](https://idol-master.top/sites/hiro2026) 的第三方非官方 LaTeX 支援项目。本项目不是官方模板，与 HIRO2026 官方、活动主办方、`idol-master.top`、《偶像大师》官方及相关权利方无隶属、委托、合作或代表关系。本说明只介绍模板本身；活动日程、征稿要求、投稿方式与最终规则请以活动页面为准。

## 1. 环境与目录

推荐环境：

- AtelierTeX；
- 本仓库；
- XeLaTeX（默认推荐，用于规范发布 PDF、分页基准与 README 预览）；
- LuaLaTeX（兼容性检查）；
- `latexmk`；
- `biber`；
- Poppler（需要生成 README 预览时使用 `pdftoppm`）。

推荐目录：

```text
workspace/
├── AtelierTeX/
└── atelier-profile-hiro/
```

精确依赖版本见 [`../DEPENDENCY_LOCK.md`](../DEPENDENCY_LOCK.md)。

## 2. 文档入口

```latex
\documentclass[titlelayout=feature]{hiro2026}
```

`hiro2026.cls` 加载 AtelierTeX 的 `editorial` profile，再叠加 HIRO2026 的 publication identity、章节、叙事和参考文献视觉。

标题页提供三个并列选择：

```latex
\documentclass[titlelayout=feature]{hiro2026}    % 专题封面
\documentclass[titlelayout=symposium]{hiro2026} % 研讨会刊页
\documentclass[profile=essay,titlelayout=essay]{hiro2026} % 随笔刊页
```

`feature` 适合独立封面和专题展示；`symposium` 适合在首页集中呈现活动信息、稿件编号、作者与摘要；`essay` 适合文化随笔、观察札记和叙事型长文。`titlelayout=v08` 是 `symposium` 的兼容名称，可继续主动选择。未来新增排版继续使用 AtelierTeX 标题页注册表，HIRO 只映射元数据与资产。

随笔刊页可以增加 deck：

```latex
\HIRODeck{一句承担阅读入口、而非摘要功能的导语。}
```

## 3. 题名与元数据

```latex
\HIROPaperType{Research Essay}
\HIROPaperID{HIRO2026-XXX}
\HIROShortTitle{篠泽广研究短标题}
\HIROKicker{SHINOSAWA HIRO / LONGFORM}

\title{关于篠泽广的跨媒介研究示例}
\HIROSubtitle{——副标题}
\HIROEnglishTitle{A Cross-media Study of Shinosawa Hiro}

\author{作者名}
\HIROAffiliation{单位 / 社团 / 研究机构}
\HIROContact{email@example.com}
\HIROAuthorNote{可选的版本、语言与引文说明}
```

`\HIROShortTitle` 用于后续页页眉，建议保持简短。

模板默认刊头以 HIRO2026 / 篠泽广研讨会为主题，并明确标记为第三方非官方支援项目。模板中的活动文字仅用于排版示例，不构成官方信息；若活动页面调整正式英文名、日期或视觉信息，请以活动页面为准。

## 4. 章节结构

默认中文编号：

```text
一、一级标题
（一）二级标题
1. 三级标题
```

正文继续使用标准 LaTeX：

```latex
\section{问题的提出}
\subsection{材料与方法}
\subsubsection{分析单位}
```

## 5. 引文与核心句

分析引文：

```latex
\begin{hiroquote}
短原文或关键句。
\hiroquotesource{来源说明}
\end{hiroquote}
```

Pull quote：

```latex
\begin{hiropullquote}
这里放置章节中的核心命题。
\end{hiropullquote}
```

编辑注：

```latex
\begin{hironote}[METHOD]
这里可以放概念定义、证据边界、media tag 或 locator 说明。
\end{hironote}
```

## 6. 叙事环境

场景：

```latex
\begin{HiroScene}{示例场景}{STEP / EPISODE}
这里放场景化转述或分析性叙事。
\end{HiroScene}
```

幕间：

```latex
\begin{HiroInterlude}{幕间标题}
用于章节之间的强转场。
\end{HiroInterlude}
```

对话：

```latex
\begin{HiroDialogue}
\HiroSpeaker{角色 A}
第一段对话。

\HiroSpeaker{角色 B}
第二段对话。
\end{HiroDialogue}
```

题辞与尾声：

```latex
\begin{HiroEpigraph}{来源}
题辞正文。
\end{HiroEpigraph}

\begin{HiroCoda}
尾声正文。
\end{HiroCoda}
```

这些环境与 `section/subsection` 并行工作，用于在研究性长文中容纳剧情材料、人物对白与编辑型转场。

## 7. 多语种

多语种后端来自 AtelierTeX。推荐角色：

- 简体中文正文 → SC；
- 繁体中文正文 → TC；
- 日文 primary text → JP；
- 中文来源说明与译文 → SC；
- 英文理论、标题与术语 → Latin。

```latex
\begin{HiroOriginal}[ja]
ここに短い日本語原文を入れます。
\end{HiroOriginal}

\begin{HiroTranslation}
这里放对应的中文译文。
\end{HiroTranslation}
```

正式文章中的原文应由作者自行核对作品本体或官方来源。

## 8. 图片与截图

视觉材料可以包括游戏截图、官方角色页、卡面、PV/MV 画面、作者自绘分析图等。模板负责图片与图注的正式页面表现；素材来源、使用权限与必要的 locator 由作者根据具体文章处理。

建议在图注中记录：

- 作品 / 页面名称；
- route / STEP / episode / chapter；
- 卡面、PV、Live 或页面定位；
- 必要时记录 timestamp 与访问日期。

## 9. 参考文献

HIRO2026 通过 AtelierTeX 使用 ATX-ACGN-REF。正式目标基线为 GB/T 7714-2025，实际样式由当前 TeX 环境决定，并可通过 `\AtelierActualGBStyle` 查看。

稿件添加：

```latex
\addbibresource{references.bib}
```

正文：

```latex
作品本体见 \cite{gakumas_game}，角色官方资料见 \cite{hiro_character_file}。
```

文末：

```latex
\HIROReferenceLegend
\printbibliography
```

Media tag 使用 `verba`：

```bibtex
verba = {GAME}
verba = {CHARACTER FILE}
verba = {COMM · STEP1/EP08}
verba = {ANIME · EP01}
verba = {MANGA · CH01}
verba = {MUSIC · TRACK}
verba = {LIVE · STAGE}
```

更多说明见 [`BIBLIOGRAPHY.md`](BIBLIOGRAPHY.md) 与 [`../examples/references.bib`](../examples/references.bib)。

## 10. 刊头图与资产

默认刊头图位于：

```text
assets/hiro2026-logo.png
```

它是 HIRO2026 publication identity 的图形刊头，也是三种标题页视觉层级的一部分。公开样张测试要求真实文件存在并被加载；普通作者工程在文件缺失时仍可使用文字 `HIRO2026` fallback。

刊头图是可替换的 publication slot。需要使用经确认可分发的会议宣传图或自定义头图时，可以在正文导言区设置：

```latex
\HIROSetMastheadImage{assets/my-approved-masthead.png}
\HIROSetMastheadImageWidth{39mm}
```

`\HIROSetMastheadImageWidth` 用于调整 `symposium` 与 `essay` 左上刊头中的显示宽度；`feature` 会按专题封面宽度使用同一资产。更换素材时应同时检查图像来源、再分发条件和实际页面留白。

其他默认资产：

```text
assets/hiro2026-mark.png
```

模板同时支持相邻仓库与 vendor / submodule 布局，并提供文本 fallback。资产说明见 [`../assets/README.md`](../assets/README.md)。

## 11. 编译、测试与 README 渲染

两个引擎都受支持，但职责不同：XeLaTeX 是规范发布与视觉基准；LuaLaTeX 用于确认内容、引用、命令和字形在另一后端中仍然完整。双引擎分页可以不同，仓库预览不得改由 LuaLaTeX 生成。

组件级编译：

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine xelatex
pwsh -File tests/compile-smoke.ps1 -Engine lualatex
pwsh -File tests/compile-smoke.ps1 -Engine both
```

测试会清理旧输出、加载相邻 AtelierTeX，并检查常见编译错误与缺字问题。

README 首页预览必须从真实模板编译出的 PDF 生成：

```powershell
pwsh -File tests/render-readme-preview.ps1 -Engine xelatex
```

该脚本分别编译 `feature`、`symposium` 与 `essay`，再使用 Poppler 从各自 PDF 第一页生成 240 dpi、白底 RGB PNG，并逐图检查 A4 像素尺寸、色彩类型和完整解码。

## 12. 视觉修改导航

| 修改对象 | 文件 |
| --- | --- |
| 标题页公共骨架与排版注册表 | AtelierTeX `atelier/core.sty` |
| HIRO 刊头资产与元数据映射 | `hiro/hiro-layout-editorial.sty` / `hiro/hiro-core.sty` |
| 页边距、章节、页眉页脚 | `hiro/hiro-core.sty` |
| 引文、幕间、场景、对白 | `hiro/hiro-narrative.sty` |
| 图像与图注 | `hiro/hiro-figures.sty` |
| 表格 | `hiro/hiro-tables.sty` |
| 参考文献标签 renderer | `hiro/hiro-bibliography.sty` |
| 字体探测 | AtelierTeX `fonts.sty` |
| 简中 / 繁中 / 日文语义 | AtelierTeX `languages.sty` |

## 13. 发布前检查

- 对照 HIRO2026 活动页面确认仍适用的活动信息；
- 检查作者、标题、单位与联系方式；
- 检查刊头图已从真实资产加载，且没有退回文字 fallback；
- 检查多语种字体和原文；
- 核对游戏剧情、角色页、音乐、Live 等 locator；
- 检查 media tag 与 GB/T 7714 输出；
- 检查图片来源与图注；
- 完成 XeLaTeX / LuaLaTeX 编译；
- 重新生成 README PNG，并确认白底、无透明外框、无黑边；
- 人工检查首页、章节转场和参考文献页。
