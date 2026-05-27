# Fase exploratoria inicial — Integración GEO multi-cohorte

Resultados de la fase exploratoria inicial de integración GEO multi-cohorte.
Se conservan por trazabilidad, pero no constituyen los resultados principales
de la memoria final.

## Contenido

| Carpeta | Descripción |
|---|---|
| `batch_correction_geo_tumor/` | Corrección de efecto batch entre cohortes tumorales GEO (limma) |
| `dea_geo_tumor_response/` | DEA sobre el dataset GEO integrado (análisis descartado) |
| `pca_prebatch/` | PCA pre-corrección de batch (control de calidad) |
| `integrated_dataset/` | Objetos SummarizedExperiment del dataset GEO integrado |

## Contexto

El diseño inicial contemplaba integrar todas las cohortes GEO en un único
objeto para un análisis conjunto. Tras la revisión metodológica, se adoptó
la arquitectura **discovery · validación · sensibilidad** con análisis
independientes por cohorte, que permite separar correctamente las fases
y evita la sobrestimación del rendimiento predictivo.

Los resultados finales se encuentran en las carpetas hermanas de `resultados/`.
