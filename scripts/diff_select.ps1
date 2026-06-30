# Yazi 脚本: diff 文件选择（Windows 版，使用 VS Code）
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
# ; 键选中第一个文件，再按 ; 选择第二个文件并对比

$DIFF_FILE = Join-Path $env:TEMP "yazi_diff_file"
$current = $args[0]

if (-not $current -or -not (Test-Path -LiteralPath $current -PathType Leaf)) {
    Write-Host "错误：请选择一个有效文件" -ForegroundColor Red
    Read-Host "按 Enter 继续"
    exit 1
}

$current = (Resolve-Path -LiteralPath $current).Path

if (Test-Path -LiteralPath $DIFF_FILE) {
    $first = (Get-Content -LiteralPath $DIFF_FILE -Raw).Trim()

    if ($first -and (Test-Path -LiteralPath $first -PathType Leaf)) {
        if ($first -eq $current) {
            Write-Host "提示：已选中此文件，请选择另一个文件进行对比" -ForegroundColor Yellow
            Read-Host "按 Enter 继续"
            exit 0
        }

        Write-Host "对比: $(Split-Path -Leaf $first) <-> $(Split-Path -Leaf $current)"
        Remove-Item -LiteralPath $DIFF_FILE -Force
        & code --diff $first $current --wait
        exit 0
    }
}

Set-Content -LiteralPath $DIFF_FILE -Value $current -NoNewline
Write-Host "已选定: $(Split-Path -Leaf $current)" -ForegroundColor Green
Write-Host "再按 ; 选择第二个文件进行对比，按 : 取消选定"
Start-Sleep -Seconds 1
