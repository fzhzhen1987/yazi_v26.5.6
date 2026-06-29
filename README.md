# yazi 配置（Linux + Windows 双套）

两套 yazi 配置的**唯一文档**（Linux 和 Windows 都看这一份，均为 yazi 26.5.6）。实际部署位置：

| 平台    | 实际部署位置 |
|---------|--------------|
| Linux   | `~/.config/yazi/` |
| Windows | `%APPDATA%\yazi\config\`（即 `C:\Users\<user>\AppData\Roaming\yazi\config\`） |

**配置分别放在 `linux` / `windows` 两个分支**（`master` 只留这份文档和 `.stop_gun` 占位）。每个分支的根目录就是一整套配置，checkout 出来直接是部署内容——仍需复制/同步到各平台的实际配置目录（Linux `~/.config/yazi/`、Windows `%APPDATA%\yazi\config\`）才生效。

---

## 分支与目录结构

配置不放在 `master`，而在两个分支里——**每个分支的根目录就是一整套完整配置**，checkout 出来直接部署到对应平台：

| 分支 | 部署到 | 脚本语言 / 子终端 |
|------|--------|-------------------|
| `linux`   | `~/.config/yazi/`        | bash / zsh |
| `windows` | `%APPDATA%\yazi\config\` | PowerShell / pwsh |

`master` 只保留本 README（两端唯一文档）和 `.stop_gun` 占位文件，不放配置。

**`linux` 分支根目录（→ `~/.config/yazi/`）**
```
yazi.toml        主配置
keymap.toml      键位（bash 脚本路径，zsh 子终端）
theme.toml       配色（用 url = "*/" ）
init.lua         启动 Lua（DDS + git-custom 注入）
yazi_config      shell wrapper：在 .zshrc 里 source 这个，得到 `y` 函数（退出时自动 cd）
plugins/
  smart-enter.yazi/  l 键智能进入
  ouch.yazi/         压缩包预览 + Z 压缩
  lazygit.yazi/      L 键打开 lazygit
  git-custom.yazi/   git 状态图标
scripts/
  fzf_jump.sh        f 键
  fzf_file.sh        Ctrl-f
  fzf_search.sh      Ctrl-g（rg）
  smart_preview.sh   e 键（nkf + bat）
  chmod.sh           c 键
  sudo_chmod.sh      C 键
  sudo_chown.sh      R 键
  tig.sh             T 键
  diff_select.sh     ; 键
  diff_cancel.sh     : 键
```

**`windows` 分支根目录（→ `%APPDATA%\yazi\config\`）**
```
yazi.toml        主配置
keymap.toml      键位（pwsh 脚本路径，pwsh 子终端，多了 E 键）
theme.toml       配色（用 url = "*/"）
init.lua         启动 Lua（DDS + git-custom + mime-ext 注入）
package.toml     ya pkg 自动维护的清单（mime-ext）
plugins/
  smart-enter.yazi/  l 键
  ouch.yazi/         同 Linux
  lazygit.yazi/      同 Linux
  git-custom.yazi/   git 状态图标
  mime-ext.yazi/     ya pkg 拉的社区插件（按扩展名查 MIME，避开 file.exe 卡顿）
scripts/
  fzf_jump.ps1
  fzf_file.ps1
  fzf_search.ps1     选中后用 VS Code 跳转到行
  smart_preview.ps1  e 键（直接 bat，无 nkf）
  tig.ps1
  diff_select.ps1    ; 键，VS Code --diff
  diff_cancel.ps1
