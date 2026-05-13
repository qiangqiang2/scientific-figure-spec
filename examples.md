# 示例（ggplot2 + patchwork）

**一键生成示例 PNG**：见同目录 [README.md](README.md) 中的 `Rscript scripts/render_gallery.R`。

以下示例与 `SKILL.md` 中的版式一致：标题居中、数据区四边 `panel.border`、子图下方居中 `(a)(b)`、无整体外框。

## 1. 单图 + 下方 (a)

单图若稿件要求也标 `(a)`，用 `caption`；若单图不标号，可省略 `caption` 与 `plot.margin` 底部加量。

```r
library(ggplot2)

p <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  labs(
    title = "MPG vs weight",
    x = "Weight",
    y = "MPG",
    caption = "(a)"
  ) +
  theme_bw(base_size = 10) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.caption = element_text(face = "bold", hjust = 0.5, margin = margin(t = 6)),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(colour = "black", linewidth = 0.65, fill = NA),
    axis.line = element_blank(),
    plot.background = element_rect(fill = "white", colour = NA),
    plot.margin = margin(8, 8, 20, 8)
  )
```

## 2. 双子图：各子图自带 (a)(b)

每个子图单独 `labs(caption = ...)`，再 `wrap_plots`；**不要**再用 `plot_annotation(tag_levels = "A")` 顶角标，除非已改为下中 `(a)` 样式。

```r
library(ggplot2)
library(patchwork)

theme_pub_panel <- function() {
  theme_bw(base_size = 10) +
    theme(
      plot.title = element_text(face = "bold", hjust = 0.5),
      plot.caption = element_text(face = "bold", hjust = 0.5, margin = margin(t = 6, b = 2)),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.border = element_rect(colour = "black", linewidth = 0.65, fill = NA),
      axis.line = element_blank(),
      plot.background = element_rect(fill = "white", colour = NA),
      plot.margin = margin(8, 8, 22, 8)
    )
}

p_left <- ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_boxplot() +
  labs(title = "MPG by cylinder", x = "Cylinders", y = "MPG", caption = "(a)") +
  theme_pub_panel()

p_right <- ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
  geom_point() +
  labs(title = "MPG vs weight", x = "Weight", y = "MPG", caption = "(b)") +
  theme_pub_panel() +
  theme(legend.position = c(0.98, 0.98), legend.justification = c(1, 1))

wrap_plots(p_left, p_right, ncol = 2)
```

## 3. 本仓库对应实现

见 `paper_figures/R/export_paper_figures_out.R`：`theme_fig02_dl_raw_panel()`、`plot_fig02_training_process_raw()`。
