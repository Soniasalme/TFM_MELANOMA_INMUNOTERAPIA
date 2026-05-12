# PEC3 - Informe de seguimiento del TFM

**Titulo provisional del TFM:** Identificacion de biomarcadores transcriptomicos asociados a respuesta a inmunoterapia en melanoma  
**Estudiante:** Sonia Salmeron  
**Fecha:** 8 de mayo de 2026  

## 1. Introduccion y objetivo del informe

El presente informe de seguimiento recoge el estado de desarrollo del Trabajo de Fin de Master hasta la fecha. El proyecto se centra en el analisis de datos transcriptomicos publicos de melanoma avanzado tratado con inmunoterapia, con el objetivo de identificar patrones moleculares asociados a respuesta terapeutica y explorar su posible utilidad como biomarcadores.

El planteamiento inicial del TFM combinaba dos ejes complementarios:

- Un bloque pronostico, basado en TCGA-SKCM, orientado al estudio de supervivencia y variables asociadas a pronostico.
- Un bloque predictivo, basado en cohortes GEO de pacientes tratados con inhibidores de checkpoints inmunitarios, orientado a comparar respondedores y no respondedores.

Durante el desarrollo del proyecto, y tras la revision metodologica con la tutora, el bloque GEO se ha reestructurado hacia un diseno de descubrimiento y validacion, mas adecuado para estudios de biomarcadores. Esta modificacion mejora la coherencia biologica del trabajo y evita mezclar fuentes de variacion que podrian sesgar los resultados.

## 2. Evolucion del proyecto y cambios respecto al plan inicial

En una primera fase se exploraron diferentes bases de datos publicas, principalmente TCGA-SKCM y varias cohortes GEO. TCGA-SKCM resulto adecuado para el analisis pronostico, pero no incluye informacion directa de tratamiento con inmunoterapia ni respuesta terapeutica, por lo que no permite responder a la pregunta predictiva principal.

Por este motivo, el trabajo predictivo se centro en cohortes GEO con datos de expresion y respuesta a inmunoterapia. Inicialmente se construyo un dataset integrado con varias cohortes, utilizando los genes comunes entre plataformas. Sin embargo, la revision posterior mostro dos limitaciones relevantes:

- La interseccion de genes estaba condicionada por los paneles NanoString, lo que restringia el analisis a genes preseleccionados por esos paneles.
- Algunas cohortes diferian en tejido, plataforma y tipo de checkpoint inmunitario, lo que podia introducir heterogeneidad biologica no atribuible unicamente a batch effect.

A partir de esta revision, el proyecto se reorganizo del siguiente modo:

1. **Analisis principal de descubrimiento:** GSE78220, cohorte tumoral RNA-seq tratada con anti-PD-1. Se utiliza como cohorte principal porque permite analizar el transcriptoma completo sin restriccion por panel NanoString.
2. **Validacion tumoral anti-PD-1:** GSE215868, cohorte tumoral NanoString tratada con anti-PD-1. Permite evaluar si los genes/firma identificados en RNA-seq se reproducen en una plataforma independiente.
3. **Validacion exploratoria anti-CTLA-4:** GSE211645, cohorte tumoral NanoString tratada con ipilimumab. Se interpreta como generalizacion a otro checkpoint, no como validacion directa anti-PD-1.
4. **Sensibilidad en sangre:** GSE91061 y GSE94873, usadas para evaluar si la firma tumoral es detectable en sangre periferica.
5. **Analisis integrado exploratorio:** dataset tumoral comun limitado a 200 genes, usado solo como analisis de consistencia de direccion de efecto, no como base principal de descubrimiento.

Este cambio supone una desviacion respecto al analisis integrado inicial, pero esta justificado porque separa claramente descubrimiento, validacion y sensibilidad, siguiendo un esquema mas habitual en estudios de biomarcadores.

## 3. Trabajo desarrollado hasta el momento

