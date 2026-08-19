# HIRO2026 模块与样式职责

本项目是维护者个人发起、面向篠泽广研讨会主题长文的第三方非官方排版支援工具，与 HIRO2026 官方及活动主办方无关。它在 AtelierTeX 的公共语义层上增加 HIRO2026 刊头、编辑型长文视觉与 ACGN 参考文献渲染。

## 1. 总体结构

```text
AtelierTeX editorial profile
          ↓
      hiro2026.cls
          ↓
      hiro/*.sty
          ↓
    author document
```

`hiro2026.cls` 是轻量入口，依次加载 AtelierTeX 与 `hiro/` 模块。

## 2. Publication identity

AtelierTeX 维护 `feature`、`symposium`、`essay` 与标题页排版注册表。`hiro-core.sty`、`hiro-layout-editorial.sty` 与 `hiro-layout-essay.sty` 负责向公共骨架注入：

- HIRO2026 / 篠泽广研讨会刊头；
- 第三方模板标识；
- Logo / Mark；
- paper type / ID；
- 标题、副标题、英文标题；
- 作者与单位；
- 页眉页脚；
- HIRO publication metadata 与刊头资产。

公开选择方式：

```latex
\documentclass[titlelayout=feature]{hiro2026}
\documentclass[titlelayout=symposium]{hiro2026}
\documentclass[profile=essay,titlelayout=essay]{hiro2026}
```

未来平行排版由 AtelierTeX 注册 renderer；HIRO 不复制公共标题页结构。

模板的活动相关文字只用于排版识别，不代表官方身份、授权或合作关系。活动正式信息以活动页面为准。

## 3. Editorial reading rhythm

`hiro-narrative.sty`、`hiro-figures.sty`、`hiro-tables.sty` 负责：

- 引文与 pull quote；
- note；
- scene / interlude / dialogue / epigraph / coda；
- 图像与图注；
- 表格；
- 长文阅读节奏。

正文保留语义化结构，例如：

```latex
\begin{HiroInterlude}{...}
...
\end{HiroInterlude}
```

样式文件负责字号、色阶、留白、线条和分页表现。

## 4. Cross-media scholarly apparatus

`hiro-bibliography.sty` 与 AtelierTeX bibliography layer 共同负责：

- GB/T 7714 正式著录；
- GAME / CHARACTER FILE / COMM / ANIME / MANGA / MUSIC / LIVE 等 media tag；
- STEP / episode / chapter / route / timestamp locator；
- bibliography legend；
- 中日英混排书目。

公共 taxonomy 与 bibliography semantics 由 AtelierTeX 维护；HIRO2026 处理活动主题下的 presentation。

## 5. 视觉修改导航

| 修改对象 | 文件 |
| --- | --- |
| 标题页骨架与排版注册表 | AtelierTeX `atelier/core.sty` |
| 刊头、Logo 与题名元数据映射 | `hiro-core.sty` / `hiro-layout-editorial.sty` |
| 页边距、章节、页眉页脚 | `hiro-core.sty` |
| 字体别名 | `hiro-fonts.sty` |
| 多语种兼容接口 | `hiro-languages.sty` |
| 引文、幕间、场景、对白 | `hiro-narrative.sty` |
| 图像与图注 | `hiro-figures.sty` |
| 表格 | `hiro-tables.sty` |
| 参考文献标签 renderer | `hiro-bibliography.sty` |
| 公共字体、语言、ACGN bibliography semantics | AtelierTeX |

## 6. 字体角色

HIRO2026 消费 AtelierTeX 提供的字体角色：

```text
SC serif
TC serif
JP serif
SC sans
Latin serif / sans
```

通用字体发现与 fallback 由 AtelierTeX 维护；HIRO2026 在具体组件中选择相应角色。

## 7. `Hiro*` 接口

模板保留 `Hiro*` 命名空间，提供稳定的 publication-specific API，例如：

```text
HiroOriginal
HiroTranslation
HiroScene
HiroInterlude
HiroDialogue
HiroEpigraph
HiroCoda
```

这些接口让作者可以在不依赖具体版式实现的情况下组织剧情原文、译文、场景与长篇分析。

## 8. 版式方向

三种标题页采用：

- 黑白灰主色；
- `feature` 的全幅刊头、独立封面与充足留白；
- `symposium` 的左侧刊头、右侧活动信息与紧凑题名区；
- `essay` 的左侧刊头、deck、可选头图与连续阅读入口；
- 期刊式正文密度；
- 幕间与 pull quote 控制阅读节奏；
- ACGN 特征通过 media tag、locator、多语种原文和视觉材料呈现。

## 9. 长文稳定性

长篇文档建议：

- 浮动体使用 `[tbp]` 等自然策略；
- 用 `Needspace` 保护标题；
- 长表使用可分页结构；
- 控制整页幕间密度；
- 固定依赖版本；
- 发布前进行关键页人工复核。

模板仓库只维护可以交给其他作者直接使用的类文件、样式、文档与示例。具体论文正文与资料整理方式不属于模板接口。
