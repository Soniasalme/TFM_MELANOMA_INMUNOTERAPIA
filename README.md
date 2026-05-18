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
- Nueva reestructuracion descubrimiento/validacion implementada en `scripts/analysis/`.

## Ultima revision metodologica

Tras la ultima recomendacion de la tutora, el enfoque se esta refinando hacia un esquema de descubrimiento y validacion:

- Analisis principal: `GSE78220`, tumor, RNA-seq, anti-PD-1.
- Validacion 1: `GSE215868`, tumor, NanoString, anti-PD-1.
- Validacion 2: `GSE211645`, tumor, NanoString, anti-CTLA-4.
- Validación tumoral RNA-seq independiente: `GSE91061`.
- Sensibilidad en sangre: `GSE94873`.
- Integracion multi-cohorte: analisis exploratorio/de consistencia limitado a genes comunes.

La nota completa esta en:

`REVISION_TUTORA_2026-05-05.md`

Implementacion actual:

1. `scripts/analysis/01_GSE78220_discovery.html`
2. `scripts/analysis/02_tumor_validation.html`
3. `scripts/analysis/03_blood_sensitivity.html`
4. `scripts/analysis/04_consistency_integrated.html`
5. `scripts/analysis/05_summary_table.html`

## Cohortes incluidas en el trabajo actual

### Tumor

- `GSE78220`: tumor, RNA-seq, anti-PD-1.
- `GSE215868`: tumor, NanoString, anti-PD-1.
- `GSE211645`: tumor, NanoString, anti-CTLA-4.
- `GSE91061`: tumor, RNA-seq, nivolumab anti-PD-1.

### Sangre

- `GSE94873`: sangre, NanoString, tremelimumab anti-CTLA-4.

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

### Reestructuracion descubrimiento/validacion

1. `scripts/analysis/01_GSE78220_discovery.html`
2. `scripts/analysis/02_tumor_validation.html`
3. `scripts/analysis/03_blood_sensitivity.html`
4. `scripts/analysis/04_consistency_integrated.html`
5. `scripts/analysis/05_summary_table.html`

### Integracion multi-cohorte previa

1. `scripts/integration/reconstruccion_GEO_tumor_blood_SummarizedExperiment_v4.html`
2. `scripts/integration/exploracion_se_integrated_geo_por_bloques.html`
3. `scripts/integration/pca_prebatch_GEO_tumor_v3.html`
4. `scripts/integration/batch_correction_pca_postbatch_GEO_tumor.html`
5. `scripts/integration/DEA_limma_GEO_tumor_response.html`

Los `.Rmd` correspondientes estan en la misma carpeta.

## Datos y reproducibilidad

Los datos crudos de GEO y TCGA/GDC no se incluyen en GitHub porque son descargables, ocupan mucho espacio y son regenerables desde los R Markdown. Tampoco se versionan por defecto las matrices procesadas muy pesadas ni los objetos intermedios por cohorte, salvo algunos objetos clave seleccionados para facilitar la revision.

Se incluyen algunos objetos clave para facilitar la revision:

- `integrated_dataset/se_integrated_geo_tumor.rds`
- `integrated_dataset/se_integrated_geo_blood_sensitivity.rds`
- `integrated_dataset/se_integrated_initial_geo.rds`
- `resultados/batch_correction_geo_tumor/se_integrated_geo_tumor_batch_corrected_limma.rds`

## Resultados actuales

El DEA integrado tumoral previo no identifica genes significativos tras correccion FDR, lo que es coherente con:

- tamano muestral limitado,
- heterogeneidad entre cohortes,
- mezcla de plataformas,
- restriccion a genes comunes con paneles NanoString.

Por este motivo, el siguiente paso metodologico sera separar descubrimiento y validacion por cohorte/plataforma/tratamiento.

Esa separacion ya queda iniciada en `scripts/analysis/`:

- `GSE78220`: descubrimiento principal RNA-seq anti-PD-1.
- `GSE215868`: validacion NanoString anti-PD-1.
- `GSE211645`: generalizacion a anti-CTLA-4.
- `GSE91061`: validación tumoral RNA-seq independiente.
- `GSE94873`: sensibilidad en sangre NanoString anti-CTLA-4.
- `Dataset integrado tumoral`: consistencia exploratoria en 200 genes comunes.

Los analisis de `scripts/analysis/` verifican la escala de entrada antes de aplicar `limma`. Solo `GSE78220` se transforma con `log2(FPKM + 1)` porque la matriz esta en escala FPKM lineal. Las cohortes NanoString y la matriz RLD de `GSE91061` ya llegan normalizadas y no se vuelven a transformar. En `GSE78220` no aparecen genes significativos tras FDR, aunque si candidatos nominales para exploracion y validacion.

El informe `04_consistency_integrated.html` usa el objeto integrado tumoral como analisis de apoyo: compara la direccion del logFC en los 200 genes comunes entre `GSE78220`, `GSE215868` y `GSE211645`. Este bloque no se interpreta como descubrimiento principal, sino como comprobacion de consistencia limitada por los paneles NanoString.

El informe `05_summary_table.html` resume los resultados principales de los bloques 01-04 en tablas compactas para revision semanal y para trasladar a la memoria, incluyendo ya `GSE94873` como sensibilidad adicional en sangre.
