# scripts/integration — Fase exploratoria inicial (no forma parte del análisis final)

> **Nota metodológica importante:** Los scripts de esta carpeta corresponden a la fase
> exploratoria inicial del proyecto, en la que se exploró un análisis conjunto de todas
> las cohortes GEO mediante un dataset integrado con corrección de batch.
> **Este enfoque fue descartado** y sustituido por la arquitectura final
> discovery · validación · sensibilidad, con análisis independientes por cohorte.
> Se conservan únicamente por trazabilidad metodológica.

## Por qué no usar estos scripts como referencia

| Punto | Scripts de esta carpeta | Análisis final |
|---|---|---|
| Diseño | Dataset GEO integrado (multi-cohorte) | Cohortes independientes |
| GSE91061 | Clasificado como cohorte de sangre | Reclasificado como tumor RNA-seq |
| Batch correction | limma removeBatchEffect sobre dataset conjunto | No aplicable (análisis por separado) |
| Scripts activos | ❌ No | ✅ En `scripts/analysis/` |

## Contenido de la carpeta

| Script | Descripción |
|---|---|
| `integracion_inicial_GEO_SummarizedExperiment.Rmd` | Construcción del objeto SE integrado inicial |
| `reconstruccion_GEO_tumor_blood_SummarizedExperiment_v4.Rmd` | Reconstrucción v4 del SE tumor+sangre |
| `pca_prebatch_GEO_tumor_v3.Rmd` | PCA pre-corrección de batch |
| `batch_correction_pca_postbatch_GEO_tumor.Rmd` | Corrección de batch + PCA post |
| `DEA_limma_GEO_tumor_response.Rmd` | DEA sobre el dataset integrado (descartado) |
| `exploracion_se_integrated_geo_por_bloques.Rmd` | Exploración del SE integrado |
| `exploracion_se_integrated_initial_geo_corregido.Rmd` | Exploración con correcciones |
| `PLANTILLA_informe_central.Rmd` | Plantilla genérica de R Markdown usada durante la fase exploratoria (sin análisis real) |
| `deprecated/` | Versiones anteriores de los scripts de integración |

## Pipeline final

El análisis final se encuentra en:

```
scripts/analysis/
  01_GSE78220_discovery.Rmd
  02_tumor_validation.Rmd
  03_blood_sensitivity.Rmd
  04_consistency_integrated.Rmd
  05_summary_table.Rmd
```
