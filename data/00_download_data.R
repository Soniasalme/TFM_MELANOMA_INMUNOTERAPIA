# =============================================================================
# 00_download_data.R
# Descarga de datos públicos para el TFM: Biomarcadores en melanoma
#
# Este script reproduce la descarga de todos los datasets utilizados en el
# análisis. Los datos se obtienen directamente de repositorios públicos
# (GEO y TCGA/GDC) y no requieren registro previo.
#
# Tiempo estimado de descarga: 30–60 minutos (depende de la conexión)
# Espacio necesario: ~3 GB (principalmente TCGA RNA-seq)
# =============================================================================

# --- Paquetes necesarios -----------------------------------------------------

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

paquetes_bioc <- c("GEOquery", "TCGAbiolinks", "SummarizedExperiment")
for (pkg in paquetes_bioc) {
  if (!requireNamespace(pkg, quietly = TRUE))
    BiocManager::install(pkg)
}

library(GEOquery)
library(TCGAbiolinks)

# --- Rutas de salida ---------------------------------------------------------

dir.create("GEO_raw",  showWarnings = FALSE, recursive = TRUE)
dir.create("data_raw", showWarnings = FALSE, recursive = TRUE)

# =============================================================================
# BLOQUE PREDICTIVO GEO
# Cinco cohortes con datos de expresión génica y respuesta a inmunoterapia.
# Todas las descargas usan GSEMatrix = TRUE para obtener la matriz normalizada.
# =============================================================================

# --- GSE78220 — Descubrimiento (tumor, RNA-seq, pembrolizumab anti-PD-1) ----
# Hugo et al. (2016) Cell 165:35-44. n = 25 pacientes.

gse78220 <- getGEO("GSE78220", GSEMatrix = TRUE, destdir = "GEO_raw")
saveRDS(gse78220, file = "GEO_raw/gse78220_raw.rds")
message("GSE78220 descargado.")

# --- GSE215868 — Validación tumoral NanoString (anti-PD-1) ------------------
# n = 105 pacientes.

gse215868 <- getGEO("GSE215868", GSEMatrix = TRUE, destdir = "GEO_raw")
saveRDS(gse215868, file = "GEO_raw/gse215868_raw.rds")
message("GSE215868 descargado.")

# --- GSE211645 — Validación exploratoria (tumor, NanoString, anti-CTLA-4) ---
# n = 40 pacientes.

gse211645 <- getGEO("GSE211645", GSEMatrix = TRUE, destdir = "GEO_raw")
saveRDS(gse211645, file = "GEO_raw/gse211645_raw.rds")
message("GSE211645 descargado.")

# --- GSE91061 — Validación tumoral RNA-seq independiente (nivolumab) ---------
# Riaz et al. (2017) Cell 171:934-949. n = 49 pacientes evaluables.
# Nota: biopsias tumorales pre-tratamiento y on-treatment; se usan las pre.

gse91061 <- getGEO("GSE91061", GSEMatrix = TRUE, destdir = "GEO_raw")
saveRDS(gse91061, file = "GEO_raw/gse91061_raw.rds")
message("GSE91061 descargado.")

# --- GSE94873 — Sensibilidad periférica (sangre, NanoString, tremelimumab) --
# Friedlander et al. (2017). n = 360 muestras de sangre periférica.

gse94873 <- getGEO("GSE94873", GSEMatrix = TRUE, destdir = "GEO_raw")
saveRDS(gse94873, file = "GEO_raw/gse94873_raw.rds")
message("GSE94873 descargado.")

# =============================================================================
# BLOQUE PRONÓSTICO TCGA-SKCM
# Datos clínicos y de expresión génica de 470 pacientes con melanoma cutáneo.
# La descarga de RNA-seq (~2 GB) requiere conexión estable.
# =============================================================================

# --- Datos clínicos ----------------------------------------------------------

clinical_tcga <- GDCquery_clinic(
  project = "TCGA-SKCM",
  type    = "clinical"
)
write.csv(clinical_tcga,
          file      = "data_raw/tcga_skcm_clinical.csv",
          row.names = FALSE)
message("Datos clínicos TCGA-SKCM descargados: ", nrow(clinical_tcga), " pacientes.")

# --- Datos de expresión génica (RNA-seq) -------------------------------------
# ADVERTENCIA: la descarga ocupa ~2 GB y puede tardar 20-40 minutos.

query_rna <- GDCquery(
  project           = "TCGA-SKCM",
  data.category     = "Transcriptome Profiling",
  data.type         = "Gene Expression Quantification",
  workflow.type     = "STAR - Counts"
)

GDCdownload(query_rna, directory = "data_raw")

tcga_se <- GDCprepare(query_rna, directory = "data_raw")
saveRDS(tcga_se, file = "data_raw/tcga_skcm_se.rds")
message("Datos RNA-seq TCGA-SKCM preparados: ",
        ncol(tcga_se), " muestras, ", nrow(tcga_se), " genes.")

# =============================================================================
# Fin de la descarga. Los objetos .rds resultantes son la entrada de los
# scripts de análisis en scripts/GEO/ y scripts/TCGA/.
# =============================================================================
message("\nDescarga completa. Revisa GEO_raw/ y data_raw/ para los ficheros generados.")
