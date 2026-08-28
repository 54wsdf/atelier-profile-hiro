# `tests/` 测试说明

HIRO2026 第三方支援模板采用本地编译测试。`compile-smoke.ps1` 验证单仓库运行时和双引擎编译，`render-readme-preview.ps1` 负责从 PDF 生成 README 首页图。

## 基本命令

规范发布和 README 预览使用 XeLaTeX；LuaLaTeX 是兼容性门。完整发布检查仍运行 `-Engine both`。

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine xelatex
pwsh -File tests/compile-smoke.ps1 -Engine lualatex
pwsh -File tests/compile-smoke.ps1 -Engine both
pwsh -File tests/render-readme-preview.ps1 -Engine xelatex
```

## 目录布局

从 profile 1.3.0 起，测试只允许单仓库布局：

```text
workspace/
└── atelier-profile-hiro/
    ├── atelier.cls
    ├── atelier/
    ├── profiles/
    ├── hiro2026.cls
    ├── hiro/
    └── assets/
```

不再要求 `../AtelierTeX`。测试脚本会主动检查本仓库内置的 AtelierTeX 0.5.3 运行时，并把当前仓库根目录置于 TeX 搜索路径前部；即使开发机旁边恰好存在另一个 AtelierTeX checkout，也不能把它当作通过条件。

## 编译检查重点

- 内置 `atelier.cls` 与关键 `atelier/` / `profiles/` 模块存在；
- `Missing character:`；
- CJK 粗体被静默替换为常规字重；
- `Undefined control sequence`；
- `LaTeX Error:`；
- undefined citation / reference；
- HIRO2026 masthead 与第三方模板标识；
- 标题页必须加载真实 `assets/hiro2026-logo.png`；
- 简中 / 日文字体角色；
- `HiroScene`、`HiroDialogue` 等叙事环境；
- biber；
- media tag 与 GB/T 7714 类型码；
- XeLaTeX / LuaLaTeX 结果。

## README 图像检查

`render-readme-preview.ps1` 会先调用真实 smoke build，再分别生成：

```text
build/xelatex/feature/profile-demo.pdf
  → docs/assets/rendered/hiro2026-feature-page1.png

build/xelatex/symposium/profile-demo-symposium.pdf
  → docs/assets/rendered/hiro2026-symposium-page1.png

build/xelatex/essay/profile-demo-essay.pdf
  → docs/assets/rendered/hiro2026-essay-page1.png
```

渲染要求：

- `pdftoppm` 直接按 PDF 页面边界输出；
- 默认输出 240 dpi 白底 RGB PNG，不增加透明外边；
- 自动检查 A4 像素尺寸、RGB 色彩类型和页面末端像素解码；
- `feature`、`symposium` 与 `essay` 都加载真实 Logo，并各自保持标题、作者与元数据层级；
- 三种排版分别来自独立 PDF；
- 检查黑边、裁切、重叠、乱码和缺字；
- 标题页、Logo、字体或内置 AtelierTeX 运行时调整后必须重新生成并人工查看 PNG。

## 推荐运行节点

- 内置 AtelierTeX 上游 pin 更新；
- `hiro2026.cls` 调整；
- 字体 / 语言兼容层调整；
- narrative 环境调整；
- 标题页与 masthead 调整；
- bibliography renderer 调整；
- README 渲染资产调整；
- 准备公开版本或提交给其他作者测试之前。

## 公开边界检查

```powershell
pwsh -File tests/verify-public-boundary.ps1
```

该脚本阻止已撤出的具体稿件、内部路径和私人邮箱重新进入公开候选树，并要求所有新增 `.cls/.sty` 都有 LPPL 维护声明且进入 `manifest.txt`。

下游作者可以根据自己的篇幅、图表、字体与参考文献规模增加额外回归测试；模板仓库的 smoke test 只验证可复用组件本身。
