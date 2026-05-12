# Memoria TFM en LaTeX - formato UOC

Esta carpeta contiene una primera versión de la memoria en LaTeX usando la plantilla UOC `TFUOC.cls`.

La compilación de prueba ya se ha ejecutado correctamente y genera `main.pdf`.

## Compilación

Desde esta carpeta:

```powershell
latexmk -pdf -interaction=nonstopmode main.tex
```

Para limpiar auxiliares:

```powershell
latexmk -c main.tex
```

## Estructura

- `main.tex`: documento principal y metadatos.
- `chapters/01_introduccion.tex`: introducción, objetivos, CCEG, planificación e IA generativa.
- `chapters/02_estado_arte.tex`: estado del arte inicial.
- `chapters/03_metodologia.tex`: diseño, cohortes, preprocesamiento y análisis.
- `chapters/04_resultados.tex`: resultados GEO actuales y hueco para TCGA.
- `chapters/05_discusion.tex`: discusión inicial.
- `chapters/06_conclusiones.tex`: conclusiones y líneas futuras.
- `chapters/07_glosario.tex`: acrónimos.
- `chapters/08_anexos.tex`: repositorio, entregables y pendientes.
- `bibliografia.bib`: bibliografía inicial.

## Pendientes importantes

- Completar el bloque TCGA-SKCM.
- Sustituir referencias GEO genéricas por artículos originales cuando se cierre la bibliografía.
- Exportar figuras finales desde los Rmd y añadirlas a `figures/`.
- Completar `\nomPRA{}` si la asignatura requiere el nombre del PRA.
- Revisar el texto final con la tutora antes de entrega.

## Nota técnica

Se ha copiado la clase oficial `TFUOC.cls`. La única adaptación local ha sido quitar el driver fijo `dvips` de `graphicx` para que compile con `pdflatex` en TinyTeX.
