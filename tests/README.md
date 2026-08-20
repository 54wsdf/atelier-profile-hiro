# `tests/` 测试说明

HIRO2026 第三方支援模板采用本地编译测试。`compile-smoke.ps1` 验证组件和双引擎编译，`render-readme-preview.ps1` 负责从 PDF 生成 README 首页图。

## 基本命令

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine xelatex
pwsh -File tests/compile-smoke.ps1 -Engine lualatex
pwsh -File tests/compile-smoke.ps1 -Engine both
pwsh -File tests/render-readme-preview.ps1 -Engine xelatex
```

## 目录布局

```text
workspace/
├── AtelierTeX/
└── atelier-profile-hiro/
```

测试脚本显式加载相邻 AtelierTeX，每次运行先清理 `build` 输出，再进行完整编译。

## 编译检查重点

- `Missing character:`；
- CJK 粗体被静默替换为常规字重；
- `Undefined control sequence`；
- `LaTeX Error:`；
- undefined citation / reference；
- HIRO2026 masthead 与第三方模板标识；
- 标题页应加载图形刊头；资产不存在时才使用文字替代；
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
- 标题页、Logo 或字体调整后必须重新生成并人工查看 PNG。

## 推荐运行节点

- AtelierTeX dependency pin 更新；
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

该脚本阻止已撤出的具体稿件、内部路径和私人邮箱重新进入公开候选树。

下游作者可以根据自己的篇幅、图表、字体与参考文献规模增加额外回归测试；模板仓库的 smoke test 只验证可复用组件本身。
