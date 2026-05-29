# Identificación de biomarcadores transcriptómicos pronósticos y predictivos de respuesta a inmunoterapia en melanoma

**Sonia Salmerón Fructuoso**  
Máster Universitario en Bioinformática y Bioestadística · Universitat Oberta de Catalunya  
Tutora: Dra. Teresa Torres Moral · Mayo de 2026

---

## Resumen

Este repositorio contiene el código, los resultados y la memoria del Trabajo de Fin de Máster. El proyecto desarrolla un análisis bioinformático integrativo para identificar biomarcadores transcriptómicos asociados al pronóstico y a la respuesta a inmunoterapia en melanoma avanzado, mediante datos públicos de GEO y TCGA.

El trabajo se organiza en dos bloques independientes:

- **Bloque predictivo GEO** — arquitectura discovery · validación · sensibilidad sobre 5 cohortes de respuesta a inhibidores de checkpoint (anti-PD-1 / anti-CTLA-4)
- **Bloque pronóstico TCGA-SKCM** — screening transcriptómico gen a gen (Cox) sobre 470 pacientes con supervivencia global como variable resultado

Ambos bloques convergen en el **eje IFN-γ / MHC-I** como determinante transversal del comportamiento clínico del melanoma.

---

## Resultados principales

### Bloque predictivo GEO

| Cohorte | n | Tejido | Plataforma | Tratamiento | AUC | Rol |
|---|---|---|---|---|---|---|
| GSE78220 | 25 | Tumor | RNA-seq | Pembrolizumab | 0,853 (top 5 genes)* | Descubrimiento |
| GSE215868 | 105 | Tumor | NanoString | Anti-PD-1 | 0,547 | Validación tumoral |
| GSE211645 | 40 | Tumor | NanoString | Anti-CTLA-4 | 0,390 | Exploratoria |
| GSE91061 | 49 | Tumor | RNA-seq | Nivolumab | 0,474 | Validación RNA-seq independiente |
| GSE94873 | 360 | Sangre | NanoString | Tremelimumab | 0,475 | Sensibilidad periférica |

\* Señal exploratoria; n = 25 impide alcanzar significación FDR. No trasladar a estimaciones de rendimiento clínico.

**Análisis de consistencia multi-cohorte** (200 genes comunes entre 3 cohortes tumorales):
- 61 genes sobreexpresados concordantemente en respondedores en las 3 cohortes
- Genes destacados: **HLA-A/B/C/E/F · PSMB8 · IFNGR1 · STAT2 · SLAMF7 · ICAM1**
- Señal convergente en presentación antigénica MHC-I y señalización IFN-γ

**ORA exploratorio en no respondedores (GSE78220):** Extracellular matrix organization (FDR = 1,2×10⁻²², 44 genes), Angiogenesis (FDR = 9,1×10⁻¹²) — reproduce el fenotipo IPRES (Hugo et al. 2016).

### Bloque pronóstico TCGA-SKCM (n = 470)

- Screening Cox gen a gen sobre **5.002 genes** (escala log-CPM)
- **1.439 genes con FDR < 0,05** · 944 genes con FDR < 0,01
- Patrón predominantemente **protector** (HR < 1): alta expresión asociada a mayor supervivencia
- Top genes: **GBP2** (HR = 0,776, FDR = 2,1×10⁻⁷) · GBP4 · IL15 · GIMAP2 · DDX60 · KLRD1 · CCL8
- ORA GO-BP (genes protectores): respuesta a IFN-γ, presentación antigénica MHC-I, activación NK/CD8⁺

**Cox multivariante** (edad, sexo, estadio AJCC):  
Edad: HR = 1,020 por año (p < 0,001) · Estadio III: HR = 1,819 (p = 0,002) · Estadio IV: HR = 2,993 (p = 0,002)

---

## Estructura del repositorio