```

> 两个分支都额外带一个 `.stop_gun` 占位文件（继承自 `master` 的第一个提交，用于让各分支共享同一个根，方便互相 merge），部署时忽略它即可。
>
> 安装依赖工具和部署到各平台的步骤，统一记在系统部署文档里，不在本仓库重复。

---

## 共同的核心键位（两边都一样）

`ijkl` 导航是这套配置的招牌，跟其他键位一起列在这：

### 移动 / 选择
| 键 | 作用 |
|---|---|
| `i` / `k` | 上 / 下 |
| `j` / `l` | 父目录 / 子目录或打开 |
| `gg` / `G` | 顶部 / 底部 |
| `H` | 历史回退 |
| `<Space>` | 选中切换 |
| `v` / `V` | visual 选 / 反选 |
| `Ctrl-a` / `Ctrl-r` | 全选 / 反选 |

### 文件操作
| 键 | 作用 |
|---|---|
| `dd` | 剪切 |
| `yy` | 复制 |
| `p` | 粘贴 |
| `D` | 删除（回收站） |
| `M` / `N` | 新建目录 / 文件 |
| `r` / `A` | 重命名（光标在扩展名前 / 末尾） |
| `yp/yd/yf/yn` | 复制路径/目录路径/文件名/文件名(无扩展名) |

### 显示
| 键 | 作用 |
|---|---|
| `z` 或 `.` | 显隐藏文件 |
| `ms/mp/mb/mm/mo/mn` | linemode：大小/权限/创建/修改/所有者/无 |
| `,m/,s/,a/,n` | 排序：修改时间/大小/字母/自然（大写=反序） |

### 搜索
| 键 | 作用 |
|---|---|
| `f` | fzf 跳转 |
| `Ctrl-f` | fzf 文件 |
| `Ctrl-g` | fzf rg 内容搜索 |
| `s` / `S` | 内置 fd / rg 搜索 |
| `/` `?` `n` `N` | 当前目录 find |

### Git
| 键 | 作用 |
|---|---|
| `T` | tig |
| `L` | lazygit |
| `;` `:` | diff 选定 / 取消 |

### 其他
| 键 | 作用 |
|---|---|
| `e` | 全屏 bat 预览 |
| `Z` | 压缩成 zip（ouch） |
| `o` / `O` / `Enter` | 打开 / 选择打开方式 / 打开 |
| `h` | 子终端（Linux: zsh，Windows: pwsh） |
| `w` | 任务面板 |
| `q` / `Q` | 退出（Q 不写 cwd-file） |
| `t` | 新 tab；`1..9` 切 tab |
| `~` / `F1` | 帮助 |

---

## 两边的差异（仅列不同）

| 键 / 功能 | Linux | Windows |
|---|---|---|
| `c` | chmod 修改权限 | （无） |
| `C` | sudo chmod | （无） |
| `R` | sudo chown | （无） |
| `E` | （无） | 在 Explorer 打开当前目录 |
| `e` 预览 | nkf + bat（日语编码转换） | bat 直接 |
| `;` diff 工具 | nvim -d | code --diff --wait |
| Ctrl-g 选中后 | `$EDITOR +line file` | `code -g file:line` |
| `h` 子终端 | `INSIDE_YAZI=1 zsh` | `pwsh -NoLogo` |
| `[opener] open` | `xdg-open` | `start ""` |
| `[opener] reveal` | `xdg-open $(dirname …)` | `explorer /select,…` |
| `[opener] play` | `mpv --force-window`（未装则不可用） | `start ""` |
| `[opener] extract_zip` | `unzip -q`（避开 ouch 的 symlink bug） | `ouch d -y`（Windows 上 ouch 没这 bug） |
| 解压触发键 | 在压缩包上按 `l` | 同 |
| MIME 检测 | 默认 `file(1)` | `mime-ext`（避免 `file.exe` 每文件 fork 一次的卡顿） |

---

## 共用特性

- **DDS 跨实例剪贴板**：两端 `init.lua` 都用 `require("session"):setup { sync_yanked = true }`，多个 yazi 实例之间共享 yank 剪贴板。
- **`yazi_config` wrapper（`y` 函数）**：source 后用 `y` 启动 yazi，退出时自动 cd 到当前目录（Linux 是 `yazi_config`，Windows 用 pwsh 版 `y` 函数，效果相同）。
- **Neovim 集成（Linux）**：`yazi.nvim` 插件，`<leader>ra` 在浮动窗口打开 yazi（兼容 Neovim 0.9.4）。

---

## 维护建议

1. **改完一边记得评估另一边要不要也改**——多数键位/功能改动两边都要同步
2. **共用的 Lua 插件**（`ouch.yazi`、`lazygit.yazi`、`smart-enter.yazi`）改了一边就 diff 到另一边
3. 想加新插件优先用 `ya pkg`（两端都已支持）；记录在 `package.toml` 里方便迁移
4. 改 keymap 之前先看 `prepend_keymap` 段（自定义） vs `keymap` 段（默认+被覆盖），避免冲突
5. **插件目录名必须 kebab-case**（连字符，如 `smart-enter.yazi`）——用下划线会报 `Plugin name must be in kebab-case`

---

