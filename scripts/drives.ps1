# 盘符选择器（yazi Windows 版）
# 列出所有文件系统盘符（C:\ D:\ ...），用 fzf 选一个跳过去；插 U 盘也会自动出现。
$ErrorActionPreference = 'Stop'
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 只取真正的盘符根（C:\、D:\ 这种），排除 Temp 等伪驱动器
$drives = Get-PSDrive -PSProvider FileSystem |
    Where-Object { $_.Root -match '^[A-Za-z]:\\$' } |
    ForEach-Object { $_.Root }

$selected = $drives |
    fzf --reverse --header='Switch drive' `
        --with-shell 'pwsh -NoProfile -Command' `
        --preview 'Get-ChildItem -LiteralPath {} -Force -Name -ErrorAction SilentlyContinue' `
        --preview-window 'down:60%:wrap'

if (-not $selected) { return }

& ya emit cd $selected.Trim()
