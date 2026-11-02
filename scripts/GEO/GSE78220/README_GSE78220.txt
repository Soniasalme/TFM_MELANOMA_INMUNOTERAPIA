GSE78220 - tumor, RNA-seq, anti-PD-1 (pembrolizumab)

Cohorte de descubrimiento del bloque predictivo.

Contenido de la carpeta:

1. exploracion_inicial_GSE78220.Rmd/html
   Caracterizacion del dataset. Conclusiones:
   - GEO devuelve un unico ExpressionSet que no trae matriz de expresion
     utilizable.
   - La matriz de expresion esta en el archivo suplementario
     GSE78220_PatientFPKM.xlsx.
   - La cohorte contiene muestras pre-treatment y on-treatment.

2. plantilla_SummarizedExperiment_GSE78220_automatizada.Rmd/html
   Construye el objeto SummarizedExperiment estandarizado.

Decisiones aplicadas:

- Identificador de muestra y de paciente: patient id:ch1.
- Respuesta clinica: anti-pd-1 response:ch1.
- Se conservan solo las muestras baseline (pretratamiento).
- La matriz de expresion (FPKM) se lee del Excel suplementario, que debe
  descargarse de GEO y guardarse en GEO_raw/GSE78220/.

Objeto generado localmente:

- SummarizedExperiment_objects/se_gse78220.rds (25268 genes x 25 muestras)

El objeto RDS no se sube a GitHub porque los objetos SummarizedExperiment estan
ignorados por .gitignore y son regenerables desde este Rmd.
