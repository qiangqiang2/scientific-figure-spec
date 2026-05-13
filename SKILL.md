---
name: scientific-figure-spec
description: Applies journal-style layout for single or multi-panel scientific figures in ggplot2/patchwork—centered titles, full four-sided data panel borders, bottom-centered (a)(b) labels, no outer composite frame. Use when exporting paper figures, editing export_paper_figures_out.R, or when the user asks for 科研作图规范, 子图标题, panel.border, or (a)(b) panel labels.
disable-model-invocation: true
---

# 科研作图规范（ggplot2 / patchwork）

## 本 Skill 包含哪些文件

| 文件 | 是否必需 | 作用 |
|------|----------|------|
| `SKILL.md` | **必需** | 规则摘要；Agent 默认读这一份。 |
| `README.md` | 强烈建议 | 克隆后**人类操作步骤**（装依赖、一键出图、Cursor 用法）。 |
| `examples.md` | 可选 | 单图 / 双子图可复制最小示例。 |
| `reference.md` | 可选 | 导出、patchwork、与代码库对齐等备忘。 |
| `scripts/render_gallery.R` | 可选 | 本地生成 `output/*.png` 验收版式。 |
| `LICENSE` | 建议 | 开源托管许可。 |
| `CHANGELOG.md` | 可选 | 版本记录。 |
| `CONTRIBUTING.md` | 可选 | PR 与修改约定。 |
| `output/.gitkeep` + `.gitignore` | 建议 | 保留目录且不把生成图提交进库。 |

**结论**：Cursor 最小仅需 `SKILL.md`；**托管 GitHub 并让别人一眼能照着做**时，以当前目录全套文件为准（从 `README.md` 开始读）。

## 必须满足的版式（原文）

单图或者多子图的标题居中，数据区有完整四边框，多子图要在子图下方标(a)(b)依次往后

## 版式细则（与上述原文对齐）

1. **标题**：无论单图还是多子图拼板，每个子图自己的 `plot.title` **水平居中**（`hjust = 0.5`）。总图级标题若存在，同样居中。
2. **数据区边框**：仅围绕**数据面板**（坐标轴与绘图区所在的 `panel`）绘制 **左、右、上、下四边闭合** 的黑色矩形框；使用 `panel.border = element_rect(colour = "black", linewidth = 0.65, fill = NA)`（线宽可在稿件内统一为 0.55–0.65，全稿一致即可）。
3. **轴线**：使用完整 `panel.border` 时，将 **`axis.line` 设为 `element_blank()`**，避免与 `panel.border` 在角上叠成双线条。
4. **多子图标号**：在每个子图 **正下方居中** 标注 `(a)`、`(b)`、`(c)` … 依次递增。推荐用各子图 `labs(caption = "(a)")` + `theme(plot.caption = element_text(hjust = 0.5, face = "bold"))`，不要用 patchwork 默认左上角字母标签代替“子图下方居中”版式（除非另行用 `plot.tag.position` 精确调到下中且格式为 `(a)`）。
5. **整体大方框**：**不要**给整张拼板或单图最外层加一圈包住“标题 + 图例 + 图区 + caption”的描边；`plot.background` 使用 **`fill = "white", colour = NA`**，避免出现“整体的大方框”。

## ggplot2 参考片段

单个子图在叠加 `theme_bw()` / `theme_classic()` 基底后：

```r
ggplot2::theme(
  plot.title = ggplot2::element_text(face = "bold", hjust = 0.5),
  plot.caption = ggplot2::element_text(hjust = 0.5, face = "bold", margin = ggplot2::margin(t = 6)),
  panel.grid.major = ggplot2::element_blank(),
  panel.grid.minor = ggplot2::element_blank(),
  panel.border = ggplot2::element_rect(colour = "black", linewidth = 0.65, fill = NA),
  axis.line = ggplot2::element_blank(),
  plot.background = ggplot2::element_rect(fill = "white", colour = NA)
)
```

多子图用 `patchwork::wrap_plots(..., ncol = n)` 拼合时：**不要**依赖默认 `plot_annotation(tag_levels = "A")` 作为最终子图标号，除非已把 tag 明确设到各面板下中且样式为 `(a)`。

## 本仓库中的实现参考

训练曲线 raw 版：`paper_figures/R/export_paper_figures_out.R` 内 `theme_fig02_dl_raw_panel()` 与 `plot_fig02_training_process_raw()`。修改线宽或边距时保持与本文 **panel.border / plot.background / caption** 规则一致。

## 其他工具（原则相同）

- **Matplotlib**：用 `ax.spines[...].set_visible(True)` 打开四条 spine，或 `ax.set_frame_on(True)`；总画布不要用 `fig.patch.set_edgecolor` 画外圈粗框除非期刊明确要求。
- **一致性**：全稿线宽、字体号、是否衬线体与目标期刊 Author Guidelines 对齐。

## 反例（避免）

- 只有左、下两条轴线、上右无闭合线，却声称“完整数据区边框”。
- 用 LOESS 或平滑曲线却在图注写 “per-epoch raw”（除非 Methods 已说明平滑）。
- 多子图仅在整张大图外圈画框，而数据区无上右边线。

## 更多内容

- **克隆后操作步骤（装依赖、一键出图、Cursor）**：见 [README.md](README.md)
- 可复制代码：见 [examples.md](examples.md)
- 导出、patchwork、与仓库对齐、出图前检查清单：见 [reference.md](reference.md)
