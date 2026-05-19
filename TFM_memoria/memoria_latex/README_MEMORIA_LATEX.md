# Memoria TFM en LaTeX - formato UOC

Esta carpeta contiene la versión de trabajo de la memoria en LaTeX usando la plantilla UOC `TFUOC.cls`.

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
- `chapters/04_resultados.tex`: resultados GEO y TCGA-SKCM.
- `chapters/05_discusion.tex`: discusión de resultados.
- `chapters/06_conclusiones.tex`: conclusiones y líneas futuras.
- `chapters/07_glosario.tex`: acrónimos.
- `chapters/08_anexos.tex`: repositorio, entregables y revisión final.
- `bibliografia.bib`: bibliografía inicial.

## Pendientes importantes

- Confirmar `\nomPRA{}` si la asignatura requiere el nombre del PRA.
- Revisar el texto final con la tutora antes de la entrega.
- Ajustar o exportar figuras finales en alta resolución si se requiere.

## Nota técnica

Se ha copiado la clase oficial `TFUOC.cls`. La única adaptación local ha sido quitar el driver fijo `dvips` de `graphicx` para que compile con `pdflatex` en TinyTeX.
