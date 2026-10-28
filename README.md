# WheatNLRatlas

WheatNLRatlas contains analysis scripts for constructing reference-indexed NLR detection matrices from wheat resequencing alignment coverage, and for summarizing and visualizing these matrices.

**Status: repository preparation draft.** Seven scripts have been recovered from the supplied V1.0 source-code document. 

## Scope

The accompanying software manual describes extracting reads unmapped to Chinese Spring, mapping those reads independently to multiple reference assemblies, annotating NLR intervals, calculating alignment coverage, applying count and coverage thresholds, and constructing a binary detection matrix. The source document supplies only downstream Python and R scripts. Upstream batch scripts, original input datasets and exact software versions were not supplied.

A positive call indicates that a reference-indexed NLR interval meets the specified mapping-coverage criteria. A negative call denotes non-detection under those criteria, not independently validated physical gene absence. Reference-indexed IDs are not demonstrated orthology groups or nonredundant biological genes across assemblies.

## Contents

| File | Purpose |
| --- | --- |
| `scripts/original/WheatNLRatlas.5.2.R` | Explore alignment-count and interval-coverage distributions |
| `scripts/original/WheatNLRatlas.6.1.py` | Extract sample-specific NLR identifiers from filtered BED tables |
| `scripts/original/WheatNLRatlas.6.3.py` | Build the sample-by-NLR binary matrix |
| `scripts/original/WheatNLRatlas.7.1.py` | Calculate row and column totals |
| `scripts/original/WheatNLRatlas.7.2.py` | Add sample and reference metadata |
| `scripts/original/WheatNLRatlas.7.3.R` | Plot annotated heatmaps |
| `scripts/original/WheatNLRatlas.7.4.R` | Plot frequency histograms |
| `docs/WORKFLOW.md` | Workflow, input contracts and execution notes |
| `docs/DEPENDENCIES.md` | Dependency inventory and version-recording instructions |

## Running the scripts

Read [docs/WORKFLOW.md](docs/WORKFLOW.md) before execution. The original scripts resolve paths relative to the current working directory and some append to output files. Use a fresh working directory for each run. No one-command installation or full-data reproduction has been validated.

The Python scripts import only the standard library. The R scripts require the packages listed in [docs/DEPENDENCIES.md](docs/DEPENDENCIES.md). The provided R implementation uses multicore execution intended for Unix-like systems; Windows requires adaptation or a Linux environment.

## Data and reproducibility

No original sequencing reads, BAM files, reference genomes, sample metadata, or publication figures are included. Add repository accession numbers, reference assembly versions, checksums and small permitted test inputs before release.

## Author and contact

Author: Fei He  
Email: [fhe@genetics.ac.cn]
Repository: https://github.com/zhaocaihong21/WheatNLRatlas

## Citation and licensing

Citation information will be added when available.

No software reuse license has been specified for this repository.
Third-party software remains subject to its respective licenses.

## Citation and licensing

Author names, public repository URL, manuscript citation, release version, and reuse license remain to be confirmed by the project maintainers. Complete `templates/CITATION.cff.template` and place the resulting `CITATION.cff` at the repository root before release. Do not cite placeholder values. No software reuse license has been selected by this preparation step; retain third-party software under its own terms.
