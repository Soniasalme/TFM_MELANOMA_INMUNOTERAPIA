GSE215868 - tumor, NanoString, anti-PD-1

Cohorte de validacion tumoral del bloque predictivo.

Contenido de la carpeta:

1. exploracion_inicial_GSE215868.Rmd/html
   Descarga el dataset desde GEO, inspecciona dimensiones y metadatos, decide
   la columna de respuesta, comprueba si existe variable de baseline e
   identifica las variables clinicas utiles.

2. plantilla_SummarizedExperiment_GSE215868_automatizada.Rmd/html
   Aplica las decisiones de la exploracion: construye los metadatos limpios,
   alinea expresion y metadatos, crea el SummarizedExperiment y lo guarda como
   .rds.

Decisiones aplicadas:

- Identificador de muestra y de paciente: geo_accession.
- Respuesta clinica: bor:ch1 (mejor respuesta global).
- Tratamiento: itx:ch1.
- No hay variable explicita de baseline o on-treatment, por lo que se usan las
  105 muestras disponibles.
- La expresion se toma normalizada del propio ExpressionSet.

Objeto generado localmente:

- SummarizedExperiment_objects/se_gse215868.rds (770 genes x 105 muestras)

Ambos Rmd llaman a getGEO(); al reejecutar el flujo se sobrescriben solo los
archivos derivados (GEO_raw/GSE215868/GSE215868_metadata_raw.tsv y el .rds),
con el mismo resultado. Orden de ejecucion: primero la exploracion y despues la
plantilla.

El objeto RDS no se sube a GitHub porque los objetos SummarizedExperiment estan
ignorados por .gitignore y son regenerables desde este Rmd.
