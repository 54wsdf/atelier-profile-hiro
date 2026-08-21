# HIRO2026 Word templates

本目录提供与 `hiro2026.cls` 三种平行标题页对应的可编辑 Word 版本：

- `hiro2026-feature.docx` 对应 `titlelayout=feature`；
- `hiro2026-symposium.docx` 对应 `titlelayout=symposium`；
- `hiro2026-essay.docx` 对应 `profile=essay,titlelayout=essay`。

三份 Word 文档以 `examples/profile-demo.tex` 的同一组公开样张内容作为视觉基准，不再使用与 TeX 无关的通用占位文案。Feature 保留独立专题封面，摘要与关键词进入下一页；Symposium 与 Essay 在首页完成刊头、题名、作者信息、摘要和关键词，并在与 TeX 样张相同的位置换页。Essay 默认只显示 `HIRODeck`，未设置 `HIROHeroImage` 时不会生成额外头图占位框。

页面几何沿用当前 HIRO 合同：A4，左右 27.5 mm、上 23 mm、下 25 mm。标题页的刊头宽度、题名字号、灰阶、作者区间距和首页空白均按 AtelierTeX 的 `feature / symposium / essay` renderer 映射；正文继续映射 HIRO 的章节、原文/译文、场景、对白和参考文献视觉。Word 与 TeX 的换行算法不同，因此不承诺逐字逐像素一致，但首页结构、信息层级和主要几何位置应保持肉眼一致。

这些 `.docx` 由 `tools/generate_word_templates.py` 生成：

```bash
python -m pip install python-docx
python tools/generate_word_templates.py
```

生成脚本直接使用仓库中的 `assets/hiro2026-logo.png`，并以当前 `profile-demo.tex` 内容作为回归样张。修改 TeX 标题页参数时，应同步修改 Word 映射并重新进行渲染检查。

当前 Word 层为无宏的可编辑交换版本。后续若增加 `.dotm` / `.docm`，宏层作为增强功能，不改变基础 DOCX 的可读性和可编辑性。