### 3.1. Exploracion y construccion de objetos por cohorte

Se ha completado la exploracion inicial y la construccion de objetos `SummarizedExperiment` para las principales cohortes GEO:

- GSE78220: tumor, RNA-seq, anti-PD-1.
- GSE215868: tumor, NanoString, anti-PD-1.
- GSE211645: tumor, NanoString, anti-CTLA-4.
- GSE91061: sangre/PBMC, RNA-seq, varios tratamientos ICI.
- GSE94873: sangre, NanoString, tremelimumab anti-CTLA-4.

Para cada cohorte se ha seguido un flujo reproducible:

1. Descarga o carga de datos desde GEO.
2. Exploracion de metadatos clinicos y matriz de expresion.
3. Identificacion de variables clave: muestra, respuesta, tejido, tratamiento y baseline.
4. Filtrado a muestras pretratamiento cuando procede.
5. Recodificacion de respuesta binaria en `Responder` y `No_responder`.
6. Construccion del objeto `SummarizedExperiment`.

En GSE94873 se confirmo que el dataset contiene 720 muestras NanoString de sangre, de las cuales 360 corresponden a pretratamiento. La respuesta se codifica como 1/0 y se recodifico a `Responder`/`No_responder`, quedando 46 respondedores y 314 no respondedores. Este desequilibrio de clases se tiene en cuenta en la interpretacion.

### 3.2. Analisis principal de descubrimiento en GSE78220

El analisis principal se realizo sobre GSE78220, usando expresion transformada a `log2(expr + 1)` antes de aplicar `limma`. Esta correccion fue necesaria porque los datos estaban en escala lineal y el modelo lineal requiere una escala aproximadamente estabilizada.

Resultados principales:

- Numero de muestras: 25.
- Respondedores: 14.
- No respondedores: 11.
- Genes testados: mas de 22.000.
- Genes significativos tras FDR: 0.
- Genes nominales con `P < 0.05` y `|logFC| >= 0.5`: 505.
- Modelo exploratorio LOOCV con top 5 genes: AUC aproximada de 0.667.

La ausencia de genes significativos tras correccion FDR es esperable por el bajo tamano muestral y el gran numero de genes testados. Por tanto, los resultados se interpretan como hipotesis de descubrimiento, no como biomarcadores concluyentes.

### 3.3. Validacion tumoral

En GSE215868 se evaluo la reproducibilidad de los genes/firma obtenidos en GSE78220 en una cohorte independiente de tumor, tambien anti-PD-1, pero medida con NanoString.

Resultados principales:

- 4 genes del top 50 de GSE78220 estaban presentes en el panel NanoString de GSE215868.
- El 75% de esos genes mantuvo la misma direccion de efecto.
- La AUC de la firma fue aproximadamente 0.519.

Este resultado es modesto, pero metodologicamente relevante, ya que el solapamiento esta limitado por la plataforma NanoString.

En GSE211645, el analisis se interpreta como validacion exploratoria frente a otro checkpoint:

- Cohorte tumoral NanoString.
- Tratamiento: anti-CTLA-4.
- 1 gen del top 50 de GSE78220 solapo con el panel.
- La direccion no se mantuvo.
- AUC aproximada de la firma: 0.301.

Este resultado refuerza que la respuesta a anti-PD-1 y anti-CTLA-4 no debe mezclarse de forma directa en el descubrimiento.

### 3.4. Analisis de sensibilidad en sangre

Se evaluo si la firma derivada del tumor era detectable en sangre periferica usando GSE91061 y GSE94873.

GSE91061 presenta una fuente de distancia respecto al discovery:

- Cambio de tejido: tumor a sangre.

GSE94873 presenta tres fuentes de distancia:

- Cambio de tejido: tumor a sangre.
- Cambio de checkpoint: anti-PD-1 a anti-CTLA-4.
- Cambio de plataforma: RNA-seq a NanoString.