```
TFM_MELANOMA_INMUNOTERAPIA/
│
├── scripts/
│   ├── GEO/                  # Construcción de objetos SummarizedExperiment por cohorte
│   ├── analysis/             # Análisis bloque GEO (scripts 01–05)
│   │   ├── 01_GSE78220_discovery.Rmd        # Descubrimiento RNA-seq anti-PD-1
│   │   ├── 02_tumor_validation.Rmd          # Validación tumoral NanoString
│   │   ├── 03_blood_sensitivity.Rmd         # Validación tumoral RNA-seq (GSE91061) + sensibilidad periférica (GSE94873)
│   │   ├── 04_consistency_integrated.Rmd    # Consistencia multi-cohorte
│   │   └── 05_summary_table.Rmd             # Tabla resumen de resultados
│   ├── TCGA/                 # Análisis bloque pronóstico (scripts 01–12)
│   │   └── 08_tcga_skcm_transcriptomics_corregido.Rmd  # Screening Cox transcriptómico
│   └── integration/          # Integración multi-cohorte inicial (referencia histórica)
│
├── resultados/
│   ├── discovery_GSE78220/   # DEA, LOOCV, ORA GSE78220
│   ├── validation_tumor/     # Validación NanoString (GSE215868, GSE211645)
│   ├── external_validation/  # Validación RNA-seq independiente (GSE91061)
│   ├── sensitivity_blood/    # Sensibilidad sangre (GSE94873)
│   ├── consistency_integrated/  # Análisis de consistencia 200 genes comunes
│   ├── summary/              # Tablas resumen globales
│   └── _archivo/
│       └── geo_integrado_inicial/  # Fase exploratoria inicial (trazabilidad)
│
└── TFM_memoria/
    └── memoria_latex/        # Memoria en LaTeX (main.tex) + figuras
```

---

## Memoria del TFM

📄 **[memoria/TFM_Salmeron_Fructuoso_Sonia_2026.pdf](memoria/TFM_Salmeron_Fructuoso_Sonia_2026.pdf)** — Memoria completa en PDF

El código fuente LaTeX está en `TFM_memoria/memoria_latex/main.tex`.

---

## Reproducibilidad

Todos los análisis están documentados en **R Markdown** compilados a HTML. Cada informe incluye `sessionInfo()` para trazabilidad de versiones de paquetes.

### Descarga de datos

Los datos se obtienen directamente desde repositorios públicos mediante el script:

```
data/00_download_data.R   # getGEO() para las 5 cohortes GEO + TCGAbiolinks para TCGA-SKCM
```

- GEO: paquete [`GEOquery`](https://bioconductor.org/packages/GEOquery/) (acceso mayo 2026)
- TCGA: paquete [`TCGAbiolinks`](https://bioconductor.org/packages/TCGAbiolinks/) (acceso mayo 2026)

Los resultados derivados (tablas CSV) se guardan en `resultados/` para permitir la revisión del análisis sin necesidad de reejecutar la descarga de datos.

### Entorno R

Ejecutar `environment.R` (raíz del repositorio) para verificar e instalar los paquetes necesarios y guardar el `sessionInfo()` completo.

### Paquetes principales

| Paquete | Versión | Uso |
|---|---|---|
| limma | ≥ 3.54 | Análisis diferencial (lmFit + eBayes; voom cuando aplica) |
| survival | ≥ 3.5 | Modelos de Cox y curvas de Kaplan-Meier |
| clusterProfiler | ≥ 4.6 | ORA sobre Gene Ontology (GO-BP) |
| org.Hs.eg.db | ≥ 3.16 | Conversión Ensembl → Entrez ID |
| SummarizedExperiment | ≥ 1.28 | Contenedor de datos ómicos |
| GEOquery | ≥ 2.66 | Descarga de datos GEO |
| TCGAbiolinks | ≥ 2.26 | Descarga de datos TCGA |

---

## Referencia del diseño

El diseño discovery-validación-sensibilidad adoptado separa explícitamente las cohortes por tejido, plataforma y tipo de tratamiento para evitar la sobrestimación del rendimiento predictivo. Esta arquitectura es coherente con las recomendaciones metodológicas de la literatura para análisis multi-cohorte en oncología.

**Referencias clave:**
- Hugo et al. (2016) *Cell* 165:35–44 — GSE78220; descripción del fenotipo IPRES
- Zaretsky et al. (2016) *NEJM* 375:819–829 — Mutaciones JAK1/JAK2 y resistencia a pembrolizumab
- Riaz et al. (2017) *Cell* 171:934–949 — GSE91061; biopsias pre/on-treatment con nivolumab

---

## Cita

```
Salmerón Fructuoso, S. (2026). Identificación de biomarcadores transcriptómicos pronósticos 
y predictivos de respuesta a inmunoterapia en melanoma mediante análisis bioinformático 
integrativo. TFM, Máster en Bioinformática y Bioestadística, UOC.
https://github.com/Soniasalme/TFM_MELANOMA_INMUNOTERAPIA
```

---

*Licencia: CC BY-NC-ND 3.0 ES — [creativecommons.org/licenses/by-nc/3.0/es](https://creativecommons.org/licenses/by-nc/3.0/es)*
