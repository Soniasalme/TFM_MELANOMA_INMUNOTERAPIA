# TFM Melanoma e Inmunoterapia

Repositorio del Trabajo de Fin de Master de Sonia Salmeron sobre analisis transcriptomico en melanoma avanzado tratado con inmunoterapia.

El objetivo general es estudiar biomarcadores transcriptomicos asociados a respuesta a inmunoterapia, combinando exploracion de cohortes publicas GEO, construccion de objetos `SummarizedExperiment`, analisis de batch effect, analisis diferencial y modelos predictivos.

## Estado actual

El repositorio contiene:

- Exploracion inicial de cohortes GEO.
- Construccion de objetos `SummarizedExperiment` por cohorte.
- Integracion inicial multi-cohorte.
- Reconstruccion por bloques de tejido: tumor y sangre.
- PCA pre-batch del bloque tumoral.
- Correccion exploratoria de batch effect.
- DEA respondedor vs no respondedor en el bloque tumoral integrado.
- Informes HTML generados desde R Markdown.

## Ultima revision metodologica

Tras la ultima recomendacion de la tutora, el enfoque se esta refinando hacia un esquema de descubrimiento y validacion:

- Analisis principal: `GSE78220`, tumor, RNA-seq, anti-PD-1.
- Validacion 1: `GSE215868`, tumor, NanoString, anti-PD-1.
- Validacion 2: `GSE211645`, tumor, NanoString, anti-CTLA-4.
- Sensibilidad en sangre: `GSE91061` y posible valoracion de `GSE94873`.
- Integracion multi-cohorte: analisis exploratorio/de consistencia limitado a genes comunes.

La nota completa esta en:

`REVISION_TUTORA_2026-05-05.md`

## Cohortes incluidas en el trabajo actual

### Tumor

- `GSE78220`: tumor, RNA-seq, anti-PD-1.
- `GSE215868`: tumor, NanoString, anti-PD-1.
- `GSE211645`: tumor, NanoString, anti-CTLA-4.

### Sangre

- `GSE91061`: sangre/PBMC, RNA-seq, inmunoterapia.

`GSE94873` queda pendiente de valorar como sensibilidad en sangre.

## Estructura del repositorio

```text
2_TFM_MELANOMA/
  integrated_dataset/
  resultados/
  scripts/
    GEO/
    integration/
  figuras/
  TFM_memoria/
```

## Informes centrales

Los informes mas importantes para revisar el estado actual son:

1. `scripts/integration/reconstruccion_GEO_tumor_blood_SummarizedExperiment_v4.html`
2. `scripts/integration/exploracion_se_integrated_geo_por_bloques.html`
3. `scripts/integration/pca_prebatch_GEO_tumor_v3.html`
4. `scripts/integration/batch_correction_pca_postbatch_GEO_tumor.html`
5. `scripts/integration/DEA_limma_GEO_tumor_response.html`

Los `.Rmd` correspondientes estan en la misma carpeta.

## Datos y reproducibilidad

Los datos crudos de GEO no se incluyen en GitHub porque son descargables y ocupan mas espacio. Los objetos intermedios por cohorte tampoco se suben por defecto porque son regenerables desde los R Markdown.

Se incluyen algunos objetos clave para facilitar la revision:

- `integrated_dataset/se_integrated_geo_tumor.rds`
- `integrated_dataset/se_integrated_geo_blood_sensitivity.rds`
- `integrated_dataset/se_integrated_initial_geo.rds`
- `resultados/batch_correction_geo_tumor/se_integrated_geo_tumor_batch_corrected_limma.rds`

## Resultados actuales

El DEA integrado tumoral no identifica genes significativos tras correccion FDR, lo que es coherente con:

- tamano muestral limitado,
- heterogeneidad entre cohortes,
- mezcla de plataformas,
- restriccion a genes comunes con paneles NanoString.

Por este motivo, el siguiente paso metodologico sera separar descubrimiento y validacion por cohorte/plataforma/tratamiento.

