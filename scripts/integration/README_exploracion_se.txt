README - exploracion del objeto integrado inicial

Documenta exploracion_se_integrated_initial_geo_corregido.Rmd, que describe el
objeto se_integrated_initial_geo.rds generado por
integracion_inicial_GEO_SummarizedExperiment.Rmd (ver README_integracion.txt).
Pertenece a la fase exploratoria inicial y se conserva por trazabilidad.

Contenido del informe HTML

- Carga del objeto integrado y dimensiones.
- Assays disponibles (expr).
- Vista de la matriz de expresion.
- Informacion de genes (rowData) e informacion clinica (colData).
- Resumen por cohorte GEO, tejido (tissue), respuesta (response_binary y
  response_raw) y plataforma.
- Listado de variables clinicas no vacias en colData.
- Metadatos del objeto (metadata) y checklist final.

El script usa las columnas reales del objeto integrado: tissue y
response_binary.

Descripcion del objeto

- 198 genes x 221 muestras; assay "expr"; rowData con gene_symbol.
- Muestras por cohorte: GSE78220 25, GSE91061 51, GSE215868 105,
  GSE211645 40.
- Mezcla tejido tumoral y sangre, y plataformas RNA-seq y NanoString, por lo
  que se esperaba un efecto batch importante.
- Variable de respuesta: response_binary (Responder / No_responder), derivada
  de response_raw.

Este objeto fue sustituido por los objetos separados por bloque (tumor y
sangre) y, finalmente, por el analisis independiente por cohorte. Ver
exploracion_se_integrated_geo_por_bloques.Rmd y scripts/analysis/.
