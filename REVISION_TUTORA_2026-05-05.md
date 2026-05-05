# Revision metodologica tras comentario de Teresa

Fecha: 2026-05-05

## Contexto

El trabajo de integracion multi-cohorte realizado hasta ahora es tecnicamente solido y queda documentado en los informes HTML del repositorio. Sin embargo, la ultima revision de Teresa recomienda refinar la pregunta biologica y separar mejor descubrimiento, validacion y sensibilidad.

## Punto critico 1: restriccion por NanoString

La integracion conjunta de RNA-seq y NanoString obliga a trabajar solo con los genes comunes entre plataformas. En el objeto global inicial hay 198 genes comunes y en el bloque tumoral integrado hay 200 genes comunes.

Esta restriccion no es neutra porque los paneles NanoString ya contienen una seleccion previa de genes, principalmente orientada a inmuno-oncologia. Por tanto, un DEA realizado solo sobre esos genes puede perder genes relevantes que si estan medidos en RNA-seq.

## Punto critico 2: tratamiento

La pregunta principal del TFM es que diferencia transcriptomicamente a respondedores y no respondedores a inmunoterapia.

No obstante:

- `GSE78220` y `GSE215868` son anti-PD-1.
- `GSE211645` es anti-CTLA-4 / ipilimumab.

PD-1 y CTLA-4 tienen mecanismos biologicos distintos. Mezclarlos en un unico DEA puede diluir la senal o mezclar patrones biologicos diferentes.

## Reestructuracion propuesta

### Analisis principal

`GSE78220`

- Tumor.
- RNA-seq.
- Anti-PD-1.
- Transcriptoma completo.
- Cohorte mas adecuada como descubrimiento.

Analisis previstos:

- Confirmar muestras baseline.
- Confirmar definicion de respuesta.
- DEA respondedores vs no respondedores.
- Modelos predictivos preliminares.

### Validacion 1

`GSE215868`

- Tumor.
- NanoString.
- Anti-PD-1.
- Misma indicacion biologica que GSE78220, distinta plataforma.

Objetivo:

- Evaluar si los genes/firma derivados del RNA-seq se reproducen en NanoString.

### Validacion 2

`GSE211645`

- Tumor.
- NanoString.
- Anti-CTLA-4.

Objetivo:

- Evaluar si la firma generaliza a otro checkpoint inmunologico.

### Analisis de sensibilidad en sangre

`GSE91061` y posible incorporacion de `GSE94873`.

Objetivo:

- Evaluar si la firma tumoral es detectable en sangre periferica.

### Integracion multi-cohorte

El dataset integrado no se descarta. Se mantiene como:

- Analisis exploratorio.
- Analisis de consistencia.
- Evaluacion de direccion de efectos en genes comunes.

Pero no se usara como base principal de descubrimiento.

## Consecuencia para la memoria

Este enfoque es mas defendible porque separa:

- Descubrimiento: RNA-seq tumoral anti-PD-1.
- Validacion tecnica/biologica: NanoString anti-PD-1.
- Generalizacion a otro checkpoint: anti-CTLA-4.
- Sensibilidad por tipo de muestra: sangre.

Esto alinea mejor el TFM con un esquema estandar de estudios de biomarcadores.

## Proximos pasos

1. Crear bloque de analisis principal para `GSE78220`.
2. Ejecutar DEA RNA-seq anti-PD-1 sin restriccion por panel NanoString.
3. Construir modelos predictivos preliminares en `GSE78220`.
4. Validar genes/firma en `GSE215868`.
5. Explorar generalizacion en `GSE211645`.
6. Valorar sensibilidad en sangre con `GSE91061` y `GSE94873`.

## Implementacion realizada

Se han creado cinco informes nuevos en `scripts/analysis/`:

1. `01_GSE78220_discovery.Rmd`
   - Usa `GSE78220` como cohorte principal de descubrimiento.
   - Ejecuta DEA con `limma` sobre transcriptoma completo.
   - Genera un modelo exploratorio de firma con leave-one-out cross-validation.

2. `02_tumor_validation.Rmd`
   - Evalua los genes/firma de `GSE78220` en `GSE215868`.
   - Evalua generalizacion en `GSE211645`.
   - Deriva `response_binary` en `GSE211645` desde `response_raw`, porque el objeto original la tenia como NA.

3. `03_blood_sensitivity.Rmd`
   - Usa `GSE91061` como sensibilidad en sangre.
   - Corrige el tejido a `Blood` dentro del analisis.
   - Deriva respondedores desde `response_raw`.
   - Deja `GSE94873` documentado como pendiente.

4. `04_consistency_integrated.Rmd`
   - Usa el objeto integrado tumoral como analisis de consistencia.
   - Compara `GSE78220`, `GSE215868` y `GSE211645` en los 200 genes comunes.
   - Genera una tabla cruzada de logFC, P-valor y concordancia de direccion por cohorte.
   - Mantiene este bloque como apoyo exploratorio, no como descubrimiento principal.

5. `05_summary_table.Rmd`
   - Consolida los resultados de los bloques 01-04.
   - Genera tablas resumen para revision semanal y para trasladar a la memoria.
   - Resume cohortes, DEA discovery, LOOCV, validacion tumoral, sensibilidad en sangre, consistencia integrada y firma biologica clave.

Resultados generados:

- `resultados/discovery_GSE78220/`
- `resultados/validation_tumor/`
- `resultados/sensitivity_blood/`
- `resultados/consistency_integrated/`
- `resultados/summary/`

Resumen preliminar:

- Tras revisar la escala de expresion, los analisis se rehacen con `log2(expr + 1)` antes de aplicar `limma`.
- En `GSE78220` no hay genes significativos tras FDR, pero hay 505 genes nominales con `P < 0.05` y `|logFC| >= 0.5` que pueden usarse como candidatos exploratorios.
- El modelo exploratorio LOOCV con top 5 genes obtiene AUC aproximada de 0.67. Debe interpretarse como preliminar por el bajo tamano muestral.
- En `GSE215868`, 4 genes del top 50 de `GSE78220` solapan con el panel y el 75% mantiene la direccion de efecto.
- En `GSE211645`, 1 gen del top 50 de `GSE78220` solapa con el panel, pero no mantiene direccion. Esto refuerza que anti-CTLA-4 debe interpretarse como generalizacion biologica exploratoria, no como validacion directa anti-PD-1.
- En `GSE91061`, el analisis queda interpretado como sensibilidad en sangre, no como descubrimiento tumoral.
- En el analisis de consistencia integrado hay 200 genes comunes: 61 mantienen direccion positiva en todas las cohortes, 8 direccion negativa en todas y 131 son discordantes. Solo 1 gen del top 50 de descubrimiento (`AXL`) y 2 del top 100 (`AXL`, `IL10`) aparecen en el conjunto comun, y ambos muestran discordancia entre cohortes. Esto apoya la decision metodologica de no usar el dataset integrado como base principal de descubrimiento.
