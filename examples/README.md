# `examples/` 示例说明

`examples/` 提供面向篠泽广研讨会（HIRO2026）的公开样张，同时作为组件级编译测试输入。

活动信息入口：<https://idol-master.top/sites/hiro2026>

示例使用《学园偶像大师》与篠泽广相关的公开资料，展示该模板预期处理的材料类型。

`profile-demo.tex` 覆盖：

- `hiro2026.cls` 与仓库内置 AtelierTeX 运行时解析；
- HIRO2026 masthead 与第三方模板标识；
- 标题页与 publication metadata；
- 中文章节层级；
- 简中 / 日文多语种环境；
- `HiroScene`、`HiroDialogue` 等叙事环境；
- GB/T 7714 + ATX-ACGN-REF；
- XeLaTeX / LuaLaTeX 编译。

`references.bib` 采用游戏本体、篠泽广官方角色页、剧情与音乐发行页等公开资料，展示 `GAME`、`CHARACTER FILE`、`COMM`、`MUSIC` 等字段写法。

三种标题页分别使用独立入口与独立渲染图：

- [`profile-demo.tex`](profile-demo.tex) → [`../docs/assets/rendered/hiro2026-feature-page1.png`](../docs/assets/rendered/hiro2026-feature-page1.png)；
- [`profile-demo-symposium.tex`](profile-demo-symposium.tex) → [`../docs/assets/rendered/hiro2026-symposium-page1.png`](../docs/assets/rendered/hiro2026-symposium-page1.png)；
- [`profile-demo-essay.tex`](profile-demo-essay.tex) → [`../docs/assets/rendered/hiro2026-essay-page1.png`](../docs/assets/rendered/hiro2026-essay-page1.png)。

`essay` 使用与其他排版相同的公开示例内容，只增加 deck 与随笔正文节奏。模板仓不保存任何作者实际稿件或稿件专属书目。

## 与 AtelierTeX 的关系

示例通过 `hiro2026.cls` 加载本仓库中的 `atelier.cls`、`atelier/` 与 `profiles/`。这些文件来自 [`DEPENDENCY_LOCK.md`](../DEPENDENCY_LOCK.md) 锁定的 AtelierTeX 0.5.3 上游快照。AtelierTeX 负责通用的字体、多语种、基础长文语义与 ATX-ACGN-REF；HIRO 模块在其上增加 publication presentation。

普通作者和示例编译都不需要额外 clone AtelierTeX 仓库。

## 编译

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine both
```

脚本会清理旧输出，并只使用当前仓库内的运行时对三种排版进行双引擎编译。修改 `hiro2026.cls`、`hiro/*.sty`、内置 `atelier/` 或 bibliography renderer 后，建议优先运行这些 specimen。
