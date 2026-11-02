GSE211645 - tumor, NanoString, anti-CTLA-4 (ipilimumab)

Cohorte de validacion exploratoria (tamano pequeno).

Contenido de la carpeta:

1. exploracion_inicial_GSE211645.Rmd/html
   Descarga el dataset desde GEO, comprueba el tipo de objeto, las dimensiones
   de expresion, metadatos y anotacion, y busca de forma sistematica columnas
   candidatas de respuesta, tratamiento, identificador, baseline y
   supervivencia. Conclusiones:
   - GEO devuelve un unico ExpressionSet que ya contiene la matriz de
     expresion (418 genes x 40 muestras); no hacen falta archivos
     suplementarios.
   - geo_accession es el unico identificador que coincide con las columnas de
     la matriz (40/40); title no coincide (0/40).
   - No se identifica ninguna variable explicita de pretratamiento.

2. plantilla_SummarizedExperiment_GSE211645.Rmd/html
   Construye el objeto SummarizedExperiment estandarizado.

Decisiones aplicadas:

- Identificador de muestra y de paciente: geo_accession.
- Respuesta clinica: response to therapy:ch1.
- Tratamiento: treatment_protocol_ch1.
- Sin filtro de baseline (no hay variable de pretratamiento); se usan las 40
  muestras.
- Sin variables de supervivencia (OS/PFS) en los metadatos.

Objeto generado localmente:

- SummarizedExperiment_objects/se_gse211645.rds (418 genes x 40 muestras)
  colData: sample_id, patient_id, response_raw, response_binary, treatment,
  dataset, tissue, platform.

El objeto RDS no se sube a GitHub porque los objetos SummarizedExperiment estan
ignorados por .gitignore y son regenerables desde este Rmd.
