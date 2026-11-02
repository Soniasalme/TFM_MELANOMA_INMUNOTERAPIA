GSE91061 - tumor, RNA-seq, nivolumab (anti-PD-1)

Cohorte de validacion tumoral RNA-seq independiente.

Contenido de la carpeta:

1. exploracion_inicial_GSE91061.Rmd/html
   Caracterizacion del dataset. Conclusiones:
   - GEO devuelve un unico ExpressionSet; la expresion util no se toma de el,
     sino de los archivos suplementarios.
   - La matriz elegida es rld.csv.gz.
   - El analisis predictivo debe restringirse a las muestras pretratamiento.

2. plantilla_SummarizedExperiment_GSE91061_geneSymbol.Rmd/html
   Construye el objeto SummarizedExperiment estandarizado, con los genes
   identificados por simbolo.

Decisiones aplicadas:

- Identificador de muestra: title.
- Respuesta clinica: response:ch1.
- Pretratamiento: visit (pre or on treatment):ch1; se conservan solo las
  muestras pretratamiento.
- La matriz rld.csv.gz debe descargarse de GEO y guardarse en
  GEO_raw/GSE91061/.
- Los identificadores Entrez de la matriz se convierten a simbolo genico con
  org.Hs.eg.db. Los simbolos duplicados se colapsan por la media de expresion
  y rowData conserva en n_collapsed_ids cuantos identificadores originales
  contribuyen a cada simbolo. Esto permite cruzar la cohorte con las demas,
  que ya usan simbolos.

Objeto generado localmente:

- SummarizedExperiment_objects/se_gse91061.rds (22069 genes x 51 muestras)
  colData: sample_id, patient_id, response_raw, response_binary, is_baseline,
  dataset, tissue, platform.

Nota: en la fase exploratoria inicial esta cohorte se trato como sangre; en el
analisis final se reclasifica como tumor RNA-seq (ver
scripts/analysis/03_blood_sensitivity.Rmd).

El objeto RDS no se sube a GitHub porque los objetos SummarizedExperiment estan
ignorados por .gitignore y son regenerables desde este Rmd.
