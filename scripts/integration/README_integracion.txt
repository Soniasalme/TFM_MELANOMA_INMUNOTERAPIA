README - integracion inicial de las cohortes GEO

Documenta integracion_inicial_GEO_SummarizedExperiment.Rmd, el primer script de
integracion multi-cohorte. Pertenece a la fase exploratoria inicial (ver
README.md de esta carpeta): el enfoque se descarto en favor de analisis
independientes por cohorte y se conserva por trazabilidad.

Que hace el script

1. Carga los cuatro SummarizedExperiment de GSE78220, GSE91061, GSE215868 y
   GSE211645.
2. Identifica el tipo de identificador genico de cada cohorte.
3. Calcula el solapamiento genico por pares y la interseccion global.
4. Si la interseccion global no esta vacia, construye el objeto integrado
   (se_integrated_initial_geo.rds); si esta vacia, detiene la integracion en
   lugar de forzarla.

Resultado en dos ejecuciones

Primera ejecucion: GSE91061 usaba identificadores Entrez (gene_id) mientras que
las otras tres cohortes usaban simbolos genicos (gene_symbol). El solapamiento
de GSE91061 con las demas era 0, la interseccion global tambien, y no se
genero el objeto integrado.

Segunda ejecucion: tras reconstruir GSE91061 con simbolos genicos (ver
scripts/GEO/GSE91061/README_GSE91061.txt), las cuatro cohortes comparten
identificador y la integracion es viable.

Solapamiento genico por pares (genes en comun):

  GSE78220  - GSE91061    20052
  GSE78220  - GSE215868     754
  GSE78220  - GSE211645     383
  GSE91061  - GSE215868     754
  GSE91061  - GSE211645     384
  GSE215868 - GSE211645     200

La interseccion global es de 198 genes, limitada por el panel NanoString mas
pequeno. El objeto integrado tiene 198 genes x 221 muestras
(assay "expr", rowData con gene_symbol y colData con 16 variables clinicas
combinadas).

Posterior revision metodologica

Este objeto mezcla tumor y sangre, por lo que las diferencias de tejido se
confunden con el efecto batch tecnico. Por ello la integracion se reorganizo en
bloques (tumoral y sangre) y, finalmente, se sustituyo por la arquitectura
discovery - validacion - sensibilidad. Ver
resultados/_archivo/geo_integrado_inicial/ y scripts/analysis/.
