# Standalone gallery for scientific-figure-spec (no DL-mouse imports).
# Run from anywhere:
#   Rscript path/to/scientific-figure-spec/scripts/render_gallery.R
# Or cd scientific-figure-spec && Rscript scripts/render_gallery.R

suppressPackageStartupMessages({
  requireNamespace("ggplot2", quietly = TRUE)
  requireNamespace("patchwork", quietly = TRUE)
})

for (p in c("ggplot2", "patchwork")) {
  if (!requireNamespace(p, quietly = TRUE)) {
    stop("Missing package: ", p, "\nInstall: install.packages(\"", p, "\")", call. = FALSE)
  }
}

ca <- commandArgs(trailingOnly = FALSE)
fp <- sub("^--file=", "", ca[grep("^--file=", ca)])
skill_root <- if (length(fp) && nzchar(fp)) {
  dirname(dirname(normalizePath(fp)))
} else {
  normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}

out_dir <- file.path(skill_root, "output")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

theme_pub_panel <- function() {
  ggplot2::theme_bw(base_size = 10) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", hjust = 0.5),
      plot.caption = ggplot2::element_text(
        face = "bold", hjust = 0.5,
        margin = ggplot2::margin(t = 6, b = 2)
      ),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.border = ggplot2::element_rect(colour = "black", linewidth = 0.65, fill = NA),
      axis.line = ggplot2::element_blank(),
      plot.background = ggplot2::element_rect(fill = "white", colour = NA),
      plot.margin = ggplot2::margin(8, 8, 22, 8)
    )
}

p_single <- ggplot2::ggplot(mtcars, ggplot2::aes(.data$wt, .data$mpg)) +
  ggplot2::geom_point() +
  ggplot2::labs(
    title = "MPG vs weight (demo)",
    x = "Weight",
    y = "MPG",
    caption = "(a)"
  ) +
  theme_pub_panel()

p_left <- ggplot2::ggplot(mtcars, ggplot2::aes(factor(.data$cyl), .data$mpg)) +
  ggplot2::geom_boxplot() +
  ggplot2::labs(title = "MPG by cylinder", x = "Cylinders", y = "MPG", caption = "(a)") +
  theme_pub_panel()

p_right <- ggplot2::ggplot(mtcars, ggplot2::aes(.data$wt, .data$mpg, colour = factor(.data$cyl))) +
  ggplot2::geom_point() +
  ggplot2::labs(title = "MPG vs weight", x = "Weight", y = "MPG", caption = "(b)") +
  theme_pub_panel() +
  ggplot2::theme(legend.position = c(0.98, 0.98), legend.justification = c(1, 1))

p_two <- patchwork::wrap_plots(p_left, p_right, ncol = 2L)

ggplot2::ggsave(
  file.path(out_dir, "demo_single_panel.png"),
  p_single, width = 4, height = 3.2, dpi = 300, bg = "white"
)
ggplot2::ggsave(
  file.path(out_dir, "demo_two_panel.png"),
  p_two, width = 7.5, height = 3.4, dpi = 300, bg = "white"
)

message("Wrote:\n  ", normalizePath(file.path(out_dir, "demo_single_panel.png"), winslash = "/"))
message("  ", normalizePath(file.path(out_dir, "demo_two_panel.png"), winslash = "/"))
