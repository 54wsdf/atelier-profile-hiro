\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hiro2026}[2026/08/20 v1.2.0 unofficial HIRO2026 profile for AtelierTeX 0.5]

% 防退化说明：正文阅读 profile 与标题页排版是两条独立选择。默认保持
% editorial；essay 必须显式选择，后续不得用标题页选项偷偷改变正文语义。
\newif\ifhiroessayprofile
\hiroessayprofilefalse
\DeclareOption{profile=editorial}{\hiroessayprofilefalse}
\DeclareOption{profile=essay}{\hiroessayprofiletrue}

% 防退化说明：标题页排版由 AtelierTeX 注册表统一选择；HIRO 只保留 v08
% 到 symposium 的稳定兼容别名，后续新增排版仍应通过公共注册表接入。
\DeclareOption{titlelayout=feature}{\PassOptionsToClass{titlelayout=feature}{atelier}}
\DeclareOption{titlelayout=symposium}{\PassOptionsToClass{titlelayout=symposium}{atelier}}
\DeclareOption{titlelayout=essay}{\PassOptionsToClass{titlelayout=essay}{atelier}}
\DeclareOption{titlelayout=atelier}{\PassOptionsToClass{titlelayout=feature}{atelier}}
\DeclareOption{titlelayout=v08}{\PassOptionsToClass{titlelayout=symposium}{atelier}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{atelier}}
\ProcessOptions\relax
\ifhiroessayprofile
  \LoadClass[profile=essay]{atelier}
\else
  \LoadClass[profile=editorial]{atelier}
\fi

\RequirePackage{hiro/hiro-core}
\RequirePackage{hiro/hiro-fonts}
\RequirePackage{hiro/hiro-languages}
\RequirePackage{hiro/hiro-narrative}
\RequirePackage{hiro/hiro-tables}
\RequirePackage{hiro/hiro-figures}
\RequirePackage{hiro/hiro-layout-editorial}
\RequirePackage{hiro/hiro-layout-essay}
\RequirePackage{hiro/hiro-bibliography}

\endinput
