# 参与贡献

感谢关注 `atelier-profile-hiro`。本项目是维护者个人发起的 HIRO2026 第三方非官方 LaTeX 支援工具；参与贡献不表示贡献者或本项目与活动主办方、`idol-master.top`、《偶像大师》官方及相关权利方存在隶属、委托或代表关系。

## 可以贡献的内容

- `hiro2026.cls` 与 `hiro/*.sty` 的兼容性修复；
- `feature`、`symposium`、`essay` 三种平行排版的可复现改进；
- 简中、繁中、日文与英文混排问题；
- ATX-ACGN-REF 与 GB/T 7714 输出问题；
- 示例、中文说明和本地测试改进。

作者实际稿件、稿件专属书目、私人联系方式、非公开工作记录以及权利状态不明确的截图或素材不进入本仓库。

## 开发环境

推荐把两个仓库并列放置：

```text
workspace/
├── AtelierTeX/
└── atelier-profile-hiro/
```

默认发布引擎为 XeLaTeX；LuaLaTeX 是兼容性目标。提交版式改动时，应保证 XeLaTeX 的规范页面可复现，并运行双引擎检查：

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine both
pwsh -File tests/verify-public-boundary.ps1
pwsh -File tests/render-readme-preview.ps1 -Engine xelatex
```

README 预览必须由当前 `hiro2026.cls`、锁定的 AtelierTeX、XeLaTeX、PDF 与 `pdftoppm` 链路重新生成，不接受手工绘制或简化类模拟的替代图片。

## 提交前检查

- 修改没有破坏现有公共命令和类选项；
- 三种标题页都能独立生成 PDF；
- 日志不存在缺字、未定义命令、未解析引用或 CJK 粗体静默回退；
- 新文件已加入 `manifest.txt` 或明确记录为单独许可资产；
- Logo、Mark 与含图预览仍符合 `LICENSE_SCOPE.md` 和 `LICENSES/` 的许可边界；
- 文档以中文为主，并同步说明用户可见的行为变化。

## 许可

源码、文档、示例与测试按 LPPL-1.3c 发布，维护状态为 `maintained`，当前维护者为 `54wsdf`。HIRO2026 Logo、Mark 与含图预览不属于 LPPL Work，适用条件见 [`LICENSE_SCOPE.md`](LICENSE_SCOPE.md) 与 [`LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt`](LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt)。提交贡献前请确认你有权按对应许可提供内容。

建议通过 GitHub Issue 描述问题和最小复现，再提交聚焦的 Pull Request。安全或隐私问题请避免在公开 Issue 中附带凭据、私人地址或未脱敏材料。
