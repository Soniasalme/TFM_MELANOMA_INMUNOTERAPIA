README - Dataset GEO integrado por bloques
Melanoma avanzado tratado con inmunoterapia

1. Descripcion general

Tras las correcciones metodologicas, la integracion GEO queda organizada en dos objetos:

- Analisis principal tumoral:
  integrated_dataset/se_integrated_geo_tumor.rds
- Analisis secundario de sensibilidad en sangre:
  integrated_dataset/se_integrated_geo_blood_sensitivity.rds

El objeto global inicial se conserva solo como antecedente/documentacion:

- integrated_dataset/se_integrated_initial_geo.rds

La razon de separar los bloques es biologica: mezclar tumor y sangre introduce una fuente de variacion que no debe tratarse como un simple batch effect tecnico.

2. Cohortes incluidas

Bloque principal tumoral:

- GSE78220 - Tumor - anti-PD-1 - RNA-seq
- GSE215868 - Tumor - anti-PD-1 - NanoString
- GSE211645 - Tumor - anti-CTLA-4 - NanoString

Bloque secundario/sensibilidad:

- GSE91061 - Sangre/PBMC - ICIs - RNA-seq

GSE94873 se evaluo, pero no se incorporo en la integracion principal porque es una cohorte de sangre, no dispone de datos crudos y contiene un panel NanoString reducido de 169 genes. Incluirla reduciria la interseccion genica y anadiria variabilidad biologica adicional.

3. Integracion genica

La integracion se realiza por interseccion de gene symbols comunes entre las cohortes de cada bloque.

Valores verificados en los objetos actuales:

- Integracion global inicial tumor + sangre: 198 genes, 221 muestras
- Bloque tumoral principal: 200 genes, 170 muestras
- Bloque sangre/sensibilidad: 22069 genes, 51 muestras

Esta comparacion justifica usar el bloque tumoral como analisis principal y conservar sangre para sensibilidad.

4. Metadatos clave

Los objetos incluyen, cuando esta disponible:

- dataset
- platform
- tissue
- response_raw
- response_binary
- variables de supervivencia/tratamiento segun cohorte

Checks importantes:

- GSE91061 debe aparecer como Blood en el objeto de sangre.
- GSE91061 no debe formar parte del objeto tumoral principal.
- colnames(assay) y rownames(colData) deben estar alineados.
- Los genes integrados no deben estar duplicados.

5. Scripts principales

- scripts/integration/reconstruccion_GEO_tumor_blood_SummarizedExperiment_v4.Rmd
- scripts/integration/exploracion_se_integrated_geo_por_bloques.Rmd
- scripts/integration/pca_prebatch_GEO_tumor_v3.Rmd
- scripts/integration/batch_correction_pca_postbatch_GEO_tumor.Rmd
- scripts/integration/DEA_limma_GEO_tumor_response.Rmd

6. Uso recomendado

Para PCA, correccion de batch, DEA y modelos predictivos, usar como base:

integrated_dataset/se_integrated_geo_tumor.rds

Para comparacion exploratoria o sensibilidad biologica, usar:

integrated_dataset/se_integrated_geo_blood_sensitivity.rds
