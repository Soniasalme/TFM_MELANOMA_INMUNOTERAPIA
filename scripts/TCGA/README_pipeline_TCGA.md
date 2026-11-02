# Pipeline TCGA-SKCM — Bloque Pronóstico

Este directorio contiene el análisis del bloque pronóstico del TFM, basado en datos de TCGA-SKCM (melanoma cutáneo). El objetivo es identificar variables clínicas y transcriptómicas asociadas a la supervivencia global.

---

## Orden de ejecución

| Script | Descripción | HTML |
|--------|-------------|------|
| `01_descarga_tcga_skcm_corregido.Rmd` | Descarga de datos clínicos desde TCGA-SKCM vía TCGAbiolinks. EDA inicial: edad, sexo, estadio, estado vital. | ✅ |
| `02_tcga_skcm_supervivencia.Rmd` | Construcción de variables de supervivencia (OS_time, OS_event). Filtrado de casos válidos. | ✅ |
| `04_tcga_skcm_primer_kaplan_meier.Rmd` | Curvas Kaplan-Meier globales y por sexo. Test log-rank. | ✅ |
| `05_tcga_skcm_kaplan_stage.Rmd` | Curvas Kaplan-Meier por estadio AJCC y agrupación simplificada (I-II vs III-IV). | ✅ |
| `06_tcga_skcm_cox_univariante.Rmd` | Modelos Cox univariantes por variables clínicas (edad, sexo, estadio). Forest plot. | ✅ |
| `07_tcga_skcm_cox_multivariante.Rmd` | Modelo Cox multivariante. Test proporcionalidad de hazards (Schoenfeld). | ✅ |
| `08_tcga_skcm_transcriptomics_corregido.Rmd` | Descarga y normalización de expresión RNA-seq (log-CPM). Selección de genes más variables. | ✅ |
| `10_tcga_skcm_integracion_clinica_transcriptomica.Rmd` | Integración de datos clínicos y transcriptómicos. Construcción de master dataset. | ✅ |
| `11_tcga_cox_transcriptomico.Rmd` | Screening Cox univariante gen a gen sobre 5.000 genes (459 pacientes). Ranking por FDR. Identificación de genes candidatos. | ✅ |
| `12_tcga_kaplan_genes.Rmd` | Curvas Kaplan-Meier para top 10 genes candidatos (estratificación por mediana de expresión). | ⚠️ sin HTML |
| `13_tcga_anotacion_ora.Rmd` | Anotación Ensembl → símbolo/Entrez, volcano plot del screening Cox y ORA GO-BP (genes protectores y de riesgo) con clusterProfiler. | ✅ |
| `14_tcga_cox_ajustado_top10.Rmd` | Cox de los diez genes candidatos ajustado por edad, sexo y estadio AJCC (413 pacientes con estadio conocido). Salida: `results/cox_ajustado_top10.csv`. | ✅ |

> **Nota:** Los scripts 03 y 09 no existen — los números se saltaron durante el desarrollo. No afecta al flujo.

---

## Resultados generados

| Carpeta | Contenido |
|---------|-----------|
| `data_raw/` | `tcga_skcm_clinical.csv` — datos clínicos crudos descargados de GDC |
| `data_processed/` | Objetos `.rds` por etapa: survival, KM fits, Cox models, expression matrix, master dataset |
| `figures/` | Curvas KM (global, sexo, estadio), forest plot Cox multivariante, volcano plot del screening Cox y dotplots del ORA GO-BP |
| `results/` | `cox_transcriptome_results.csv` (genes rankeados por p-valor/FDR), `cox_transcriptome_results_annotated.csv` (con símbolo y Entrez) y `ora_go_protectores.csv` / `ora_go_riesgo.csv` (ORA GO-BP) |
| `deprecated/` | Scripts obsoletos o superados por versiones corregidas |

---

## Pendiente

- Compilar HTML de `12_tcga_kaplan_genes.Rmd`
- Exportar figuras finales de KM y Cox para la memoria LaTeX
- Seleccionar genes candidatos finales de `cox_transcriptome_results.csv` para el capítulo de resultados
