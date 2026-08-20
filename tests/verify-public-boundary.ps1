[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$forbiddenTerms = @(
    ('努' + '时代'),
    ('nu-' + 'era'),
    ('棉花' + '娃娃'),
    ('PRIVATE-' + 'MANUSCRIPT'),
    ('LOCAL-' + 'EVIDENCE-' + 'VAULT'),
    ('279835298' + '@qq.com'),
    ('许可记录由维护者' + '保存')
)
$forbidden = ($forbiddenTerms | ForEach-Object { [regex]::Escape($_) }) -join '|'

# 防退化说明：这些词对应已从公开模板撤出的具体稿件、内部路径和私人邮箱；
# 后续不得因旧分支仍可恢复而重新把它们带入当前树或新发布历史。
Push-Location $repoRoot
try {
    $args = @('-n', '-i', '--hidden', '--glob', '!build/**', '--glob', '!.git/**')
    $hits = & rg @args $forbidden .
    if ($LASTEXITCODE -eq 0) {
        $hits | Write-Error
        throw 'Public repository content boundary check failed.'
    }
    if ($LASTEXITCODE -ne 1) {
        throw "rg public boundary scan failed with exit code $LASTEXITCODE"
    }

    $requiredLegalFiles = @(
        'LICENSE',
        'LICENSE_SCOPE.md',
        'manifest.txt',
        'LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt'
    )
    foreach ($relativePath in $requiredLegalFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $relativePath))) {
            throw "Required license boundary file is missing: $relativePath"
        }
    }

    # 防退化说明：LPPL 不能只保留根目录协议正文；每个可执行类/样式入口还须
    # 声明维护状态、当前维护者与 Work 清单，后续不得将其缩减为模糊的仓库级许可。
    $requiredSourceNotices = @(
        'Copyright 2026 54wsdf',
        'SPDX-License-Identifier: LPPL-1.3c',
        'LPPL maintenance status `maintained`',
        'The Current Maintainer of this work is 54wsdf',
        'files listed in manifest.txt'
    )
    $sourceFiles = Get-ChildItem -LiteralPath $repoRoot -Recurse -File |
        Where-Object { $_.Extension -in @('.cls', '.sty') }
    foreach ($sourceFile in $sourceFiles) {
        $sourceText = Get-Content -LiteralPath $sourceFile.FullName -Raw -Encoding utf8
        foreach ($notice in $requiredSourceNotices) {
            if (-not $sourceText.Contains($notice)) {
                throw "Missing LPPL source notice '$notice': $($sourceFile.FullName)"
            }
        }
    }

    # 防退化说明：Logo 许可来源必须可公开核验，并与当前二进制摘要绑定；后续
    # 不得恢复成“维护者另存证据”的不可审计表述，也不得把素材并入 LPPL Work。
    $logoLicensePath = Join-Path $repoRoot 'LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt'
    $logoLicenseText = Get-Content -LiteralPath $logoLicensePath -Raw -Encoding utf8
    foreach ($evidence in @(
        '6a82f39c00000000080104dc',
        '自由取用HIRO2026的logo进行使用或创作',
        'LicenseRef-HIRO2026-Logo-Public-Use',
        '自愿建议，不是本记录新增的强制条件'
    )) {
        if (-not $logoLicenseText.Contains($evidence)) {
            throw "Logo public permission evidence is incomplete: $evidence"
        }
    }

    $expectedAssetHashes = @{
        'assets/hiro2026-logo.png' = '3DE69BE0CD0F8C636AFDCAE8F879C30D03CE30A7985467A9A745610C366E45CE'
        'assets/hiro2026-mark.png' = 'A80DA21D875B3807A16065A4EC29B291DE483837F65DA7F6F9D06BA25D2F2B0A'
    }
    foreach ($entry in $expectedAssetHashes.GetEnumerator()) {
        $assetPath = Join-Path $repoRoot $entry.Key
        $actualHash = (Get-FileHash -LiteralPath $assetPath -Algorithm SHA256).Hash
        if ($actualHash -ne $entry.Value) {
            throw "Visual asset hash changed without a license record update: $($entry.Key)"
        }
    }

    $requiredVisualFiles = @(
        'assets/hiro2026-logo.png',
        'assets/hiro2026-mark.png',
        'docs/assets/rendered/hiro2026-feature-page1.png',
        'docs/assets/rendered/hiro2026-symposium-page1.png',
        'docs/assets/rendered/hiro2026-essay-page1.png'
    )
    foreach ($relativePath in $requiredVisualFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $relativePath))) {
            throw "Required licensed visual file is missing: $relativePath"
        }
        if (-not $logoLicenseText.Contains($relativePath)) {
            throw "Visual file is missing from the public permission record: $relativePath"
        }
    }

    $manifestFiles = Get-Content -LiteralPath (Join-Path $repoRoot 'manifest.txt') -Encoding utf8 |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ -and -not $_.StartsWith('#') } |
        ForEach-Object { $_.Replace('\', '/') }
    $separatelyLicensed = @(
        '.gitignore',
        'LICENSE',
        'LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt'
    ) + $requiredVisualFiles
    $repositoryFiles = & git ls-files --cached --others --exclude-standard |
        ForEach-Object { $_.Trim().Replace('\', '/') } |
        Where-Object { $_ }
    if ($LASTEXITCODE -ne 0) {
        throw "git ls-files failed with exit code $LASTEXITCODE"
    }
    $unclassified = $repositoryFiles | Where-Object {
        $_ -notin $manifestFiles -and $_ -notin $separatelyLicensed
    }
    $staleManifestEntries = $manifestFiles | Where-Object { $_ -notin $repositoryFiles }
    $misclassifiedAssets = $separatelyLicensed | Where-Object {
        $_ -notin @('.gitignore', 'LICENSE', 'LICENSES/LicenseRef-HIRO2026-Logo-Public-Use.txt') -and
        $_ -in $manifestFiles
    }
    if ($unclassified) {
        throw "Repository files have no license classification:`n$($unclassified -join "`n")"
    }
    if ($staleManifestEntries) {
        throw "manifest.txt contains missing files:`n$($staleManifestEntries -join "`n")"
    }
    if ($misclassifiedAssets) {
        throw "Separately licensed visual assets entered the LPPL Work manifest:`n$($misclassifiedAssets -join "`n")"
    }
}
finally {
    Pop-Location
}
