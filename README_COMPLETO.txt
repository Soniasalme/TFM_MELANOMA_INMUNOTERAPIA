README - Proyecto TFM Melanoma e Inmunoterapia

Descripcion del proyecto

Este proyecto integra cohortes transcriptomicas publicas de melanoma avanzado tratado con inmunoterapia para estudiar biomarcadores de respuesta. El enfoque final es mixto en el sentido del TFM global:

- TCGA-SKCM para el bloque pronostico.
- GEO para el bloque predictivo de respuesta a inmunoterapia.

Dentro de GEO, el analisis principal se centra en tumor. Las cohortes de sangre se reservan para sensibilidad/validacion exploratoria.

Estructura del proyecto

TFM/
  GEO_raw/
  SummarizedExperiment_objects/
  integrated_dataset/
  scripts/
    GEO/
    integration/
  resultados/
  figuras/
  TFM_memoria/

Seleccion de cohortes GEO

Bloque principal tumoral:

- GSE78220: tumor, anti-PD-1, RNA-seq
- GSE215868: tumor, anti-PD-1, NanoString
- GSE211645: tumor, anti-CTLA-4, NanoString

Bloque secundario de sangre/sensibilidad:

- GSE91061: sangre/PBMC, varios ICIs, RNA-seq

GSE94873

GSE94873 se evaluo, pero no se incorpora en la integracion principal por ahora porque:

- Es sangre, no tumor.
- No dispone de datos crudos.
- Usa un panel NanoString reducido de 169 genes.
- Reduciria la interseccion genica si se mezclara con las cohortes tumorales.
- Introduciria variacion biologica adicional por tipo de muestra.

Frase para memoria:

GSE94873 fue revisada como cohorte potencial de sensibilidad, pero no se incluyo en el analisis principal al proceder de sangre periferica, carecer de datos crudos y utilizar un panel NanoString reducido, lo que habria limitado la interseccion genica y dificultado la comparabilidad con el bloque tumoral.

Objetos integrados finales

- integrated_dataset/se_integrated_geo_tumor.rds
  Analisis principal. 3 cohortes tumorales, 200 genes comunes, 170 muestras.

- integrated_dataset/se_integrated_geo_blood_sensitivity.rds
  Analisis secundario. GSE91061, 22069 genes, 51 muestras.

- integrated_dataset/se_integrated_initial_geo.rds
  Objeto global inicial tumor + sangre, conservado como antecedente. 198 genes comunes, 221 muestras.

Scripts principales

- scripts/integration/reconstruccion_GEO_tumor_blood_SummarizedExperiment_v4.Rmd
  Reconstruye la integracion separando tumor y sangre. Corrige tissue para GSE91061 como Blood.

- scripts/integration/exploracion_se_integrated_geo_por_bloques.Rmd
  Explora los objetos separados y comprueba dataset, tissue, platform y response_binary.

- scripts/integration/pca_prebatch_GEO_tumor_v3.Rmd
  PCA pre-batch del bloque tumoral, coloreado por dataset, plataforma y respuesta.

- scripts/integration/batch_correction_pca_postbatch_GEO_tumor.Rmd
  Correccion exploratoria con limma::removeBatchEffect. La variable response_binary se protege en el diseno; las muestras con respuesta desconocida se codifican como Unknown_response.

- scripts/integration/DEA_limma_GEO_tumor_response.Rmd
  DEA respondedores vs no respondedores en tumor. Ejecuta analisis principal con matriz corregida y robustez con matriz sin corregir ajustando por dataset.

Secuencia recomendada

1. Reconstruccion por bloques tumor/sangre.
2. Exploracion y checks de metadatos.
3. PCA pre-batch del bloque tumoral.
4. Correccion batch con limma y PCA post-batch.
5. DEA respondedores vs no respondedores.
6. Modelos predictivos usando datos sin corregir con ajuste por cohorte/plataforma, y comparacion de robustez con datos corregidos.
7. TCGA-SKCM en paralelo para pronostico.

Notas metodologicas clave

- No mezclar tumor y sangre en el objeto principal.
- Documentar genes comunes con y sin GSE91061: 198 en global inicial vs 200 en tumor.
- Revisar siempre el balance de response_binary por cohorte antes de DEA/modelos.
- Para DEA se puede usar matriz corregida por batch, protegiendo la respuesta.
- Para modelos predictivos, priorizar datos sin corregir con cohorte/plataforma como covariable; comparar con estrategia corregida como sensibilidad.
