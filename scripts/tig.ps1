# 使用 tig 查看 git 状态（yazi Windows 版）

# 检查是否在 git 仓库中
$null = & git rev-parse --git-dir 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "错误: 当前目录不是 git 仓库" -ForegroundColor Red
    Read-Host "按 Enter 继续"
    exit 1
}

# 启动 tig
& tig
