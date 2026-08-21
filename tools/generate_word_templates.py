from pathlib import Path
from docx import Document
from docx.enum.style import WD_STYLE_TYPE
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_CELL_VERTICAL_ALIGNMENT
from docx.shared import Mm, Pt
from docx.oxml import OxmlElement
from docx.oxml.ns import qn

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'word'
OUT.mkdir(parents=True, exist_ok=True)
LOGO = ROOT / 'assets' / 'hiro2026-logo.png'

INK='111111'; TEXT='1D1D1B'; GRAY='666662'; LIGHT='969691'; RULE='C6C6C0'


def set_run_font(run, name='Noto Serif', size=None, bold=None, italic=None, color=None):
    run.font.name = name
    rpr = run._element.get_or_add_rPr()
    rfonts = rpr.get_or_add_rFonts()
    for attr in ('ascii','hAnsi','eastAsia','cs'):
        rfonts.set(qn('w:'+attr), name)
    if size is not None: run.font.size = Pt(size)
    if bold is not None: run.bold = bold
    if italic is not None: run.italic = italic
    if color: run.font.color.rgb = __import__('docx').shared.RGBColor.from_string(color)


def style_font(style, name, size, bold=None, italic=None, color=None):
    style.font.name = name
    rpr = style.element.get_or_add_rPr()
    rfonts = rpr.get_or_add_rFonts()
    for attr in ('ascii','hAnsi','eastAsia','cs'):
        rfonts.set(qn('w:'+attr), name)
    style.font.size = Pt(size)
    if bold is not None: style.font.bold = bold
    if italic is not None: style.font.italic = italic
    if color: style.font.color.rgb = __import__('docx').shared.RGBColor.from_string(color)


def add_pstyle(doc, name, font='Noto Serif', size=10, bold=None, italic=None, color=TEXT,
               left=None, right=None, first=None, before=None, after=None, line=None, align=None):
    styles = doc.styles
    try: s = styles[name]
    except KeyError: s = styles.add_style(name, WD_STYLE_TYPE.PARAGRAPH)
    style_font(s, font, size, bold, italic, color)
    pf=s.paragraph_format
    if left is not None: pf.left_indent=Mm(left)
    if right is not None: pf.right_indent=Mm(right)
    if first is not None: pf.first_line_indent=Mm(first)
    if before is not None: pf.space_before=Pt(before)
    if after is not None: pf.space_after=Pt(after)
    if line is not None: pf.line_spacing=Pt(line)
    if align is not None: pf.alignment=align
    return s


def set_cell_margins(cell, top=0, start=0, bottom=0, end=0):
    tcPr=cell._tc.get_or_add_tcPr(); tcMar=tcPr.first_child_found_in('w:tcMar')
    if tcMar is None:
        tcMar=OxmlElement('w:tcMar'); tcPr.append(tcMar)
    for m,v in [('top',top),('start',start),('bottom',bottom),('end',end)]:
        node=tcMar.find(qn('w:'+m))
        if node is None: node=OxmlElement('w:'+m); tcMar.append(node)
        node.set(qn('w:w'), str(v)); node.set(qn('w:type'),'dxa')


def paragraph_bottom_border(p, color=RULE, size='4', space='1'):
    pPr=p._p.get_or_add_pPr(); pBdr=pPr.find(qn('w:pBdr'))
    if pBdr is None: pBdr=OxmlElement('w:pBdr'); pPr.append(pBdr)
    bottom=OxmlElement('w:bottom'); bottom.set(qn('w:val'),'single'); bottom.set(qn('w:sz'),size); bottom.set(qn('w:space'),space); bottom.set(qn('w:color'),color); pBdr.append(bottom)


def add_page_field(p):
    p.alignment=WD_ALIGN_PARAGRAPH.CENTER
    r=p.add_run(); set_run_font(r,'Noto Serif',9,color=INK)
    fld1=OxmlElement('w:fldChar'); fld1.set(qn('w:fldCharType'),'begin')
    instr=OxmlElement('w:instrText'); instr.set(qn('xml:space'),'preserve'); instr.text=' PAGE '
    fld2=OxmlElement('w:fldChar'); fld2.set(qn('w:fldCharType'),'end')
    r._r.append(fld1); r._r.append(instr); r._r.append(fld2)


