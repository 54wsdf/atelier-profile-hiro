[CmdletBinding()]
param(
    [ValidateSet('xelatex', 'lualatex')]
    [string]$Engine = 'xelatex',
    [ValidateRange(120, 600)]
    [int]$Dpi = 240
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$renderedDir = Join-Path $repoRoot 'docs/assets/rendered'
$previews = @(
    [pscustomobject]@{
        Name = 'feature'
        PdfRelative = "build/$Engine/feature/profile-demo.pdf"
        PreviewRelative = 'docs/assets/rendered/hiro2026-feature-page1'
    },
    [pscustomobject]@{
        Name = 'symposium'
        PdfRelative = "build/$Engine/symposium/profile-demo-symposium.pdf"
        PreviewRelative = 'docs/assets/rendered/hiro2026-symposium-page1'
    },
    [pscustomobject]@{
        Name = 'essay'
        PdfRelative = "build/$Engine/essay/profile-demo-essay.pdf"
        PreviewRelative = 'docs/assets/rendered/hiro2026-essay-page1'
    }
)

# 防退化说明：README 预览必须只用当前仓库内的 hiro2026.cls、内置 AtelierTeX
# 运行时和真实 HIRO2026 资产编译生成，不能依赖兄弟仓或开发机上的外部源码。
& pwsh (Join-Path $PSScriptRoot 'compile-smoke.ps1') -Engine $Engine
if ($LASTEXITCODE -ne 0) { throw "HIRO2026 specimen build failed: $Engine" }
foreach ($item in $previews) {
    $pdf = Join-Path $repoRoot $item.PdfRelative
    if (-not (Test-Path $pdf)) { throw "Expected specimen PDF was not produced: $pdf" }
}

$pdftoppmCandidates = @(Get-Command pdftoppm -All -ErrorAction SilentlyContinue)
$pdftoppm = $null
if ($IsWindows) {
    $pdftoppm = $pdftoppmCandidates |
        Where-Object { $_.CommandType -eq 'Application' -and $_.Source -match '\.exe$' } |
        Select-Object -First 1
}
if (-not $pdftoppm) {
    $pdftoppm = $pdftoppmCandidates |
        Where-Object { $_.CommandType -eq 'Application' -and $_.Source -notmatch '\.cmd$' } |
        Select-Object -First 1
}
if (-not $pdftoppm) {
    throw 'A working pdftoppm executable (Poppler) is required to render the README preview.'
}

New-Item -ItemType Directory -Path $renderedDir -Force | Out-Null

# 防退化说明：Windows 环境可能同时存在命令包装器与 Poppler 可执行文件；这里
# 优先选择可执行文件，并为每种具名排版生成独立的白底 RGB 页面。
Push-Location $repoRoot
try {
    foreach ($item in $previews) {
        $preview = Join-Path $repoRoot "$($item.PreviewRelative).png"
        Remove-Item $preview -Force -ErrorAction SilentlyContinue
        $renderArgs = @(
            '-f', '1', '-singlefile', '-png', '-r', $Dpi,
            $item.PdfRelative,
            $item.PreviewRelative
        )
        & $pdftoppm.Source @renderArgs
        if ($LASTEXITCODE -ne 0) { throw "README preview rendering failed: $($item.Name)" }
    }
}
finally {
    Pop-Location
}

# 防退化说明：文件存在或 PNG 签名不足以证明图像完整；这里逐张解码页面末端
# 像素，并检查 A4 尺寸与不透明 RGB 色彩类型。
Add-Type -AssemblyName System.Drawing
foreach ($item in $previews) {
    $preview = Join-Path $repoRoot "$($item.PreviewRelative).png"
    if (-not (Test-Path $preview)) { throw "Preview was not produced: $preview"
    }
    $bytes = [System.IO.File]::ReadAllBytes($preview)
    if ($bytes.Length -lt 50000 -or $bytes.Length -lt 26 -or $bytes[25] -ne 2) {
        throw "Preview PNG is too small, truncated, or not opaque RGB: $preview"
    }
    $image = [System.Drawing.Image]::FromFile($preview)
    try {
        $bitmap = [System.Drawing.Bitmap]::new($image)
        try {
            $null = $bitmap.GetPixel($bitmap.Width - 2, $bitmap.Height - 2)
            $expectedWidth = [math]::Round(210 / 25.4 * $Dpi)
            $expectedHeight = [math]::Round(297 / 25.4 * $Dpi)
            if ([math]::Abs($bitmap.Width - $expectedWidth) -gt 3 -or
                [math]::Abs($bitmap.Height - $expectedHeight) -gt 3) {
                throw "Preview dimensions are not A4 at $Dpi dpi: $($bitmap.Width)x$($bitmap.Height)"
            }
        }
        finally {
            $bitmap.Dispose()
        }
    }
    finally {
        $image.Dispose()
    }
    Write-Host "[OK] Rendered $($item.Name) preview: $preview"
    Write-Host "[OK] Source PDF: $(Join-Path $repoRoot $item.PdfRelative)"
}
Write-Host "[OK] Poppler executable: $($pdftoppm.Source)"
