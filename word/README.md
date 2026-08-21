# HIRO2026 Word templates

本目录提供与 `hiro2026.cls` 三种平行标题页对应的可编辑 Word 模板：

- `hiro2026-feature.docx` 对应 `titlelayout=feature`；
- `hiro2026-symposium.docx` 对应 `titlelayout=symposium`；
- `hiro2026-essay.docx` 对应 `profile=essay,titlelayout=essay`。

三份文档共享同一套正文和语义样式，包括 `HIRO Original`、`HIRO Translation`、`HIRO Scene Label`、`HIRO Scene Title`、`HIRO Scene Body`、`HIRO Dialogue`、`HIRO Pull Quote`、`HIRO Note`、`HIRO Epigraph`、`HIRO Interlude`、`HIRO Coda`、`HIRO Figure Source` 与 `HIRO Reference` 等。页面几何、字号、行距和灰阶层级按当前 HIRO2026 / AtelierTeX 样式合同映射；Word 与 TeX 保持语义和视觉层级一致，不追求跨排版引擎的逐页像素级一致。

这些 `.docx` 由 `tools/generate_word_templates.py` 生成。重新生成：

```bash
python -m pip install python-docx
python tools/generate_word_templates.py
```

模板中的方括号文字为可替换占位内容；“语义样式示例”部分用于展示样式，可在正式文稿中整体删除。

当前 Word 层为无宏的可编辑交换模板。后续若增加 `.dotm` / `.docm`，宏层应作为增强功能，不改变这些基础 DOCX 的可读性和可编辑性。
