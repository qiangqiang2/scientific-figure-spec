# 参考与对齐说明

## 克隆后第一步

打开同目录 **[README.md](README.md)**：安装 R 包 → 运行 `scripts/render_gallery.R` → 查看 `output/demo_*.png` → 在 Cursor 中 @ 引用本 skill。

## Cursor Skill 规范

- **最小集**：仅 `SKILL.md` 即符合 Cursor Agent Skill 目录约定（`skill-name/SKILL.md`）。
- **扩展集**：`examples.md`、`reference.md` 采用一层链接，从 `SKILL.md` 指入即可；Agent 可按需读取。

## 与 DL-mouse 代码对齐

| 规范项 | 仓库中的参考 |
|--------|----------------|
| 子图标题居中、`caption` 为 `(a)(b)`、`plot.background` 无描边 | `theme_fig02_dl_raw_panel()` |
| 双子图训练曲线 | `plot_fig02_training_process_raw()` |
| 数据区 `panel.border` 线宽 **0.65** | 与 `SKILL.md` 一致；LOESS 版 `theme_fig02_dl` 仍为 0.55 时属另一套图风格，全稿若统一可再改。 |

## 导出与版式

- **矢量**：期刊优先 PDF/SVG（文字可编辑）。
- **位图**：TIFF 常用 300–600 dpi；宽度按稿约单栏/双栏 mm 设置。
- **底部标号被裁切**：增大 `plot.margin` 的 **下**边距（如 `margin(..., b = 22)`）或略增高 `ggsave` / 设备高度。

## patchwork 注意

- `wrap_plots` 后**不要**默认依赖左上角 `A/B` tag 作为正式子图编号，除非已用 `theme(plot.tag.position = ...)` 调到**下中**且字符串为 `(a)` 形式。
- 总图级 `plot_annotation(title = ...)` 若使用，标题同样建议 `hjust = 0.5`（在 `theme` 里设 `plot.title`）。

## Matplotlib 对照

- 四边数据框：`for s in ax.spines.values(): s.set_visible(True)` 或各 spine `set_visible(True)`，线宽与 ggplot 稿件统一。
- 避免 `fig.patch.set_edgecolor('k')` 作为默认「整张大外框」，除非与编辑部约定一致。

## 检查清单（出图前）

- [ ] 每个子图 `plot.title` 已 `hjust = 0.5`
- [ ] `panel.border` 四边闭合、`axis.line` 已 blank（或与 border 不重复）
- [ ] 多子图 `(a)(b)(c)…` 在**各子图下方居中**
- [ ] `plot.background` 无整体描边（`colour = NA`）
- [ ] Methods/图注与曲线是否平滑、轴是否 log 等**表述一致**
