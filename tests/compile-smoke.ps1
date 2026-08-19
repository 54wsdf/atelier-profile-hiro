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

$coreRoot = (Resolve-Path (Join-Path $repoRoot '../AtelierTeX')).Path
$engines = if ($Engine -eq 'both') { @('xelatex', 'lualatex') } else { @($Engine) }
$specimens = @(
    [pscustomobject]@{ Name = 'feature'; Source = 'examples/profile-demo.tex'; JobName = 'profile-demo' },
    [pscustomobject]@{ Name = 'symposium'; Source = 'examples/profile-demo-symposium.tex'; JobName = 'profile-demo-symposium' },
    [pscustomobject]@{ Name = 'essay'; Source = 'examples/profile-demo-essay.tex'; JobName = 'profile-demo-essay' }
)
$oldTexInputs = $env:TEXINPUTS

# 防退化说明：真实图形刊头属于公开视觉契约；测试不得允许文件被删除后依靠
# 文字 fallback 继续通过，否则 README 预览会与发布页面不一致。
$requiredMasthead = Join-Path $repoRoot 'assets/hiro2026-logo.png'
if (-not (Test-Path $requiredMasthead)) {
    throw "Required HIRO2026 masthead asset is missing: $requiredMasthead"
}

# 防退化说明：测试必须显式加载相邻的公共核心，不能因开发机全局安装过旧类文件而误通过；
# TEXINPUTS 只列相对源码仓根目录，不使用递归 // 或含中文的绝对路径：前者会误读
# 兄弟仓 build 中的同名辅助文件，后者在 Windows XeTeX 子进程中会受代码页转换影响。
$env:TEXINPUTS = '.;../AtelierTeX;'
Push-Location $repoRoot
try {
    foreach ($selectedEngine in $engines) {
        foreach ($specimen in $specimens) {
            $outDir = "build/$selectedEngine/$($specimen.Name)"
            New-Item -ItemType Directory -Path $outDir -Force | Out-Null
            # 防退化说明：profile 依赖兄弟目录中的 AtelierTeX；所有具名排版都必须
            # 强制重建，不能让 latexmk 复用旧日志或只验证 README 当前显示的一种。
            & latexmk "-$selectedEngine" -C "-outdir=$outDir" $specimen.Source
            if ($LASTEXITCODE -ne 0) { throw "Profile cleanup failed: $selectedEngine $($specimen.Name)" }
            & latexmk "-$selectedEngine" -halt-on-error -interaction=nonstopmode "-outdir=$outDir" $specimen.Source
            if ($LASTEXITCODE -ne 0) { throw "Profile compilation failed: $selectedEngine $($specimen.Name)" }
            $log = Join-Path $outDir "$($specimen.JobName).log"
            if (Select-String -Path $log -Pattern 'Missing character:|Undefined control sequence|LaTeX Error:|Citation .+ undefined|There were undefined references' -Quiet) {
                throw "Profile log QA failed: $selectedEngine $($specimen.Name)"
            }
            $pdf = Join-Path $outDir "$($specimen.JobName).pdf"
            if (-not (Test-Path $pdf)) {
                throw "Expected profile PDF was not produced: $pdf"
            }
            if (-not (Select-String -Path $log -Pattern 'hiro2026-logo\.png' -Quiet)) {
                throw "Profile did not render the HIRO2026 masthead image: $selectedEngine $($specimen.Name)"
            }
        }
    }
}
finally {
    Pop-Location
    $env:TEXINPUTS = $oldTexInputs
}