def setup_styles(doc):
    normal=doc.styles['Normal']; style_font(normal,'Noto Serif',10,color=TEXT)
    normal.paragraph_format.first_line_indent=Mm(7.3); normal.paragraph_format.line_spacing=Pt(16.1); normal.paragraph_format.space_after=Pt(0)
    h1=doc.styles['Heading 1']; style_font(h1,'Noto Sans',14,bold=True,color=INK); h1.paragraph_format.space_before=Pt(24); h1.paragraph_format.space_after=Pt(9)
    h2=doc.styles['Heading 2']; style_font(h2,'Noto Sans',11,bold=True,color=INK); h2.paragraph_format.space_before=Pt(16); h2.paragraph_format.space_after=Pt(6)
    h3=doc.styles['Heading 3']; style_font(h3,'Noto Sans',10,bold=True,color=INK); h3.paragraph_format.space_before=Pt(11); h3.paragraph_format.space_after=Pt(0)
    specs=[
      ('HIRO Masthead','Noto Sans',19,True,None,INK,None,None,None,None,None,21,WD_ALIGN_PARAGRAPH.LEFT),
      ('HIRO Publication Meta','Noto Sans',6.5,None,None,LIGHT,None,None,None,None,None,8.5,WD_ALIGN_PARAGRAPH.RIGHT),
      ('HIRO Kicker','Noto Sans',7,True,None,GRAY,None,None,None,None,None,9,None),
      ('HIRO Title Feature','Noto Serif',26,True,None,INK,None,None,None,None,None,33,None),
      ('HIRO Title','Noto Serif',27,True,None,INK,None,None,None,None,None,35,None),
      ('HIRO Subtitle','Noto Serif',12.5,None,None,INK,None,None,None,None,None,19.2,None),
      ('HIRO English Title','Noto Serif',9.5,None,True,GRAY,None,None,None,None,None,13.5,None),
      ('HIRO Deck','Noto Serif',9.5,None,None,GRAY,None,11,None,None,None,15.5,None),
      ('HIRO Author','Noto Serif',10,None,None,INK,None,None,None,None,None,13.4,None),
      ('HIRO Affiliation','Noto Serif',8.5,None,None,GRAY,None,None,None,None,None,12.2,None),
      ('HIRO Contact','Noto Serif',8.5,None,None,GRAY,None,None,None,None,None,11.6,None),
      ('HIRO Document Meta','Noto Sans',6.5,None,None,GRAY,None,None,None,None,None,8.6,WD_ALIGN_PARAGRAPH.RIGHT),
      ('HIRO Author Note','Noto Serif',7.5,None,None,GRAY,None,None,None,None,None,10.5,None),
      ('HIRO Abstract','Noto Serif',9,None,None,TEXT,7,7,None,None,None,15.4,None),
      ('HIRO Keywords','Noto Serif',9,None,None,TEXT,7,7,None,None,None,14.4,None),
      ('HIRO Quote','Noto Serif',10,None,None,GRAY,9,9,None,6,5,16.2,None),
      ('HIRO Quote Source','Noto Serif',8,None,None,LIGHT,9,9,None,3,5,10.8,WD_ALIGN_PARAGRAPH.RIGHT),
      ('HIRO Pull Quote','Noto Serif',15,None,None,INK,12,12,None,11,11,23,WD_ALIGN_PARAGRAPH.CENTER),
      ('HIRO Note Label','Noto Sans',6.5,True,None,LIGHT,None,None,None,None,2,8,None),
      ('HIRO Note','Noto Serif',9,None,None,TEXT,None,None,None,None,8,14.6,None),
      ('HIRO Key','Noto Serif',9.5,None,None,TEXT,None,None,None,3,3,14.8,None),
      ('HIRO Scene Label','Noto Sans',6.5,None,None,LIGHT,None,None,None,14,2,8,None),
      ('HIRO Scene Title','Noto Serif',12,True,None,INK,None,None,None,None,5,18,None),
      ('HIRO Scene Body','Noto Serif',9.5,None,None,TEXT,5,5,7,None,None,15.7,None),
      ('HIRO Interlude Label','Noto Sans',6.5,None,None,LIGHT,None,None,None,None,5,8,WD_ALIGN_PARAGRAPH.CENTER),
      ('HIRO Interlude Title','Noto Serif',18,True,None,INK,None,None,None,None,7,27,WD_ALIGN_PARAGRAPH.CENTER),
      ('HIRO Interlude Body','Noto Serif',10,None,None,TEXT,20,20,7,None,None,17,None),
      ('HIRO Epigraph','Noto Serif',10,None,True,GRAY,18,8,None,10,3,16,WD_ALIGN_PARAGRAPH.RIGHT),
      ('HIRO Epigraph Source','Noto Serif',8,None,None,GRAY,18,8,None,None,8,10.5,WD_ALIGN_PARAGRAPH.RIGHT),
      ('HIRO Dialogue','Noto Serif',9.5,None,None,TEXT,8,8,None,None,5,15.5,None),
      ('HIRO Scene Break','Noto Sans',10,None,None,RULE,None,None,None,9,9,None,WD_ALIGN_PARAGRAPH.CENTER),
      ('HIRO Coda','Noto Serif',10.5,None,None,TEXT,10,10,7,16,10,17.5,None),
      ('HIRO Original','Noto Serif',9.5,None,None,GRAY,8,8,None,4,2,15.2,None),
      ('HIRO Translation','Noto Serif',8.5,None,None,LIGHT,8,8,None,None,5,14.3,None),
      ('HIRO Figure Source','Noto Serif',7.5,None,None,LIGHT,None,None,None,2,None,10.2,None),
      ('HIRO Reference','Noto Serif',8,None,None,TEXT,None,None,None,None,3.6,12.55,None),
    ]
    for x in specs: add_pstyle(doc,*x)


