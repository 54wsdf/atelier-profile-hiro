% Copyright 2026 54wsdf
% SPDX-License-Identifier: LPPL-1.3c
% This work has the LPPL maintenance status `maintained`.
% The Current Maintainer of this work is 54wsdf.
% This work consists of the files listed in manifest.txt.
% 防退化说明：上述声明用于明确 LPPL 的维护状态与 Work 边界；后续不得只保留
% SPDX 标识而删除维护者、维护状态或 manifest 引用。
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hiro2026}[2026/08/28 v1.3.0 self-contained unofficial HIRO2026 profile with bundled AtelierTeX 0.5.3 runtime]

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
% AtelierTeX 0.5.3 的运行时现随本仓库一并分发；普通使用者只需 clone 本仓库。
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
