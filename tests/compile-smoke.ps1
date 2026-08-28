[CmdletBinding()]
param(
    [ValidateSet('xelatex', 'lualatex', 'both')]
    [string]$Engine = 'both'
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

# 防退化说明：公开候选的编译门必须先排除已撤出稿件、内部路径和私人邮箱；
# 后续不得只验证 LaTeX 成功而跳过内容边界。
& pwsh (Join-Path $PSScriptRoot 'verify-public-boundary.ps1')
if ($LASTEXITCODE -ne 0) { throw 'Public boundary verification failed.' }

$engines = if ($Engine -eq 'both') { @('xelatex', 'lualatex') } else { @($Engine) }
$specimens = @(
    [pscustomobject]@{ Name = 'feature'; Source = 'examples/profile-demo.tex'; JobName = 'profile-demo' },
    [pscustomobject]@{ Name = 'symposium'; Source = 'examples/profile-demo-symposium.tex'; JobName = 'profile-demo-symposium' },
    [pscustomobject]@{ Name = 'essay'; Source = 'examples/profile-demo-essay.tex'; JobName = 'profile-demo-essay' }
)
$oldTexInputs = $env:TEXINPUTS

# v1.3 起 AtelierTeX 0.5.3 运行时直接随本仓库分发。普通使用者不得再被要求
# 额外 clone ../AtelierTeX；测试也必须拒绝依赖兄弟仓才能通过的状态。
$requiredRuntime = @(
    'atelier.cls',
    'atelier/core.sty',
    'atelier/fonts.sty',
    'atelier/bibliography.sty',
    'profiles/editorial.sty',
    'profiles/essay.sty'
)
foreach ($relativePath in $requiredRuntime) {
    $runtimePath = Join-Path $repoRoot $relativePath
    if (-not (Test-Path -LiteralPath $runtimePath)) {
        throw "Bundled AtelierTeX runtime is missing: $runtimePath"
    }
}

# 防退化说明：真实图形刊头属于公开视觉契约；测试不得允许文件被删除后依靠
# 文字 fallback 继续通过，否则 README 预览会与发布页面不一致。
$requiredMasthead = Join-Path $repoRoot 'assets/hiro2026-logo.png'
if (-not (Test-Path $requiredMasthead)) {
    throw "Required HIRO2026 masthead asset is missing: $requiredMasthead"
}

# 只把当前仓库根目录放到 TEXINPUTS 前部，并保留 TeX 系统默认路径。
# 使用平台原生路径分隔符，避免 Windows 的 ';' 在 Linux/macOS 上破坏 kpathsea。
$pathSep = [IO.Path]::PathSeparator
$env:TEXINPUTS = ".$pathSep$pathSep"
Push-Location $repoRoot
try {
    foreach ($selectedEngine in $engines) {
        foreach ($specimen in $specimens) {
            $outDir = "build/$selectedEngine/$($specimen.Name)"
            New-Item -ItemType Directory -Path $outDir -Force | Out-Null
            & latexmk "-$selectedEngine" -C "-outdir=$outDir" $specimen.Source
            if ($LASTEXITCODE -ne 0) { throw "Profile cleanup failed: $selectedEngine $($specimen.Name)" }
            & latexmk "-$selectedEngine" -halt-on-error -interaction=nonstopmode "-outdir=$outDir" $specimen.Source
            if ($LASTEXITCODE -ne 0) { throw "Profile compilation failed: $selectedEngine $($specimen.Name)" }
            $log = Join-Path $outDir "$($specimen.JobName).log"
            # 防退化说明：LuaLaTeX 的简中可变字体未绑定粗体时，标题仍可生成
            # PDF，却会把粗体静默换成常规字重；后续不得把这种输出视为通过。
            if (Select-String -Path $log -Pattern 'Missing character:|Undefined control sequence|LaTeX Error:|Citation .+ undefined|There were undefined references|Font shape .*/b/n.* undefined' -Quiet) {
                throw "Profile log QA failed: $selectedEngine $($specimen.Name)"
            }
            $pdf = Join-Path $outDir "$($specimen.JobName).pdf"
            if (-not (Test-Path $pdf)) {
                throw "Expected profile PDF was not produced: $pdf"
            }
            if (-not (Select-String -Path $log -Pattern 'hiro2026-logo\.png' -Quiet)) {
                throw "Profile did not render the HIRO2026 masthead image: $selectedEngine $($specimen.Name)"
            }
            if (-not (Select-String -Path $log -Pattern 'atelier\.cls' -Quiet)) {
                throw "Bundled atelier.cls was not loaded: $selectedEngine $($specimen.Name)"
            }
        }
    }
}
finally {
    Pop-Location
    $env:TEXINPUTS = $oldTexInputs
}
