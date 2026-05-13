# scientific-figure-spec（科研作图规范 · Cursor Skill）

本目录是一份可 **单独复制到任意 Git 仓库** 的 Agent Skill：单图/多子图 **标题居中**、**数据区四边闭合框**（`panel.border`）、多子图在 **各子图下方居中** 标 `(a)(b)(c)…`，且 **不要** 整张拼板最外层的「大方框」。

## 目录里有什么（照着做需要看的文件）

| 文件 | 用途 |
|------|------|
| [README.md](README.md) | 入口：安装依赖、一键出图、Cursor 用法（本文件）。 |
| [SKILL.md](SKILL.md) |读取的规则正文。 
| [examples.md](examples.md) | 可复制进项目的 ggplot2 代码片段。 |
| [reference.md](reference.md) | 导出 DPI、patchwork 注意、检查清单、与 DL-mouse 对齐说明。 |
| [scripts/render_gallery.R](scripts/render_gallery.R) | **一键出图**：生成单图 + 双子图示例 PNG（验证环境）。 |
| `output/` | 脚本生成的图片目录（仅保留 `.gitkeep`，PNG 不入库见 `.gitignore`）。 |
| [LICENSE](LICENSE) | MIT（示例脚本与文档可按需再授权）。 |
| [CHANGELOG.md](CHANGELOG.md) | 版本记录。 |
| [CONTRIBUTING.md](CONTRIBUTING.md) | 参与修改与 PR 约定。 |

## 怎么做

### 1. 安装 R 依赖

在已安装 [R](https://www.r-project.org/)（建议 ≥ 4.1）的前提下执行：

```bash
Rscript -e "install.packages(c('ggplot2','patchwork'), repos='https://cloud.r-project.org')"
```

### 2. 一键出示例图

在仓库根目录执行：

**Linux / macOS**

```bash
cd .cursor/skills/scientific-figure-spec
Rscript scripts/render_gallery.R
```

**Windows（PowerShell）**

```powershell
Set-Location .cursor/skills/scientific-figure-spec
Rscript scripts/render_gallery.R
```

成功后查看：`scientific-figure-spec/output/demo_single_panel.png` 与 `demo_two_panel.png`。

### 3. 在 Cursor 里用这个 Skill

1. 将整个 `scientific-figure-spec` 文件夹复制到你项目的 `.cursor/skills/` 下（没有则新建 `skills` 目录）。
2. 在对话里 **@ 引用** `scientific-figure-spec` 或说明「按科研作图规范出图」，Agent 会优先读 `SKILL.md`。
3. 需要长示例时让 Agent 打开同目录的 `examples.md` / `reference.md`。

> 个人全局使用：可复制到 `~/.cursor/skills/scientific-figure-spec/`。**不要**写入 `~/.cursor/skills-cursor/`（Cursor 内置保留目录）。

### 4. 只想要规范、不装 Cursor

直接阅读 [SKILL.md](SKILL.md) 与 [examples.md](examples.md)，把其中的 `theme(...)` 和 `labs(caption=...)` 拷进自己的 R 项目即可。

## Star History
[![Star History Chart](https://api.star-history.com/svg?repos=yuanlz0825/nature-skills&type=Date)](https://star-history.com/#qiangqiang2/scientific-figure-spec&Date)


## 版本

当前为 **1.0.0**，变更见 [CHANGELOG.md](CHANGELOG.md)。参与修改见 [CONTRIBUTING.md](CONTRIBUTING.md)。
