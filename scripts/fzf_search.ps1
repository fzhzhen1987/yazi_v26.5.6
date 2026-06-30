# FZF 内容搜索脚本（rg + fzf，yazi Windows 版）
# 选中后用 VS Code 打开并跳转到指定行
$ErrorActionPreference = 'Stop'
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$rgPrefix = 'rg --column --line-number --no-heading --color=always --smart-case'
$env:FZF_DEFAULT_COMMAND = "$rgPrefix ""^\s*$"""

# rg 默认输出相对路径，无 Windows 盘符前缀，可安全用 ':' 切分
$result = fzf --ansi `
    --with-shell 'pwsh -NoProfile -Command' `
    --bind "change:reload:$rgPrefix {q} || cd ." `
    --delimiter ':' `
    --preview 'bat --color=always --style=numbers --highlight-line {2} -- {1}' `
    --preview-window 'down,60%,border-top,+{2}+3/3,~3' `
    --layout=reverse `
    --header 'Search in files (Enter -> open in VS Code)'

if (-not $result) { return }

$parts = $result -split ':', 4
if ($parts.Length -ge 2) {
    $file = $parts[0]
    $line = $parts[1]
    & code -g "${file}:${line}"

    # 让 yazi 也跳转到该文件并高亮（否则停在按 Ctrl-g 时的位置）
    $abs = (Resolve-Path -LiteralPath $file).Path
    & ya emit reveal $abs
}
