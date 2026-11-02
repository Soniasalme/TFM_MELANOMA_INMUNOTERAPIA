README - scripts/

Esta carpeta contiene todo el codigo (R Markdown y scripts auxiliares) del TFM.
Los analisis se organizan en dos bloques independientes (predictivo GEO y
pronostico TCGA-SKCM) mas una carpeta de construccion de objetos por cohorte y
una carpeta historica de integracion.

Estructura

scripts/
|-- GEO/           Preparacion de cada cohorte GEO
|-- analysis/      Analisis final del bloque predictivo GEO (scripts 01-05)
|-- TCGA/          Analisis del bloque pronostico TCGA-SKCM (scripts 01-12)
|-- integration/   Fase exploratoria inicial de integracion (referencia historica)

Contenido de cada carpeta

GEO/
  Una subcarpeta por cohorte: GSE78220, GSE91061, GSE215868, GSE211645 y
  GSE94873. En cada una:
    - exploracion_inicial_GSEXXXXX.Rmd: exploracion del dataset (variables
      clinicas, matriz de expresion, identificadores de muestra).
    - plantilla_SummarizedExperiment_GSEXXXXX*.Rmd: construccion del objeto
      SummarizedExperiment de la cohorte.
    - README_GSEXXXXX.txt: notas de la cohorte.
  Los informes HTML compilados se guardan junto a cada .Rmd.

analysis/
  Analisis final del bloque predictivo (arquitectura discovery - validacion -
  sensibilidad). Orden de ejecucion:
    01_GSE78220_discovery.Rmd        Descubrimiento (RNA-seq, anti-PD-1): DEA y LOOCV.
    02_tumor_validation.Rmd          Validacion tumoral en GSE215868 y GSE211645.
    03_blood_sensitivity.Rmd         Validacion RNA-seq (GSE91061) y sensibilidad
                                     periferica en sangre (GSE94873).
    04_consistency_integrated.Rmd    Consistencia multi-cohorte (genes comunes).
    05_summary_table.Rmd             Tabla resumen global.
  Las tablas CSV de salida se guardan en resultados/. Detalle en
  analysis/README_analysis.txt.

TCGA/
  Bloque pronostico sobre TCGA-SKCM: descarga y preparacion de datos clinicos,
  curvas Kaplan-Meier, modelos de Cox univariante y multivariante, y screening
  de Cox gen a gen sobre expresion (log-CPM). Subcarpetas: data_processed/,
  figures/, results/ y deprecated/ (versiones superadas). Orden de ejecucion y
  descripcion de cada script en TCGA/README_pipeline_TCGA.md. Incluye ademas
  tres scripts auxiliares para las figuras de la presentacion
  (check_ppt_shapes.py, replace_ppt_figures.py, fix_figures_labels.R).

integration/
  Scripts de la fase exploratoria inicial, en la que se probo un dataset GEO
  integrado con correccion de batch. Este enfoque se descarto y se conserva solo
  por trazabilidad metodologica; no forma parte del analisis final. Ver
  integration/README.md.

Flujo de trabajo

  GEO/ (exploracion + objeto SummarizedExperiment por cohorte)
        |
        v
  analysis/ (01 descubrimiento -> 02-03 validacion y sensibilidad ->
             04 consistencia -> 05 resumen)  ->  resultados/

  TCGA/ (01-12, independiente del bloque GEO)  ->  resultados y figuras

Los datos se descargan desde repositorios publicos con data/00_download_data.R
(GEOquery y TCGAbiolinks) y el entorno R se verifica con environment.R, ambos
en la raiz del repositorio. Vease el README.md principal para el resumen del
proyecto y los resultados.
