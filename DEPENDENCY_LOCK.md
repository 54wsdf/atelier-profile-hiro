# 依赖锁定说明

从 HIRO2026 profile 1.3.0 起，普通使用者只需要下载本仓库。已经完成兼容验证的 AtelierTeX 运行时直接随 `atelier-profile-hiro` 一并分发，不再要求额外 clone、checkout 或打开第二个仓库。

## 内置运行时来源

| 依赖 | 上游仓库 | 上游锁定版本 | 本仓库状态 |
| --- | --- | --- | --- |
| AtelierTeX | `54wsdf/AtelierTeX` | `03abdc156992b6cdb84bdafff98a2457d55642da` | 已内置运行时 |

该上游版本为 AtelierTeX 0.5.3。为了让 HIRO2026 成为单仓库可用的 LaTeX 分发包，本仓库直接包含其经验证运行所需的：

```text
atelier.cls
atelier/
profiles/editorial.sty
profiles/essay.sty
```

这些文件进入本仓库的 LPPL Work 清单，由根目录 `manifest.txt` 统一管理。上表 SHA 继续作为来源与升级基线：维护者升级内置运行时时，必须从明确的 AtelierTeX commit 同步，并重新运行 HIRO 的双引擎与视觉回归门。

## 普通使用者

推荐目录现在只有一个仓库：

```text
workspace/
└── atelier-profile-hiro/
```

进入仓库即可编译：

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine xelatex
```

或直接对自己的文稿运行 XeLaTeX / LuaLaTeX。`hiro2026.cls` 会从本仓库根目录加载内置 `atelier.cls`，后者再加载同仓库的 `atelier/` 与 `profiles/` 模块。

不需要配置 `../AtelierTeX`，也不应把相邻 AtelierTeX 工作树作为发布前提。

## 上游 AtelierTeX 0.5.3 能力基线

当前内置运行时对应的已验证能力包括：

- ATX-ACGN-REF 0.4；
- GB/T 7714-2025 正式目标基线；
- `gb7714-2025.bbx` 环境探测与兼容回退；
- `\AtelierActualGBStyle` 实际样式记录；
- XeLaTeX / LuaLaTeX 多语种与 CJK/Japanese 字形回退；
- ACGN Media Tag、Locator、长文图表与叙事语义；
- `feature`、`symposium` 与 `essay` 三种标题页注册机制；
- 简中、繁中与日文共享汉字的显式语种字形接口；
- LuaLaTeX 简中主字体、姓名角色与可变字体粗体轴统一绑定。

## GB/T 样式仍属于 TeX 环境依赖

HIRO2026 的正式目标为 GB/T 7714-2025。内置 AtelierTeX 负责选择和记录样式，但 `gb7714-2025.bbx` 本身仍来自作者的 TeX 发行版 / `biblatex-gb7714-2015` 安装环境。

若当前 TeX 环境尚未提供 `gb7714-2025`，AtelierTeX 会使用兼容样式，并通过 `\AtelierActualGBStyle` 记录实际结果。

发布或交付文稿前应检查：

- `\AtelierActualGBStyle`；
- biber 是否成功；
- citation/reference 是否全部解析；
- media tag 是否正确；
- XeLaTeX / LuaLaTeX 是否存在缺字或命令错误；
- HIRO2026 图形刊头是否由 `assets/hiro2026-logo.png` 实际加载。

## 升级规则

内置运行时不能隐式跟随 AtelierTeX `main`。升级时至少需要：

1. 记录新的 AtelierTeX commit SHA；
2. 同步本仓库 `atelier.cls`、`atelier/` 与相关 `profiles/` 文件；
3. 更新本文件与版本记录；
4. 运行 `tests/verify-public-boundary.ps1`；
5. 运行 XeLaTeX / LuaLaTeX 双引擎 smoke test；
6. 重新生成三种 README 首页预览并人工检查。
