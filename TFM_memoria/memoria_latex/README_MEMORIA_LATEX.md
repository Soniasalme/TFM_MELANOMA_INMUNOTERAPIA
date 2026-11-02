# Memoria TFM en LaTeX - formato UOC

Esta carpeta contiene la versión de trabajo de la memoria en LaTeX usando la plantilla UOC `TFUOC.cls`.

## Cómo se ha compilado la memoria

El PDF final se genera con **pdfLaTeX** (pdfTeX 1.40.28, TeX Live 2025, instalación TinyTeX en Windows), usando la clase oficial de la UOC `TFUOC.cls`. La bibliografía se gestiona con **BibTeX** (`ibliographystyle{unsrt}` y `bibliografia.bib`); `latexmk` ejecuta automáticamente las pasadas de pdfLaTeX y BibTeX necesarias. Las referencias cruzadas, el índice y las citas se resuelven tras varias pasadas, por lo que no basta con una única ejecución de `pdflatex`.

Desde esta carpeta (`TFM_memoria/memoria_latex/`):

```powershell
latexmk -pdf -interaction=nonstopmode main.tex
```

Esto genera `main.pdf` (50 páginas). Para limpiar los archivos auxiliares:

```powershell
latexmk -c main.tex
```

Tras compilar, el PDF se copia a `memoria/TFM_Salmeron_Fructuoso_Sonia_2026.pdf` (versión de entrega en la raíz del repositorio); ambos archivos deben ser idénticos.

Las figuras se incluyen desde `figures/` (PNG exportados de los análisis en R; las de TCGA proceden de `scripts/TCGA/`). Las clases y logotipos de la UOC (`TFUOC.cls`, `UOCllarg.*`, `uoc*.png`) están incluidos en esta carpeta y no requieren instalación adicional.

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
