README - Objetos SummarizedExperiment integrados GEO

Objetos actuales

1. se_integrated_geo_tumor.rds

Objeto principal del TFM para los analisis de respuesta en tumor.

- Cohortes: GSE78220, GSE215868, GSE211645
- Tipo de muestra: Tumor
- Genes comunes: 200
- Muestras: 170
- Uso: PCA, batch effect, DEA, seleccion de biomarcadores y modelos predictivos.

2. se_integrated_geo_blood_sensitivity.rds

Objeto secundario para analisis de sensibilidad.

- Cohorte: GSE91061
- Tipo de muestra: Blood/PBMC
- Genes: 22069
- Muestras: 51
- Uso: comparacion exploratoria/sensibilidad, no mezclado directamente con tumor.

3. se_integrated_initial_geo.rds

Objeto global inicial con tumor + sangre.

- Cohortes: GSE78220, GSE91061, GSE215868, GSE211645
- Genes comunes: 198
- Muestras: 221
- Uso: antecedente metodologico y comparacion con la estrategia final.

Decision metodologica

El analisis principal se restringe a las tres cohortes tumorales para evitar confundir diferencias biologicas de tejido con batch effect tecnico. GSE91061 queda separado porque procede de sangre/PBMC.

GSE94873 no se incluye en esta version por tres motivos principales:

- Es sangre, no tumor.
- No tiene datos crudos.
- Usa un panel NanoString pequeno de 169 genes, lo que reduciria la interseccion genica.

Estructura del SummarizedExperiment

- assay(se, "expr"): matriz de expresion genes x muestras.
- rowData(se): informacion de genes/gene_symbol.
- colData(se): metadatos clinicos y tecnicos.
- metadata(se): bloque de analisis, cohortes incluidas, numero de genes y muestras.

Carga en R

library(SummarizedExperiment)

se_tumor <- readRDS("integrated_dataset/se_integrated_geo_tumor.rds")
se_blood <- readRDS("integrated_dataset/se_integrated_geo_blood_sensitivity.rds")

assay(se_tumor, "expr")
colData(se_tumor)
rowData(se_tumor)
