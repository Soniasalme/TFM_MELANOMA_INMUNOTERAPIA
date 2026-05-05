README - scripts/analysis

Esta carpeta contiene la reestructuracion metodologica propuesta tras la revision de Teresa.

Orden recomendado:

1. 01_GSE78220_discovery.Rmd
   Analisis principal de descubrimiento.
   Cohorte: GSE78220.
   Tipo: tumor, RNA-seq, anti-PD-1.
   Incluye DEA y modelo exploratorio LOOCV.

2. 02_tumor_validation.Rmd
   Validacion tumoral de genes/firma derivados de GSE78220.
   Cohortes: GSE215868 y GSE211645.
   GSE215868 evalua reproducibilidad en NanoString anti-PD-1.
   GSE211645 evalua generalizacion a anti-CTLA-4.

3. 03_blood_sensitivity.Rmd
   Sensibilidad en sangre.
   Cohorte disponible: GSE91061.
   GSE94873 queda documentada como pendiente.

4. 04_consistency_integrated.Rmd
   Analisis de consistencia exploratoria con el dataset integrado tumoral.
   Usa los 200 genes comunes entre GSE78220, GSE215868 y GSE211645.
   Compara la direccion del logFC por cohorte y genera una tabla cruzada.

La integracion multi-cohorte previa se conserva como analisis exploratorio/de consistencia, pero no como base principal de descubrimiento.
