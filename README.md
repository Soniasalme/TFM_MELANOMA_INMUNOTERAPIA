\# TFM: Melanoma – Análisis transcriptómico y predicción de respuesta a inmunoterapia



\## Descripción



Este proyecto corresponde al Trabajo de Fin de Máster (TFM) centrado en el estudio del melanoma avanzado mediante análisis transcriptómico.



El objetivo principal es:



\- Identificar biomarcadores transcriptómicos asociados a:

&#x20; - respuesta a inmunoterapia (anti-PD-1 / anti-CTLA-4)

&#x20; - características biológicas del tumor

\- Evaluar la capacidad predictiva de dichos biomarcadores



El enfoque combina múltiples cohortes GEO y técnicas de integración de datos multi-plataforma.



\---



\## Datos utilizados



Se han integrado varias cohortes públicas de GEO:



\### Tumor (análisis principal)

\- GSE78220 – anti-PD-1

\- GSE215868 – anti-PD-1

\- GSE211645 – anti-CTLA-4



\### Sangre (análisis de sensibilidad)

\- GSE91061



\---



\## Pipeline de análisis



El flujo de trabajo incluye:



\### 1. Exploración de datasets

\- Revisión de variables clínicas

\- Identificación de muestras baseline

\- Definición de variable de respuesta



\### 2. Construcción de objetos SummarizedExperiment

\- Expresión génica

\- Metadatos clínicos

\- Anotación de genes



\### 3. Integración de datos

\- Conversión a gene symbol

\- Intersección de genes comunes

\- Construcción de dataset integrado



\### 4. Separación por tejido

\- Bloque tumoral (análisis principal)

\- Bloque sangre (análisis de sensibilidad)



\### 5. Análisis exploratorio

\- PCA pre-batch

\- Evaluación de batch effect (dataset/plataforma)



\### 6. Corrección de batch

\- limma::removeBatchEffect

\- Protección de variable de respuesta



\### 7. Análisis diferencial (DEA)

\- Modelo lineal con limma

\- Comparación respondedores vs no respondedores

\- Ajuste por cohorte (cuando aplica)

\- Análisis de robustez (con y sin corrección)



\---



\## Estructura del repositorio



```

2\_TFM\_MELANOMA/

├── integrated\_dataset/

├── resultados/

├── scripts/

│   ├── GEO/

│   ├── integration/

│   └── analysis/

```



\---



\## Reproducibilidad



El proyecto es reproducible mediante los scripts RMarkdown (.Rmd).



Orden recomendado:



1\. integracion\_inicial\_GEO\_SummarizedExperiment.Rmd  

2\. reconstruccion\_GEO\_tumor\_blood\_SummarizedExperiment.Rmd  

3\. pca\_prebatch\_GEO\_tumor.Rmd  

4\. batch\_correction\_pca\_postbatch\_GEO\_tumor.Rmd  

5\. DEA\_limma\_GEO\_tumor\_response.Rmd  



\---



\## Notas importantes



\- Los datos crudos no se incluyen por tamaño (disponibles en GEO)

\- Algunos objetos intermedios (.rds) no se incluyen por reproducibilidad

\- Se incluyen objetos clave para facilitar la exploración



\---



\## Resultados principales



\- No se identificaron genes diferencialmente expresados tras corrección FDR  

\- Se observa alta heterogeneidad entre cohortes  

\- Posible limitación por tamaño muestral y plataformas  

\- Identificación de genes candidatos a nivel exploratorio  



\---



\## Autor



Sonia Salmerón  

TFM – Análisis bioinformático en melanoma

