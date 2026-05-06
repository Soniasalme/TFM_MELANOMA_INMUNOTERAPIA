GSE94873 - sangre, NanoString, tremelimumab anti-CTLA-4

Contenido de la carpeta:

1. exploracion_inicial_GSE94873.Rmd/html
   Explora el objeto GEO, la matriz de expresion, metadatos, columnas de respuesta,
   identificador de muestra y filtrado de pretratamiento.

2. plantilla_SummarizedExperiment_GSE94873_automatizada.Rmd/html
   Construye el objeto SummarizedExperiment estandarizado.

Decisiones aplicadas:

- Se usan solo muestras pretratamiento: source_name_ch1 == "Whole Blood, Pretreatment".
- La respuesta se toma de:
  immunotherapy response (responder=1 nonresponder=0):ch1
- 1 se recodifica como Responder y 0 como No_responder.
- El simbolo genico se toma de la columna ORF del fData.
- La cohorte se interpreta como sensibilidad en sangre, no como validacion directa
  del analisis principal anti-PD-1 tumoral.

Objeto generado localmente:

- SummarizedExperiment_objects/se_gse94873.rds

El objeto RDS no se sube a GitHub porque los objetos SummarizedExperiment estan
ignorados por .gitignore y son regenerables desde este Rmd.
