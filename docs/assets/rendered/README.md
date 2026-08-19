# 标题页渲染图

本目录为每种公开标题页排版保存一张独立生成的首页 PNG：

- `hiro2026-feature-page1.png`：由 [`../../../examples/profile-demo.tex`](../../../examples/profile-demo.tex) 生成；
- `hiro2026-symposium-page1.png`：由 [`../../../examples/profile-demo-symposium.tex`](../../../examples/profile-demo-symposium.tex) 生成；
- `hiro2026-essay-page1.png`：由 [`../../../examples/profile-demo-essay.tex`](../../../examples/profile-demo-essay.tex) 生成。

## 生成方式

在仓库根目录运行：

```powershell
pwsh -File tests/render-readme-preview.ps1 -Engine xelatex
```

脚本会分别编译 `feature`、`symposium` 与 `essay` 示例，再使用 Poppler 将三份 PDF 的第一页转换为 240 dpi、白底、不透明 RGB PNG。

## 检查项

- 三种排版分别来自各自的 TeX 入口和 PDF；
- 页面尺寸符合 A4；
- PNG 可以完整解码，且不带透明页边；
- Logo、题名、作者和活动信息清楚可读；
- 页面没有黑边、裁切、重叠、乱码或缺字。

PNG 是可复现的页面预览，不是独立绘制的示意图。