def setup_doc():
    doc=Document(); setup_styles(doc)
    sec=doc.sections[0]; sec.page_width=Mm(210); sec.page_height=Mm(297); sec.left_margin=Mm(27.5); sec.right_margin=Mm(27.5); sec.top_margin=Mm(23); sec.bottom_margin=Mm(25); sec.header_distance=Mm(7); sec.footer_distance=Mm(12); sec.different_first_page_header_footer=True
    h=sec.header.paragraphs[0]
    r=h.add_run('HIRO 2026  /  [PAPER TYPE]'); set_run_font(r,'Noto Sans',6.5,color=LIGHT)
    r=h.add_run('\t[SHORT TITLE]'); set_run_font(r,'Noto Sans',6.5,color=LIGHT)
    pPr=h._p.get_or_add_pPr(); tabs=OxmlElement('w:tabs'); t=OxmlElement('w:tab'); t.set(qn('w:val'),'right'); t.set(qn('w:pos'),'8780'); tabs.append(t); pPr.append(tabs)
    add_page_field(sec.footer.paragraphs[0]); add_page_field(sec.first_page_footer.paragraphs[0])
    return doc


def add_symposium_masthead(doc):
    table=doc.add_table(rows=1, cols=2); table.autofit=False
    table.columns[0].width=Mm(55); table.columns[1].width=Mm(98)
    for c in table.rows[0].cells: set_cell_margins(c); c.vertical_alignment=WD_CELL_VERTICAL_ALIGNMENT.CENTER
    c0,c1=table.rows[0].cells; p=c0.paragraphs[0]
    if LOGO.exists():
        try: p.add_run().add_picture(str(LOGO), width=Mm(39))
        except Exception:
            r=p.add_run('HIRO2026'); set_run_font(r,'Noto Sans',19,bold=True,color=INK)
    else:
        r=p.add_run('HIRO2026'); set_run_font(r,'Noto Sans',19,bold=True,color=INK)
    p=c1.paragraphs[0]; p.style='HIRO Publication Meta'; p.add_run('HIRO2026 / 篠泽广研讨会')
    c1.add_paragraph('SHINOSAWA HIRO / ACGN STUDIES / LONGFORM', style='HIRO Publication Meta')
    c1.add_paragraph('2026 · 第三方非官方支援项目', style='HIRO Publication Meta')
    rule=doc.add_paragraph(); paragraph_bottom_border(rule); rule.paragraph_format.space_after=Pt(24)


