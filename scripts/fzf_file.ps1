# FZF 文件搜索脚本（yazi Windows 版）
$ErrorActionPreference = 'Stop'
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$selected = fd --type f --hidden --follow -E .git -E node_modules -E .ccls-cache . |
    fzf +m `
        --with-shell 'pwsh -NoProfile -Command' `
        --preview 'bat --color=always --style=numbers --line-range :200 -- {}' `
        --preview-window 'down:60%:wrap'

if (-not $selected) { return }

$abs = (Resolve-Path -LiteralPath $selected).Path
& ya emit reveal $abs
