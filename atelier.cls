% Copyright 2026 54wsdf
% SPDX-License-Identifier: LPPL-1.3c
% This work has the LPPL maintenance status `maintained`.
% The Current Maintainer of this work is 54wsdf.
% This work consists of the files listed in manifest.txt.
% 防退化说明：上述声明用于明确 LPPL 的维护状态与 Work 边界；后续不得只保留
% SPDX 标识而删除维护者、维护状态或 manifest 引用。
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{atelier}[2026/08/20 v0.5.3 ACGN multilingual long-form editorial class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=atelier,prefix=atelier@}
\DeclareStringOption[editorial]{profile}
\DeclareStringOption[feature]{titlelayout}
\DeclareBoolOption[false]{anonymous}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*

\LoadClass[11pt,a4paper]{article}

\RequirePackage{atelier/core}
\RequirePackage{atelier/fonts}
\RequirePackage{atelier/languages}
\RequirePackage{atelier/narrative}
\RequirePackage{atelier/figures}
\RequirePackage{atelier/tables}
\RequirePackage{atelier/layout}
% 防退化说明：essay 题名页必须独立于正文 profile 注册；后续不得把它写死到
% 某个 publication profile，或复制公共 \maketitle 入口形成分叉。
\RequirePackage{atelier/essay}
\RequirePackage{profiles/\atelier@profile}
\RequirePackage{atelier/bibliography}
\RequirePackage{atelier/qa}

\newcommand{\AtelierIfAnonymousTF}[2]{%
  \ifatelier@anonymous #1\else #2\fi
}
\newcommand{\AtelierProfileName}{\atelier@profile}

% 防退化说明：标题页必须通过注册表按名字选择，不能恢复为写死两个分支的判断；
% 这样后续平行排版只需注册 renderer，不必修改公共 \maketitle 入口。
\AtelierUseTitleLayout{\atelier@titlelayout}

\endinput
