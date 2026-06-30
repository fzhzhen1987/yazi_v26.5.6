# Yazi 脚本: 取消 diff 选定（Windows 版）
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$DIFF_FILE = Join-Path $env:TEMP "yazi_diff_file"

if (Test-Path -LiteralPath $DIFF_FILE) {
    $selected = (Get-Content -LiteralPath $DIFF_FILE -Raw).Trim()
    Remove-Item -LiteralPath $DIFF_FILE -Force
    Write-Host "已取消选定: $(Split-Path -Leaf $selected)" -ForegroundColor Yellow
} else {
    Write-Host "当前没有选定的文件"
}

Start-Sleep -Milliseconds 500
