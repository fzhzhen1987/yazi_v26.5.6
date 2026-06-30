# 智能预览脚本（bat 全屏，yazi Windows 版）
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$file = $args[0]

if (-not $file) {
    Write-Host "错误：未指定文件" -ForegroundColor Red
    Read-Host "按 Enter 继续"
    exit 1
}

if (-not (Test-Path -LiteralPath $file)) {
    Write-Host "错误：文件不存在: $file" -ForegroundColor Red
    Read-Host "按 Enter 继续"
    exit 1
}

bat --color=always --paging=always $file
