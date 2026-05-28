# =============================================================================
# environment.R
# Documentación del entorno R utilizado en el análisis
#
# Ejecutar este script para verificar que los paquetes necesarios están
# instalados con versiones compatibles, e instalarlos si no lo están.
# =============================================================================

# --- Versión de R recomendada ------------------------------------------------
# R >= 4.3.0

if (as.numeric(R.Version()$major) < 4) {
  warning("Se recomienda R >= 4.3.0. Versión actual: ", R.version.string)
}

# --- Instalación de paquetes -------------------------------------------------

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Paquetes CRAN
paquetes_cran <- c(
  "dplyr",
  "tibble",
  "ggplot2",
  "readr",
  "stringr",
  "survival",
  "survminer",
  "pROC",
  "knitr",
  "kableExtra",
  "here"
)

for (pkg in paquetes_cran) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Paquetes Bioconductor
paquetes_bioc <- c(
  "limma",           # >= 3.54 — Análisis diferencial (lmFit + eBayes; voom para RNA-seq)
  "SummarizedExperiment", # >= 1.28 — Contenedor de datos ómicos
  "GEOquery",        # >= 2.66 — Descarga de datos GEO
  "TCGAbiolinks",    # >= 2.26 — Descarga de datos TCGA
  "clusterProfiler", # >= 4.6  — ORA sobre Gene Ontology (GO-BP)
  "org.Hs.eg.db",    # >= 3.16 — Conversión de identificadores Ensembl -> Entrez
  "edgeR",           # Soporte para limma-voom en RNA-seq
  "S4Vectors"
)

for (pkg in paquetes_bioc) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg)
  }
}

# --- Verificación de versiones -----------------------------------------------

message("\n===== Entorno R =====")
message("R version: ", R.version.string)
message("Platform:  ", R.version$platform)
message("")

todos_paquetes <- c(paquetes_cran, paquetes_bioc)

message("===== Versiones de paquetes =====")
for (pkg in todos_paquetes) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    v <- as.character(packageVersion(pkg))
    message(sprintf("  %-25s %s", pkg, v))
  } else {
    message(sprintf("  %-25s NO INSTALADO", pkg))
  }
}

# --- Guardar sessionInfo completo --------------------------------------------

si <- sessionInfo()
sink("sessionInfo.txt")
print(si)
sink()
message("\nsessionInfo completo guardado en sessionInfo.txt")
