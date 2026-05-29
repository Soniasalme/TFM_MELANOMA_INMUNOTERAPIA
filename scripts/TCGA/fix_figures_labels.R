## fix_figures_labels.R
## Regenera las dos figuras con etiquetas limpias en español
## para sustituirlas en el PPT de defensa.

library(survival)
library(survminer)
library(ggplot2)
library(dplyr)

figures_dir <- "C:/Users/sonia/Desktop/2_TFM_MELANOMA/TFM_memoria/memoria_latex/figures"
data_dir    <- "C:/Users/sonia/Desktop/2_TFM_MELANOMA/scripts/TCGA/data_processed"

# ─────────────────────────────────────────────────────────
# 1. KAPLAN-MEIER por grupos de estadio (slide 14)
# ─────────────────────────────────────────────────────────
clinical_stage  <- readRDS(file.path(data_dir, "tcga_skcm_clinical_stage_survival.rds"))
km_fit_stage_group <- readRDS(file.path(data_dir, "km_fit_stage_group.rds"))

km_plot <- ggsurvplot(
  km_fit_stage_group,
  data          = clinical_stage,
  conf.int      = FALSE,
  pval          = TRUE,
  risk.table    = TRUE,
  censor        = TRUE,
  xlab          = "Tiempo (días)",
  ylab          = "Probabilidad de supervivencia global",
  title         = "Curvas Kaplan-Meier por grupos de estadio AJCC",
  legend.title  = "Estadio AJCC",
  legend.labs   = c("Estadio I", "Estadio II", "Estadio III", "Estadio IV"),
  ggtheme       = theme_minimal(base_size = 12),
  palette       = c("#2E86AB", "#A23B72", "#F18F01", "#C73E1D")
)

km_out <- file.path(figures_dir, "km_stage_group_plot.png")
png(km_out, width = 9, height = 7, units = "in", res = 200)
print(km_plot)
dev.off()
message("KM guardado: ", km_out)

# ─────────────────────────────────────────────────────────
# 2. FOREST PLOT Cox multivariante (slide 15)
# ─────────────────────────────────────────────────────────
cox_multi_results <- readRDS(file.path(data_dir, "cox_multivariate_results.rds"))

# Etiquetas limpias en español
label_map <- c(
  "age_years"            = "Edad (años)",
  "gendermale"           = "Sexo: masculino",
  "stage_groupStage II"  = "Estadio II vs. I",
  "stage_groupStage III" = "Estadio III vs. I",
  "stage_groupStage IV"  = "Estadio IV vs. I"
)

cox_multi_results <- cox_multi_results %>%
  mutate(
    term_label = dplyr::recode(term, !!!label_map),
    sig        = case_when(
      p_value < 0.001 ~ "p < 0.001",
      p_value < 0.01  ~ "p < 0.01",
      p_value < 0.05  ~ "p < 0.05",
      TRUE            ~ "n.s."
    )
  )

forest_plot <- ggplot(
    cox_multi_results,
    aes(x = HR, y = reorder(term_label, HR), color = sig)
  ) +
  geom_point(size = 3) +
  geom_errorbarh(aes(xmin = CI_low, xmax = CI_high), height = 0.25) +
  geom_vline(xintercept = 1, linetype = "dashed", color = "grey40") +
  scale_x_log10() +
  scale_color_manual(
    name   = "Significación",
    values = c(
      "p < 0.001" = "#C73E1D",
      "p < 0.01"  = "#F18F01",
      "p < 0.05"  = "#2E86AB",
      "n.s."      = "grey60"
    )
  ) +
  theme_minimal(base_size = 12) +
  labs(
    title = "Forest plot — Cox multivariante (TCGA-SKCM)",
    x     = "Hazard Ratio (escala logarítmica)",
    y     = NULL
  ) +
  theme(legend.position = "bottom")

forest_out <- file.path(figures_dir, "cox_multivariate_forest_plot.png")
ggsave(forest_out, plot = forest_plot, width = 8, height = 5, dpi = 200)
message("Forest plot guardado: ", forest_out)

message("Listo. Ahora ejecuta replace_ppt_figures.py para actualizar el PPT.")
