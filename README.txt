README breve - TFM melanoma inmunoterapia

Carpetas principales

scripts: scripts y Rmd del analisis
GEO_raw: datos descargados de GEO sin procesar
SummarizedExperiment_objects: objetos limpios por cohorte
integrated_dataset: objetos integrados finales
resultados: tablas y objetos derivados
figuras: graficas
TFM_memoria: documentos de la memoria

Diseno actual

El TFM mantiene un enfoque mixto:

- TCGA-SKCM: analisis pronostico.
- GEO: prediccion de respuesta a inmunoterapia.

Dentro de GEO, el analisis principal es tumoral:

- GSE78220
- GSE215868
- GSE211645

GSE91061 queda separado como sangre/sensibilidad.

Objeto principal para seguir trabajando

integrated_dataset/se_integrated_geo_tumor.rds

Objeto secundario

integrated_dataset/se_integrated_geo_blood_sensitivity.rds

Siguiente secuencia

1. Confirmar reconstruccion por bloques.
2. Explorar metadatos y balance de respuesta.
3. PCA pre-batch.
4. Correccion batch + PCA post-batch.
5. DEA respondedores vs no respondedores.
6. Modelos predictivos y analisis de robustez.

Justificacion corta de GSE94873

GSE94873 se reviso pero no se incluye en el analisis principal porque es sangre, no tiene datos crudos y usa un panel NanoString reducido de 169 genes. Puede mencionarse como cohorte evaluada, pero no integrada en la fase principal.
