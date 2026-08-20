# 依赖锁定说明

HIRO2026 第三方模板通过精确 commit SHA 记录已经完成兼容验证的 AtelierTeX 版本，便于其他作者复现同一套类文件、字体语义与参考文献行为。

| 依赖 | 仓库 | 锁定版本 |
| --- | --- | --- |
| AtelierTeX | `54wsdf/AtelierTeX` | `03abdc156992b6cdb84bdafff98a2457d55642da` |

该版本为 AtelierTeX 0.5.3，包含：

- ATX-ACGN-REF 0.4；
- GB/T 7714-2025 正式目标基线；
- `gb7714-2025.bbx` 环境探测与兼容回退；
- `\AtelierActualGBStyle` 实际样式记录；
- XeLaTeX / LuaLaTeX 多语种与 CJK/Japanese 字形回退；
- ACGN Media Tag、Locator、长文图表与叙事语义；
- `feature` 专题封面与 `symposium` 研讨会刊页；
- `essay` 图文长篇排版与克制的摄影占位；
- 可扩展标题页注册表与公共元数据槽；
- 三种平行排版各自独立的 TeX 入口、PDF 和 README PNG；
- LPPL-1.3c Work 清单、`maintained` 状态与当前维护者声明；
- LuaLaTeX 日文字形与粗体回退修正；
- 简中、繁中与日文共享汉字的显式语种字形接口；
- LuaLaTeX 简中主字体、姓名角色与可变字体粗体轴的统一绑定。

> 防退化说明：这里锁定的是实际完成双引擎验收的干净根提交。后续升级时不得只改版本号或展示图片，必须同时更新 commit SHA，并重新运行三种排版的完整编译门。

## 推荐获取方式

```text
workspace/
├── AtelierTeX/
└── atelier-profile-hiro/
```

在需要完全复现编译环境时，将 AtelierTeX 检出到上表 SHA。升级依赖后运行：

```powershell
pwsh -File tests/compile-smoke.ps1 -Engine both
```

## GB/T 样式

HIRO2026 的正式目标为 GB/T 7714-2025。若当前 TeX 环境尚未提供 `gb7714-2025`，AtelierTeX 会使用兼容样式，并通过 `\AtelierActualGBStyle` 记录实际结果。

发布或交付文稿前建议检查：

- `\AtelierActualGBStyle`；
- biber 是否成功；
- citation/reference 是否全部解析；
- media tag 是否正确；
- XeLaTeX / LuaLaTeX 是否存在缺字或命令错误。

作者可以在自己的项目中另外记录 HIRO2026 与 AtelierTeX 的 commit SHA，以便长期复现。