def add_front_fields(doc, layout):
    if layout=='feature':
        p=doc.add_paragraph(); p.paragraph_format.space_before=Mm(10); p.alignment=WD_ALIGN_PARAGRAPH.CENTER
        if LOGO.exists():
            try: p.add_run().add_picture(str(LOGO), width=Mm(145))
            except Exception: p.add_run('HIRO2026').bold=True
        else:
            r=p.add_run('HIRO2026'); set_run_font(r,'Noto Sans',28,bold=True,color=INK)
        p=doc.add_paragraph('[SHINOSAWA HIRO / LONGFORM]', style='HIRO Kicker'); p.paragraph_format.space_before=Pt(12)
        doc.add_paragraph('[文章标题 / TITLE]', style='HIRO Title Feature')
        doc.add_paragraph('[副标题 / SUBTITLE]', style='HIRO Subtitle')
        doc.add_paragraph('[English Title]', style='HIRO English Title')
        spacer=doc.add_paragraph(); spacer.paragraph_format.space_after=Mm(37)
        doc.add_paragraph('[作者 / AUTHOR]', style='HIRO Author')
        doc.add_paragraph('[单位 / 社团 / 研究机构]', style='HIRO Affiliation')
        doc.add_paragraph('[contact@example.com / URL]', style='HIRO Contact')
        doc.add_paragraph('2026', style='HIRO Author')
        doc.add_paragraph('[PAPER TYPE / HIRO2026-XXX]', style='HIRO Author Note')
        doc.add_paragraph('[作者说明 / 非官方声明 / 可删除]', style='HIRO Author Note')
        doc.add_page_break()
    else:
        add_symposium_masthead(doc)
        p=doc.add_paragraph('[KICKER / SHORT DESCRIPTOR]', style='HIRO Kicker'); p.paragraph_format.space_before=Pt(4)
        doc.add_paragraph('[文章标题 / TITLE]', style='HIRO Title')
        doc.add_paragraph('[副标题 / SUBTITLE]', style='HIRO Subtitle')
        doc.add_paragraph('[English Title]', style='HIRO English Title')
        if layout=='essay': doc.add_paragraph('[一句承担阅读入口、而非摘要功能的导语 / HIRODeck]', style='HIRO Deck')
        t=doc.add_table(rows=1, cols=2); t.autofit=False; t.columns[0].width=Mm(100); t.columns[1].width=Mm(53)
        for c in t.rows[0].cells: set_cell_margins(c)
        c0,c1=t.rows[0].cells
        c0.paragraphs[0].style='HIRO Author'; c0.paragraphs[0].add_run('[作者 / AUTHOR]')
        c0.add_paragraph('[单位 / 社团 / 研究机构]', style='HIRO Affiliation')
        if layout=='symposium': c0.add_paragraph('[contact@example.com / URL]', style='HIRO Contact')
        c1.paragraphs[0].style='HIRO Document Meta'; c1.paragraphs[0].add_run('[PAPER TYPE / HIRO2026-XXX]')
        doc.add_paragraph('[作者说明 / 非官方声明 / 可删除]', style='HIRO Author Note')
        if layout=='essay':
            p=doc.add_paragraph(); p.alignment=WD_ALIGN_PARAGRAPH.CENTER
            pPr=p._p.get_or_add_pPr(); pBdr=OxmlElement('w:pBdr')
            for side in ('top','left','bottom','right'):
                el=OxmlElement('w:'+side); el.set(qn('w:val'),'single'); el.set(qn('w:sz'),'4'); el.set(qn('w:color'),RULE); pBdr.append(el)
            pPr.append(pBdr); p.paragraph_format.space_before=Pt(8); p.paragraph_format.space_after=Pt(8)
            r=p.add_run('\n\n\n\n[可选叙事照片 / HIROHeroImage]\n\n\n\n'); set_run_font(r,'Noto Serif',8.5,color=GRAY)
            doc.add_paragraph('[照片说明 / HIROHeroCaption]', style='HIRO Figure Source')
            doc.add_paragraph('[来源 / HIROHeroCredit]', style='HIRO Figure Source')


def add_body_sample(doc):
    p=doc.add_paragraph(style='HIRO Abstract'); r=p.add_run('摘  要 '); set_run_font(r,'Noto Sans',8.7,bold=True,color=INK); p.add_run('[在此填写摘要。]')
    p=doc.add_paragraph(style='HIRO Keywords'); r=p.add_run('关键词 '); set_run_font(r,'Noto Sans',8.6,bold=True,color=INK); p.add_run('[关键词 1；关键词 2；关键词 3]'); paragraph_bottom_border(p); p.paragraph_format.space_after=Pt(16)
    doc.add_paragraph('一、[一级标题]', style='Heading 1')
    doc.add_paragraph('[正文从这里开始。Normal 样式对应 HIRO 正文：A4、27.5 mm 左右边距、10.35 pt 正文、16.1 pt 固定行距、首行约 2 em。]')
    doc.add_paragraph('语义样式示例（可整体删除）', style='Heading 2')
    doc.add_paragraph('HiroOriginal：日本語原文・繁体中文原文等。', style='HIRO Original')
    doc.add_paragraph('HiroTranslation：对应译文。', style='HIRO Translation')
    p=doc.add_paragraph(style='HIRO Scene Label'); p.add_run('SCENE'); p.add_run('\t[LOCATOR]')
    pPr=p._p.get_or_add_pPr(); tabs=OxmlElement('w:tabs'); t=OxmlElement('w:tab'); t.set(qn('w:val'),'right'); t.set(qn('w:pos'),'5000'); tabs.append(t); pPr.append(tabs)
    doc.add_paragraph('[场景标题]', style='HIRO Scene Title')
    doc.add_paragraph('[场景化材料正文。]', style='HIRO Scene Body')
    p=doc.add_paragraph(style='HIRO Dialogue'); r=p.add_run('[角色 A] '); set_run_font(r,'Noto Sans',8,bold=True,color=LIGHT); p.add_run('[对白或分析文本。]')
    doc.add_paragraph('[强调引文 / Pull Quote]', style='HIRO Pull Quote')
    doc.add_paragraph('按 / NOTE', style='HIRO Note Label')
    doc.add_paragraph('[注记正文。]', style='HIRO Note')


def build(layout):
    doc=setup_doc(); add_front_fields(doc,layout); add_body_sample(doc)
    path=OUT/f'hiro2026-{layout}.docx'; doc.save(path); print(path)

if __name__=='__main__':
    for layout in ('feature','symposium','essay'): build(layout)
