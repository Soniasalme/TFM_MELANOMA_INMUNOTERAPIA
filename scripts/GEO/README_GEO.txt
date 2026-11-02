README - scripts/GEO

Esta carpeta contiene la preparacion de las cinco cohortes GEO del bloque
predictivo. Cada cohorte tiene su propia subcarpeta con el mismo flujo de dos
pasos, que termina en un objeto SummarizedExperiment por cohorte.

Flujo por cohorte

1. exploracion_inicial_GSEXXXXX.Rmd
   Descarga los metadatos desde GEO (getGEO), revisa dimensiones y estructura,
   localiza la matriz de expresion y busca las columnas utiles: identificador
   de muestra, respuesta clinica, tratamiento y variable de pretratamiento
   (baseline). Sus conclusiones fijan las decisiones del paso siguiente.

2. plantilla_SummarizedExperiment_GSEXXXXX*.Rmd
   Aplica esas decisiones: construye los metadatos limpios (sample_id,
   patient_id, respuesta, dataset, tissue, platform), alinea expresion y
   metadatos, crea el SummarizedExperiment y lo guarda como se_gseXXXXX.rds
   en SummarizedExperiment_objects/.

Cada .Rmd tiene su informe HTML compilado en la misma carpeta.

Cohortes

Cohorte     Tejido   Plataforma  Tratamiento        Objeto SE (genes x muestras)
GSE78220    Tumor    RNA-seq     anti-PD-1          25268 x 25 (solo baseline)
GSE91061    Tumor    RNA-seq     nivolumab          22069 x 51 (solo pretratamiento)
GSE215868   Tumor    NanoString  anti-PD-1          770 x 105
GSE211645   Tumor    NanoString  anti-CTLA-4        418 x 40
GSE94873    Sangre   NanoString  tremelimumab       ver README_GSE94873.txt

Los detalles de cada cohorte (columnas usadas, origen de la matriz de
expresion y decisiones) estan en el README_GSEXXXXX.txt de su subcarpeta. El
papel de cada cohorte en el analisis final (descubrimiento, validacion,
sensibilidad) se describe en scripts/analysis/README_analysis.txt.

Datos y objetos generados

Los datos descargados (GEO_raw/) y los objetos SummarizedExperiment
(SummarizedExperiment_objects/) estan excluidos del repositorio mediante
.gitignore. Se regeneran ejecutando los .Rmd de esta carpeta, o con
data/00_download_data.R para la descarga.
