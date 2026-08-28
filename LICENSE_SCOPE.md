# atelier-profile-hiro 许可范围

本仓库包含两类适用条件不同的内容。使用、修改或再发布前，请同时核对本文件、根目录 [`LICENSE`](LICENSE)、[`manifest.txt`](manifest.txt) 与 [`LICENSES/`](LICENSES/) 中的许可记录。

## 一、LaTeX 源码、文档、示例与测试

由本项目维护者创作、并逐项列入 [`manifest.txt`](manifest.txt) 的 LaTeX 源码、文档、示例、测试和项目说明采用 **LaTeX Project Public License 1.3c（LPPL-1.3c）**。

从 profile 1.3.0 起，本仓库还直接包含由同一维护者维护、来源锁定到 AtelierTeX `03abdc156992b6cdb84bdafff98a2457d55642da` 的运行时文件，包括 `atelier.cls`、`atelier/*.sty` 与 `profiles/*.sty`。这些文件现在作为本仓库 LPPL Work 的组成部分进入 `manifest.txt`，用于保证普通作者只下载一个仓库即可编译。其上游来源与升级规则见 [`DEPENDENCY_LOCK.md`](DEPENDENCY_LOCK.md)。

- LPPL 维护状态：`maintained`
- 当前维护者（Current Maintainer）：`54wsdf`
- 问题与维护联系：[GitHub Issues](https://github.com/54wsdf/atelier-profile-hiro/issues)

使用本模板排版的作者文稿及其 PDF，不会仅因使用本项目而自动成为本项目 LPPL `Work` 的组成部分。作者自行决定其正文、研究材料与输出文件的许可方式。

## 二、HIRO2026 Logo、Mark 与含图预览

以下文件不采用 LPPL-1.3c，而按公开发布的 HIRO2026 Logo 使用与创作许可说明处理：

- `assets/hiro2026-logo.png`
- `assets/hiro2026-mark.png`
- `docs/assets/rendered/hiro2026-feature-page1.png`
- `docs/assets/rendered/hiro2026-symposium-page1.png`
- `docs/assets/rendered/hiro2026-essay-page1.png`

公开许可来源、原文摘录、文件摘要和适用边界见 [`LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt`](LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt)。本仓库使用自定义 SPDX LicenseRef `LicenseRef-HIRO2026-Logo-Public-Use` 记录这项公开许可，不将其扩大解释为 CC、LPPL 或其他标准许可证。

## 三、名称、商标与官方身份

“HIRO2026”“THE IDOLM@STER”“学園アイドルマスター”“篠澤 広 / 篠泽广”等名称、角色、作品与相关商标仍归各自权利人所有。Logo 的公开使用与创作许可不表示本项目获得 HIRO2026 官方、活动主办方、`idol-master.top`、《偶像大师》官方或其他相关权利方的委托、合作、代表身份或认可。

本项目完全由维护者个人发起，只提供第三方非官方排版支援。活动规则与信息以活动页面为准。

## 四、修改与再发布

- 修改或再发布 `manifest.txt` 所列 Work 时，应遵守 LPPL-1.3c，保留版权、许可与修改说明，并避免让修改版被误认为当前维护者发布的原版。
- 同步或修改内置 AtelierTeX 运行时时，应同时更新 `DEPENDENCY_LOCK.md` 中的上游 commit 记录并重新执行双引擎与视觉回归检查。
- 使用或创作上述 Logo、Mark 与含图预览时，应以公开许可记录为依据，不得把该许可表述为活动方对本项目的官方认可。
- 文章中另行加入的游戏截图、卡面、照片、扫描件、PV / MV 画面等不属于本仓库授权范围，应由使用者自行确认权利状态。

## English summary

Files listed in `manifest.txt`, including the bundled AtelierTeX runtime required for single-repository builds, are released under LPPL-1.3c with maintenance status `maintained`; the Current Maintainer is `54wsdf`. The upstream AtelierTeX provenance is pinned in `DEPENDENCY_LOCK.md`. The HIRO2026 logo, mark, and the three rendered previews containing them are governed separately by `LicenseRef-HIRO2026-Logo-Public-Use`. Names, trademarks, and official affiliation are not licensed by this repository.
