# atelier-profile-hiro

<p align="center">
  <img src="assets/hiro2026-logo.png" alt="HIRO2026" width="560">
</p>

> **由维护者个人发起、面向篠泽广研讨会（HIRO2026）的第三方非官方 LaTeX 支援项目。当前发行版已内置经过锁定验证的 AtelierTeX 0.5.3 运行时，普通使用者只需下载本仓库。**

<p align="center">
  <strong><a href="https://idol-master.top/sites/hiro2026">HIRO2026 活动 / 研讨会页面</a></strong>
  · <a href="https://github.com/54wsdf/AtelierTeX">AtelierTeX 上游项目</a>
  · <a href="examples/profile-demo.tex">示例源码</a>
</p>

`atelier-profile-hiro` 完全由维护者个人发起和维护，仅为 HIRO2026 相关写作、排版与投稿准备提供工具支援。本项目不是官方模板，与 HIRO2026 官方、活动主办方、`idol-master.top`、《偶像大师》官方及相关权利方无隶属、委托、合作或代表关系。HIRO2026 Logo 发布方已[公开说明](https://www.xiaohongshu.com/explore/6a82f39c00000000080104dc)可自由取用 Logo 进行使用或创作；该许可不构成活动方对本项目的官方认可。

活动日程、征稿要求、投稿方式以及最终规则请以 **[HIRO2026 活动页面](https://idol-master.top/sites/hiro2026)** 为准；本仓库不发布或解释官方规则。

## 项目定位

这个仓库是基于 AtelierTeX 制作的活动主题排版扩展。为了让它可以作为真正的单仓库模板直接交给其他作者，从 1.3.0 起，HIRO2026 所需的 AtelierTeX 运行时已经直接随本仓库分发：

```text
atelier-profile-hiro
├── atelier.cls            # 内置 AtelierTeX 0.5.3 类入口
├── atelier/               # 内置通用排版、字体、语言、书目等运行时
├── profiles/              # HIRO 实际使用的 editorial / essay profile
├── hiro2026.cls           # HIRO2026 publication class
├── hiro/                  # HIRO2026 publication modules
├── assets/                # HIRO2026 Logo / Mark
└── examples/              # 可直接编译样张
```

概念上的分层仍保持不变：

```text
AtelierTeX 公共语义
字体 · 多语种 · 基础布局 · 叙事语义 · ATX-ACGN-REF
        ↓
atelier-profile-hiro
刊头 · 标题页 · 章节视觉 · HIRO 叙事环境 · 会议主题书目呈现
        ↓
使用者的 HIRO2026 文稿
正文 · 图像 · 数据 · 论证 · 参考文献条目
```

| 层级 | 负责内容 |
| --- | --- |
| 内置 AtelierTeX 运行时 | 多语种长篇 LaTeX 基础框架；字体、语言、基础语义、通用排版能力与 ATX-ACGN-REF |
| `atelier-profile-hiro` | HIRO2026 publication identity、刊头、标题页、叙事块与参考文献呈现 |
| 使用者文稿 | 使用模板完成文章；正文和研究材料由使用者自行管理 |

上游 AtelierTeX 仍独立维护；本仓库内置的是明确 commit 的运行时快照。来源和升级规则见 [`DEPENDENCY_LOCK.md`](DEPENDENCY_LOCK.md)。普通作者不需要再 clone 第二个仓库。

## 三种平行标题页排版

三种排版各自真实编译并保存独立渲染图；未来新增排版沿用同一注册机制。

| 名称 | 选择方式 | 适用问题 |
| --- | --- | --- |
| `feature` / 专题封面 | `titlelayout=feature` | 独立封面、公开长文、专题文章与展示页 |
| `symposium` / 研讨会刊页 | `titlelayout=symposium` | 投稿样张、会议论文与首页信息密度较高的文稿 |
| `essay` / 随笔刊页 | `profile=essay,titlelayout=essay` | 文化随笔、观察札记与叙事型长文 |

### Feature / 专题封面

<p align="center">
  <img src="docs/assets/rendered/hiro2026-feature-page1.png" alt="HIRO2026 Feature title layout" width="900">
</p>

### Symposium / 研讨会刊页

<p align="center">
  <img src="docs/assets/rendered/hiro2026-symposium-page1.png" alt="HIRO2026 Symposium title layout" width="900">
</p>

### Essay / 随笔刊页

<p align="center">
  <img src="docs/assets/rendered/hiro2026-essay-page1.png" alt="HIRO2026 Essay title layout" width="900">
</p>

`symposium` 使用图形刊头、右侧活动信息与紧凑题名层级；`essay` 增加 deck 与叙事照片接口，并继续使用相同的章节、图表和书目体系。`titlelayout=v08` 作为 `symposium` 的兼容名称持续可用。

默认图形刊头位可以替换为经过确认可分发的宣传图或其他 publication masthead：

```latex
\HIROSetMastheadImage{assets/my-approved-masthead.png}
\HIROSetMastheadImageWidth{39mm}
```

## 快速开始：只下载一个仓库

```bash
git clone https://github.com/54wsdf/atelier-profile-hiro.git
cd atelier-profile-hiro
```

不需要 `git clone 54wsdf/AtelierTeX`，也不需要把两个仓库摆成兄弟目录。

最小文档：

```latex
\documentclass[titlelayout=feature]{hiro2026}
\addbibresource{references.bib}

\HIROPaperType{Research Essay}
\HIROPaperID{HIRO2026-XXX}
\HIROShortTitle{短标题}
\HIROKicker{SHINOSAWA HIRO / LONGFORM}
\title{文章标题}
\HIROSubtitle{副标题}
\HIROEnglishTitle{English Title}
\author{作者}
\HIROAffiliation{单位 / 社团 / 研究机构}
\HIROContact{email@example.com}

\begin{document}
\maketitle
正文……
\end{document}
```

切换研讨会刊页：

```latex
\documentclass[titlelayout=symposium]{hiro2026}
```

切换随笔刊页与随笔正文节奏：

```latex
\documentclass[profile=essay,titlelayout=essay]{hiro2026}
\HIRODeck{一句承担阅读入口、而非摘要功能的导语。}
```

完整用法见 [`docs/USER_GUIDE.md`](docs/USER_GUIDE.md)。

## PDF 与 README 图像渲染

生成 README 首页图：

```powershell
pwsh -File tests/render-readme-preview.ps1 -Engine xelatex
```

脚本执行：

```text
当前仓库内置 AtelierTeX 运行时 + hiro2026.cls + HIRO2026 真实资产
        ↓
profile-demo.tex                  → feature PDF
profile-demo-symposium.tex       → symposium PDF
profile-demo-essay.tex            → essay PDF
        ↓
pdftoppm：各自第一页 / 240 dpi / opaque RGB PNG
        ↓
hiro2026-feature-page1.png
hiro2026-symposium-page1.png
hiro2026-essay-page1.png
```

测试会确认 `assets/hiro2026-logo.png` 实际进入构建日志，避免缺图时的文字 fallback 被误当成正式渲染。

## 跨媒介参考文献

模板通过内置 AtelierTeX 使用 ATX-ACGN-REF，在 GB/T 7714 正式条目前显示短 media tag。正式目标基线为 GB/T 7714-2025，实际加载样式可由 `\AtelierActualGBStyle` 查询。

```bibtex
@software{gakumas_game,
  author  = {{Bandai Namco Entertainment Inc.}},
  title   = {学園アイドルマスター},
  date    = {2024-05-16},
  url     = {https://gakuen.idolmaster-official.jp/},
  verba   = {GAME},
  langid  = {japanese}
}
```

正文使用 `\cite{...}`，文末可以加入：

```latex
\HIROReferenceLegend
\printbibliography
```

详细规范见 [`docs/BIBLIOGRAPHY.md`](docs/BIBLIOGRAPHY.md)。公共 ACGN 引用规范的上游版本由 AtelierTeX 维护，本仓库发布时固定同步到 [`DEPENDENCY_LOCK.md`](DEPENDENCY_LOCK.md) 所列 commit。

## 编译与测试

推荐使用 TeX Live 2026、XeLaTeX、LuaLaTeX、`latexmk`、`biber`；生成 README 预览还需要 Poppler / `pdftoppm`。

默认推荐 **XeLaTeX**：规范发布 PDF、分页基准以及仓库中的三张 README 预览均由 XeLaTeX 生成。**LuaLaTeX** 用于兼容性检查，验证内容、引用、命令与字形完整；不要求它与 XeLaTeX 产生完全相同的分页。

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine xelatex
pwsh -File tests/compile-smoke.ps1 -Engine lualatex
pwsh -File tests/compile-smoke.ps1 -Engine both
pwsh -File tests/render-readme-preview.ps1 -Engine xelatex
```

`compile-smoke.ps1` 明确检查本仓库中的 `atelier.cls`、`atelier/` 与 `profiles/`，不再寻找 `../AtelierTeX`。

## 仓库结构

```text
atelier-profile-hiro/
├── atelier.cls               # 内置 AtelierTeX 0.5.3 运行时入口
├── atelier/                  # 内置 AtelierTeX 公共运行时模块
├── profiles/                 # 内置 editorial / essay profile
├── hiro2026.cls              # HIRO2026 文档类入口
├── hiro/                     # HIRO2026 publication modules
├── assets/                   # Logo / Mark 与可替换刊头资产
├── examples/                 # 可编译公开样张
├── docs/                     # 使用、模块、书目与渲染说明
├── tests/                    # 编译和 README 渲染脚本
├── PROJECT.md
├── CONTRIBUTING.md
├── CITATION.cff
├── LICENSE
├── LICENSE_SCOPE.md
├── LICENSES/
├── manifest.txt
├── DEPENDENCY_LOCK.md
└── CHANGELOG.md
```

## 非官方支援项目声明

本项目纯属维护者个人兴趣发起的第三方支援项目，与 HIRO2026 官方及活动主办方没有关系。HIRO2026 活动信息请直接查阅 **[活动页面](https://idol-master.top/sites/hiro2026)**；本仓库不复制可能变化的征稿日期、活动安排或提交规则。

项目名称、作品名称、角色名称与相关商标归各自权利人所有。模板源码与文档采用 LPPL-1.3c；Logo、Mark 及含图预览按公开 Logo 使用与创作许可单独处理。完整边界见 [`LICENSE_SCOPE.md`](LICENSE_SCOPE.md)、[`manifest.txt`](manifest.txt)、[`LICENSE`](LICENSE) 与 [`LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt`](LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt)。

## 文档索引

- [`DEPENDENCY_LOCK.md`](DEPENDENCY_LOCK.md)：内置 AtelierTeX 来源、版本与升级规则；
- [`PROJECT.md`](PROJECT.md)：项目定位与第三方状态；
- [`CONTRIBUTING.md`](CONTRIBUTING.md)：公开贡献范围、构建与许可检查；
- [`docs/USER_GUIDE.md`](docs/USER_GUIDE.md)：完整使用说明；
- [`docs/MODULES_AND_STYLING.md`](docs/MODULES_AND_STYLING.md)：模块与样式职责；
- [`docs/BIBLIOGRAPHY.md`](docs/BIBLIOGRAPHY.md)：GB/T 7714 + ATX-ACGN-REF；
- [`hiro/README.md`](hiro/README.md)：HIRO 模块说明；
- [`examples/README.md`](examples/README.md)：样张说明；
- [`tests/README.md`](tests/README.md)：测试说明；
- [`docs/assets/rendered/README.md`](docs/assets/rendered/README.md)：README 图像生成规则；
- [`assets/README.md`](assets/README.md)：视觉资产与权利边界；
- [`LICENSE_SCOPE.md`](LICENSE_SCOPE.md)：分层许可范围与非官方状态；
- [`CITATION.cff`](CITATION.cff)：项目引用元数据。
