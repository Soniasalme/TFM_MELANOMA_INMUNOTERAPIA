Estructura metodológica ideal para cada GEO

Para cada dataset GEO, deberías tener siempre:

Exploración inicial
Diseño del dataset
Construcción del SummarizedExperiment
Guardado del contenedor
Integración posterior

Esto es exactamente cómo se trabajan datos ómicos en proyectos reales.

Para cada GEO:

GSE78220
exploracion_inicial_GSE78220.Rmd
plantilla_SummarizedExperiment_GSE78220.Rmd
GSE91061
exploracion_inicial_GSE91061.Rmd
plantilla_SummarizedExperiment_GSE91061.Rmd
GSE215868
exploracion_inicial_GSE215868.Rmd
plantilla_SummarizedExperiment_GSE215868.Rmd
GSE211645 (cuando lo hagamos)
exploracion_inicial_GSE211645.Rmd
plantilla_SummarizedExperiment_GSE211645.Rmd

Esto es muy importante para la memoria del TFM, porque podrás escribir algo como:

Para cada cohorte GEO se realizó una fase inicial de exploración y caracterización del dataset con el fin de identificar las variables clínicas relevantes, la estructura de la matriz de expresión y los identificadores de muestra adecuados. Posteriormente, se construyó un contenedor ómico estandarizado (SummarizedExperiment) para cada cohorte, permitiendo su integración posterior en un análisis conjunto.

Eso suena a TFM muy bien estructurado.


---------------------------------------

GEO ya trabajados
GSE78220 → Tumor, anti-PD-1, RNA-seq
GSE91061 → Tumor, varios ICI, RNA-seq
GSE215868 → Tumor, anti-PD-1, NanoString

Con estos tres ya tienes una base muy buena para la parte predictiva.

---------------------------------------


Siguiente paso lógico del proyecto

El siguiente GEO que te propuso tu tutora fue:

GSE211645
Tipo: Tumor
Tratamiento: Ipilimumab (anti-CTLA-4)
Plataforma: NanoString
Nº genes: ~412
Nº muestras pre-tratamiento: ~14

Este dataset es pequeño, pero muy útil para validación externa, no tanto para entrenar modelos.

Orden en el que deberíamos trabajar ahora

Te recomiendo este orden:

GSE211645 → Tumor → NanoString
GSE94873 → Sangre → NanoString (opcional, más diferente biológicamente)
Después → Integración de datasets
Después → Contenedor ómico final
Después → Análisis diferencial + modelos predictivos
Pipeline que ya tienes definido (esto es muy importante)

Tu pipeline ya está estandarizado y eso es perfecto:

Para cada GEO haces siempre lo mismo:

Para cada dataset GEO

Siempre crear:

exploracion_inicial_GSEXXXXX.Rmd
plantilla_SummarizedExperiment_GSEXXXXX.Rmd
Resultado:
HTML exploración
HTML SummarizedExperiment
se_gseXXXXX.rds

Tu proyecto ya tiene una estructura muy profesional.

Estructura final que deberías acabar teniendo

TFM/
│
├── GEO_raw/                         # Datos descargados de GEO
│   ├── GSE78220/
│   ├── GSE91061/
│   ├── GSE215868/
│   └── GSE211645/
│
├── SummarizedExperiment_objects/    # Objetos RDS de cada cohorte
│   ├── se_gse78220.rds
│   ├── se_gse91061.rds
│   ├── se_gse215868.rds
│   └── se_gse211645.rds
│
├── integrated_dataset/              # NUEVA carpeta
│   └── se_integrated_initial_geo.rds
│
├── scripts/
│   ├── GEO/
│   │   ├── GSE78220/
│   │   ├── GSE91061/
│   │   ├── GSE215868/
│   │   └── GSE211645/
│   │
│   ├── integration/
│   │   └── integracion_inicial_GEO_SummarizedExperiment.Rmd
│
├── resultados/
├── figuras/
├── TFM_memoria/
└── README

Esto es lo que realmente será tu trabajo:

Fase integración
Cargar todos los SummarizedExperiment
Obtener genes comunes
Combinar matrices
Añadir variable cohorte
Corregir batch effect (ComBat)
PCA / UMAP
Expresión diferencial (Responders vs Non-responders)
Modelos predictivos
Validación entre cohortes

Esto será el núcleo del TFM.

Resumen de en qué punto estás ahora

Estás exactamente aquí:

TCGA → Pronóstico ✔
GEO 78220 → ✔
GEO 91061 → ✔
GEO 215868 → ✔
GEO 211645 → (siguiente)
Integración datasets → pendiente
Modelos predictivos → pendiente
TFM resultados → pendiente

Y esto, honestamente, ya es muchísimo trabajo hecho.

----------------------------------------