Resultados:

- GSE91061: AUC de la firma tumoral en sangre = 0.50.
- GSE94873: AUC de la firma tumoral en sangre = 0.477.

Estos resultados indican que la firma tumoral derivada de anti-PD-1 no muestra senal predictiva clara en sangre periferica. Esta ausencia de transferibilidad no se interpreta como un fallo del analisis, sino como una consecuencia esperable del cambio de contexto biologico y tecnico.

### 3.5. Analisis integrado de consistencia

El objeto integrado tumoral se conserva como analisis exploratorio de consistencia limitado a los genes comunes entre plataformas. En el bloque tumoral integrado se identificaron 200 genes comunes entre GSE78220, GSE215868 y GSE211645.

Resultados de consistencia:

- 61 genes mantienen direccion positiva en las tres cohortes.
- 8 genes mantienen direccion negativa en las tres cohortes.
- 131 genes son discordantes.

La senal mas coherente biologicamente se centra en genes relacionados con presentacion antigenica e interferon:

- HLA-A, HLA-B, HLA-C, HLA-E, HLA-F.
- PSMB8.
- IFNGR1.
- STAT2.
- SLAMF7.
- ICAM1.

Esta firma es compatible con activacion de respuesta inmune, presentacion de antigeno por MHC-I y senalizacion IFN-gamma, mecanismos biologicamente relacionados con la respuesta a inmunoterapia.

## 4. Entregables parciales generados

El trabajo desarrollado se ha documentado mediante scripts reproducibles, informes HTML y tablas de resultados.

Entregables principales:

- `scripts/analysis/01_GSE78220_discovery.html`
- `scripts/analysis/02_tumor_validation.html`
- `scripts/analysis/03_blood_sensitivity.html`
- `scripts/analysis/04_consistency_integrated.html`
- `scripts/analysis/05_summary_table.html`

Resultados generados:

- `resultados/discovery_GSE78220/`
- `resultados/validation_tumor/`
- `resultados/sensitivity_blood/`
- `resultados/consistency_integrated/`
- `resultados/summary/`

Tambien se ha actualizado el repositorio GitHub del proyecto con los scripts, informes HTML y tablas de resultados. Los objetos `SummarizedExperiment` individuales y los datos crudos no se suben por defecto porque son regenerables y ocupan mas espacio, pero el pipeline contiene los Rmd necesarios para reconstruirlos.

## 5. Revision de la temporizacion

La planificacion inicial contemplaba avanzar de forma paralela en el bloque pronostico TCGA y el bloque predictivo GEO. Sin embargo, la revision metodologica del bloque GEO requirio reestructurar el analisis para separar adecuadamente descubrimiento, validacion y sensibilidad.

Esta decision ha supuesto una desviacion temporal, principalmente porque:

- Se rehizo el analisis principal para usar GSE78220 como discovery transcriptomico completo.
- Se recalcularon los analisis tras corregir la escala de expresion con `log2(expr + 1)`.
- Se incorporo GSE94873 como cohorte adicional de sensibilidad en sangre.
- Se genero un nuevo informe resumen para facilitar la revision de resultados.

La desviacion se considera justificada, ya que mejora la validez cientifica del trabajo y evita conclusiones sesgadas por mezcla de plataformas, tejidos y mecanismos terapeuticos.

### Acciones de mitigacion

Para mantener el proyecto dentro del calendario, se proponen las siguientes acciones:

1. Mantener el bloque GEO actual como bloque predictivo principal ya consolidado.
2. No ampliar con nuevas cohortes salvo indicacion expresa de la tutora.
3. Reencajar TCGA como bloque pronostico paralelo, sin mezclarlo con GEO.
4. Priorizar la redaccion de metodos y resultados ya generados.
5. Reservar los modelos predictivos mas complejos como analisis exploratorio, evitando sobredimensionar conclusiones con muestras pequenas.

