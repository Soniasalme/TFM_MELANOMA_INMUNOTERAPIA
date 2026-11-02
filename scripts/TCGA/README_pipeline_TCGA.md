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
| `12_tcga_kaplan_genes.Rmd` | Curvas Kaplan-Meier (alta/baja expresión según la mediana) para el top 10 literal del ranking por FDR, sin filtrar por tipo de transcrito: incluye TAF5LP1 (pseudogén) y ENSG00000259834 (sin símbolo) y no incluye APOBEC3G ni UBA7. | ✅ |
| `13_tcga_anotacion_ora.Rmd` | Anotación Ensembl → símbolo/Entrez, volcano plot del screening Cox y ORA GO-BP (genes protectores y de riesgo) con clusterProfiler. | ✅ |
| `14_tcga_cox_ajustado_top10.Rmd` | Cox ajustado por edad, sexo y estadio AJCC (413 pacientes con estadio conocido) de los diez genes de la tabla de la memoria (genes con símbolo, no pseudogenes y protectores entre los 15 de menor FDR; no es el top 10 literal). Salida: `results/cox_ajustado_top10.csv`. | ✅ |

> **Nota:** Los scripts 03 y 09 no existen — los números se saltaron durante el desarrollo. No afecta al flujo.

---

## Resultados generados

| Carpeta | Contenido |
|---------|-----------|
| `data_raw/` | Datos crudos descargados de GDC (no versionados; se regeneran con el script 01) |
| `data_processed/` | Objetos intermedios por etapa (survival, ajustes KM, matriz de expresión, master dataset). Los `.rds` y la matriz de expresión no se versionan (véase `.gitignore`) y se regeneran ejecutando los scripts en orden; en el repositorio se incluyen solo los CSV clínicos |
| `figures/` | Curvas KM (global, sexo, estadio), forest plot Cox multivariante, volcano plot del screening Cox y dotplots del ORA GO-BP. Las curvas KM de los genes candidatos (script 12) se muestran en su informe HTML y no se exportan como ficheros |
| `results/` | `cox_transcriptome_results.csv` (5.000 genes con HR, p-valor y FDR), `cox_transcriptome_results_annotated.csv` (con símbolo y Entrez), `ora_go_protectores.csv` / `ora_go_riesgo.csv` (ORA GO-BP), `cox_ajustado_top10.csv` (Cox ajustado de los diez genes de la tabla de la memoria) y las tablas de los modelos clínicos univariante y multivariante |
| `deprecated/` | Scripts obsoletos o superados por versiones corregidas |

---

## Selección de genes: tres listas distintas

Tres pasos del pipeline trabajan con "los genes de menor FDR", pero no usan exactamente la misma lista:

| Uso | Lista | Criterio |
|-----|-------|----------|
| Kaplan-Meier (script 12) | Top 10 literal del ranking por FDR | Sin filtros: incluye TAF5LP1 (pseudogén) y ENSG00000259834 (sin símbolo); no incluye APOBEC3G ni UBA7 |
| Etiquetas del volcano (script 13) | 15 de menor FDR entre los genes con símbolo | Excluye los transcritos sin símbolo; incluye TAF5LP1 |
| Cox ajustado (script 14) y tabla de la memoria | 10 genes con símbolo, no pseudogenes y protectores entre los 15 de menor FDR | Excluye TAF5LP1, tres transcritos sin símbolo y NCCRP1 (único gen de riesgo) |

Los genes de menor FDR están empatados en bloques (por ejemplo, cinco genes comparten el FDR de las posiciones 11-15), de modo que la posición exacta dentro de un empate no es informativa.

## Ficheros de procedencia

- `clinical.project-tcga-skcm.2026-03-06.tar.gz`: descarga clínica del proyecto desde el portal GDC (6 de marzo de 2026).
- `project  melanoma.png`: captura de la página del proyecto TCGA-SKCM en el GDC (470 casos), que documenta el tamaño inicial de la cohorte.