Veredicto final

GSE211645 queda cerrado correctamente.

Con esto ya tienes completados los cuatro GEO principales del bloque tumoral:

GSE78220 ✔
GSE91061 ✔
GSE215868 ✔
GSE211645 ✔
En qué punto del TFM estás ahora

Ahora mismo ya has terminado la fase de:

exploración inicial de cohortes GEO,
construcción de SummarizedExperiment por cohorte,
organización reproducible del proyecto,
y preparación de los .rds individuales.

Eso significa que el siguiente paso lógico ya no es otro GEO, sino la integración de datasets.

Siguiente paso natural

Ahora toca empezar con algo tipo:

cargar se_gse78220.rds
cargar se_gse91061.rds
cargar se_gse215868.rds
cargar se_gse211645.rds
estudiar genes comunes
preparar integración multi-cohorte
y después batch correction / análisis predictivo

El siguiente movimiento útil es hacer un Rmd de integración inicial de los SummarizedExperiment GEO.

----------------------------------------------------------

Perfecto, gracias por la captura. Entonces tu estructura real ahora mismo es esta:

TFM/
│
├── figuras/
├── GEO_raw/
├── resultados/
├── scripts/
├── SummarizedExperiment_objects/
├── TFM_memoria/
└── README

Esto está bien, no es obligatorio tener carpeta data/. Podemos trabajar perfectamente así.
Lo importante es ser consistente con las rutas en todos los Rmd.

Dónde poner el script de integración

Crea dentro de scripts una carpeta nueva:

TFM/
├── scripts/
│   ├── GEO/
│   └── integration/

Y ahí coloca:

scripts/integration/integracion_inicial_GEO_SummarizedExperiment.Rmd
Estructura final recomendada (muy importante para tu TFM)

Te recomiendo que tu proyecto quede así:

TFM/
│
├── GEO_raw/                         # Datos descargados de GEO
│   ├── GSE78220/
│   ├── GSE91061/
│   ├── GSE215868/
│   └── GSE211645/
│
├── SummarizedExperiment_objects/    # Objetos RDS de cada cohorte
│   ├── se_gse78220.rds
│   ├── se_gse91061.rds
│   ├── se_gse215868.rds
│   └── se_gse211645.rds
│
├── integrated_dataset/              # NUEVA carpeta
│   └── se_integrated_initial_geo.rds
│
├── scripts/
│   ├── GEO/
│   │   ├── GSE78220/
│   │   ├── GSE91061/
│   │   ├── GSE215868/
│   │   └── GSE211645/
│   │
│   ├── integration/
│   │   └── integracion_inicial_GEO_SummarizedExperiment.Rmd
│
├── resultados/
├── figuras/
├── TFM_memoria/
└── README

Crea esta carpeta nueva:

integrated_dataset/
Muy importante: rutas que debe usar el script de integración

Como tu estructura NO tiene carpeta data/, las rutas correctas dentro del Rmd deberían ser:

project_root <- normalizePath(file.path("..", ".."), winslash = "/")

se_dir <- file.path(project_root, "SummarizedExperiment_objects")
integrated_dir <- file.path(project_root, "integrated_dataset")
results_dir <- file.path(project_root, "resultados")
figures_dir <- file.path(project_root, "figuras")

Si el script que te pasé usa "data/SummarizedExperiment_objects" entonces habría que cambiarlo. Si quieres, luego lo ajustamos.

Muy importante conceptualmente (esto es clave para tu TFM)

Tu pipeline ahora mismo ya es esto:

Fase 1 – Por cada GEO

Para cada dataset:

Exploración inicial
→ exploracion_inicial_GSEXXXX.Rmd
Construcción SummarizedExperiment
→ plantilla_SummarizedExperiment_GSEXXXX_automatizada.Rmd
Resultado
→ se_gseXXXX.rds
Fase 2 – Integración (en la que estás ahora)

Script:

scripts/integration/integracion_inicial_GEO_SummarizedExperiment.Rmd

Resultado:

integrated_dataset/se_integrated_initial_geo.rds
Fase 3 – Lo que vendrá después

Esto ya será el núcleo del TFM:

Corrección batch effect (ComBat)
PCA / UMAP por cohorte
Análisis diferencial (responders vs non responders)
Selección de genes
Modelo predictivo
Validación por cohortes
Curvas ROC / AUC

Estás justo en el punto donde empieza la parte realmente interesante del TFM.

Resumen corto

Haz esto ahora:

Crear carpeta:

integrated_dataset/

Crear carpeta:

scripts/integration/

Mover el Rmd de integración a:

scripts/integration/
Ejecutarlo

Y eso te generará tu dataset integrado de inmunoterapia, que probablemente será el dataset principal de tu TFM.


----------------------------------