## 6. Plan de trabajo actualizado

| Periodo | Tarea principal | Resultado esperado |
|---|---|---|
| Semana 1 | Cerrar bloque GEO predictivo y tablas resumen | Resultados GEO listos para memoria |
| Semana 2 | Reencajar bloque TCGA pronostico | Seccion de pronostico estructurada |
| Semana 3 | Redactar metodos y resultados | Primer borrador de memoria |
| Semana 4 | Discusion, limitaciones y conclusiones | Borrador completo revisable |
| Semana 5 | Revision final, formato y bibliografia | Version final para entrega |

## 7. Riesgos y limitaciones actuales

Las principales limitaciones identificadas son:

- Bajo tamano muestral en la cohorte principal GSE78220.
- Diferencias entre plataformas RNA-seq y NanoString.
- Diferencias biologicas entre tejido tumoral y sangre.
- Diferencias entre checkpoints anti-PD-1 y anti-CTLA-4.
- Desequilibrio de clases en GSE94873, con muchos mas no respondedores que respondedores.
- Escaso solapamiento entre genes de discovery y paneles NanoString.

Estas limitaciones se incorporaran de forma explicita en la memoria. En particular, se evitara presentar los resultados como una firma predictiva definitiva; se interpretaran como un analisis exploratorio de biomarcadores transcriptomicos con validacion parcial y sensibilidad biologicamente informada.

## 8. Aspectos eticos, reproducibilidad e integridad academica

El proyecto utiliza datos publicos procedentes de repositorios reconocidos, principalmente GEO y TCGA. Los datos estan anonimizados y no permiten identificar directamente a pacientes individuales.

Desde el punto de vista de integridad academica, se mantiene un registro reproducible del analisis mediante:

- Scripts R Markdown.
- Informes HTML generados automaticamente.
- Tablas CSV de resultados.
- Control de versiones con Git/GitHub.
- Separacion entre datos crudos, objetos intermedios y resultados derivados.

En la memoria se citaran adecuadamente las cohortes originales, los articulos asociados y los paquetes utilizados. Las interpretaciones se formularan de acuerdo con las limitaciones del diseno y evitando sobreinterpretar resultados exploratorios.

## 9. Avance de la memoria

La memoria puede empezar a redactarse con la siguiente estructura:

1. Introduccion: melanoma, inmunoterapia, heterogeneidad molecular y necesidad de biomarcadores.
2. Objetivos: pronostico con TCGA y prediccion/sensibilidad con GEO.
3. Materiales y metodos: descripcion de cohortes, preprocesamiento, `SummarizedExperiment`, DEA, validacion, sensibilidad y consistencia.
4. Resultados: discovery GSE78220, validacion tumoral, sensibilidad en sangre, consistencia integrada.
5. Discusion: interpretacion biologica, senal IFN-gamma/MHC-I, limitaciones de plataforma, tejido y checkpoint.
6. Conclusiones y trabajo futuro.

El bloque GEO ya dispone de resultados suficientes para redactar una primera version de metodos y resultados. El siguiente paso sera integrar el bloque TCGA como analisis pronostico separado y terminar de articular la discusion global.

## 10. Conclusiones del seguimiento

En el momento actual, el proyecto se encuentra en una fase avanzada de implementacion del bloque predictivo GEO. Se ha completado la exploracion, preprocesamiento y analisis de varias cohortes, y se ha reestructurado el enfoque metodologico para hacerlo mas robusto.

La principal decision metodologica ha sido pasar de un analisis integrado como bloque central a un esquema de descubrimiento-validacion-sensibilidad. Esta decision esta justificada por diferencias de plataforma, tejido y tratamiento, y permite defender mejor los resultados en la memoria.

El siguiente objetivo es consolidar el bloque pronostico TCGA y avanzar en la redaccion de la memoria, utilizando los informes HTML y tablas ya generados como base de resultados.
