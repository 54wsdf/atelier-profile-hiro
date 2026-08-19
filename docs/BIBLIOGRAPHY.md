# HIRO2026 跨媒介参考文献：GB/T 7714 + ATX-ACGN-REF

围绕篠泽广与《学园偶像大师》写作时，材料往往同时来自游戏、角色官网、剧情、音乐、Live、PV、访谈和常规学术文献。HIRO2026 因此使用双层书目结构：**GB/T 7714 正式著录 + ATX-ACGN-REF media tag**。

## 1. 正式著录层

HIRO2026 通过 AtelierTeX 调用：

```latex
\AtelierUseACGNBibliography
```

正式目标基线为 GB/T 7714-2025。AtelierTeX 会根据当前 TeX 环境选择可用样式，并通过：

```latex
\AtelierActualGBStyle
```

记录实际渲染样式。

常见 BibLaTeX 类型包括：

- `@book`：图书；
- `@article`：期刊论文；
- `@online`：官网角色页、采访、PV 页面、音乐页面等；
- `@software`：游戏、软件与程序类对象。

## 2. Media tag

`verba` 字段保存短媒体标签：

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

参考文献输出由两部分组成：media tag + GB/T 7714 正式条目。

## 3. 推荐标签

| 标签 | 典型对象 |
| --- | --- |
| `GAME` | 游戏本体、版本与发行页面 |
| `CHARACTER FILE` | 官方角色档案 |
| `COMM · STEP1/EP08` | 游戏内剧情 / 亲爱度剧情 |
| `CARD` | 卡面 / 卡片资料 |
| `EVENT` | 游戏活动与活动剧情 |
| `ANIME · EP01` | 动画单集 |
| `MANGA · CH01` | 漫画单话 |
| `PV` | 官方 PV / MV / 宣传片 |
| `MUSIC · TRACK` | 单曲、专辑与曲目 |
| `LIVE · STAGE` | 现实或 3DCG 演出 |
| `INTERVIEW` | 制作人、编剧、设计访谈 |
| `FAN LOCATOR` | Wiki、剧情回顾与定位辅助 |

标签应保持短小。更长的定位信息进入 title、number、note 或正文 citation postnote。

## 4. Primary source、secondary source 与 locator

可以按研究功能区分材料：

```text
Primary / official source → 承担文本、设定、视觉、发行与演出事实
Secondary study          → 承担已有研究观点、理论与解释
Locator                   → 帮助定位 episode / route / page / chapter / timestamp
```

FAN LOCATOR 可以帮助快速找到剧情或资料位置；关键论证建议再回到游戏本体、官方页面、动画、漫画单行本或其他可核验的 primary source。

## 5. 游戏剧情著录

关键剧情建议建立独立 BibTeX 条目，并记录：

- 发行 / 权利主体；
- 游戏名；
- 角色；
- STEP / route；
- episode；
- 话标题；
- 年份；
- 官方入口 URL；
- 访问日期；
- `langid`；
- `verba`。

示例：

```bibtex
@software{hiro_commu_step1_08,
  author   = {{Bandai Namco Entertainment Inc.}},
  title    = {篠澤 広 親愛度コミュ STEP1 第8話},
  subtitle = {学園アイドルマスター},
  date     = {2024},
  url      = {https://gakuen.idolmaster-official.jp/},
  note     = {Locator: STEP1 / Episode 8},
  verba    = {COMM · STEP1/EP08},
  langid   = {japanese}
}
```

## 6. 原文与版权处理

剧情与歌曲研究适合采用“短句锚点 + 场景转述 + 精确 locator”的组合：

- 关键短句用于 close reading；
- 较长场景使用转述；
- STEP / episode / chapter / timestamp 负责精确定位；
- 正式发布前核对原始材料；
- 歌词等受版权保护文本保持必要、有限的引用长度。

## 7. `verba` 字段约定

`verba` 只承担快速识别：

```text
GAME
CHARACTER FILE
COMM · STEP1/EP08
ANIME · EP01
MANGA · CH01
MUSIC · TRACK
LIVE · STAGE
FAN LOCATOR
```

作品身份与责任者等正式信息继续写入 BibLaTeX 字段。

## 8. 文末图例

```latex
\HIROReferenceLegend
```

图例解释常见 media tag，并显示本次编译实际采用的 GB/T 样式。

## 9. 长篇书目

书目规模增大后可以：

- 按 primary / secondary / media 分组；
- 使用 bibliography section；
- 控制 URL 断行；
- 缩短 media tag；
- 在章节或附录中增加 locator index。

公共 ACGN bibliography semantics 由 AtelierTeX 维护；HIRO2026 负责最终页面中的标签、图例、字号和条目节奏。