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

Se han creado tres informes nuevos en `scripts/analysis/`:

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

Resultados generados:

- `resultados/discovery_GSE78220/`
- `resultados/validation_tumor/`
- `resultados/sensitivity_blood/`

Resumen preliminar:

- En `GSE78220` no hay genes significativos tras FDR, pero hay genes nominales que pueden usarse como candidatos exploratorios.
- El modelo exploratorio LOOCV con top 5 genes obtiene AUC aproximada de 0.66.
- En `GSE215868`, algunos genes candidatos de `GSE78220` solapan y mantienen direccion de efecto.
- En `GSE211645`, el solapamiento con el top 50 de discovery es nulo, probablemente por la composicion del panel NanoString y por el cambio biologico anti-PD-1 vs anti-CTLA-4.
- En `GSE91061`, el analisis queda interpretado como sensibilidad en sangre, no como descubrimiento tumoral.
