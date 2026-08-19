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
    ('279835298' + '@qq.com')
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
}
finally {
    Pop-Location
}
