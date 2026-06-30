# FZF 快速跳转脚本（yazi Windows 版）
$ErrorActionPreference = 'Stop'
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$selected = fd --hidden --follow -E .git -E node_modules -E .ccls-cache . |
    fzf --reverse --header='Jump to location' `
        --with-shell 'pwsh -NoProfile -Command' `
        --preview 'if (Test-Path -LiteralPath {} -PathType Container) { Get-ChildItem -LiteralPath {} -Name } else { bat --color=always --style=numbers --line-range :200 -- {} }' `
        --preview-window 'down:60%:wrap'

if (-not $selected) { return }

$abs = (Resolve-Path -LiteralPath $selected).Path

if (Test-Path -LiteralPath $abs -PathType Container) {
    & ya emit cd $abs
} else {
    & ya emit reveal $abs
}
