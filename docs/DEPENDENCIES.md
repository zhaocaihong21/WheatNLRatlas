# Dependencies

Exact versions used for the study were not provided. Do not describe this inventory as a locked or tested environment.

| Stage | Software |
| --- | --- |
| Initial Chinese Spring alignment and unmapped reads | BWA and SAMtools; exact extraction command missing |
| Multi-reference alignment | Bowtie2 and SAMtools |
| NLR annotation | Java, NLR-Annotator, NLR-Parser3, ChopSequence, MEME/MAST and the exact motif model |
| Coverage and filtering | BEDTools, awk, standard Unix tools |
| Steps 6.1, 6.3, 7.1, 7.2 | Python 3; standard library only; exact study version unknown |
| Step 5.2 | R: data.table, parallel, ggplot2, pracma |
| Step 7.3 | R: ComplexHeatmap, circlize; grid namespace is also used |
| Step 7.4 | R: ggplot2, dplyr, tidyr |

On the original analysis environment, record Python and R versions, `sessionInfo()`, `bowtie2 --version`, `samtools --version`, `bedtools --version`, `java -version`, and tool-specific version information for BWA and MEME/MAST. Record the exact NLR-Annotator release or commit, JAR checksums, motif-model checksum, operating system, and reference assembly accessions.

Only after comparison with the real study environment and a successful reproduction should maintainers supply a pinned `environment.yml` and/or `renv.lock`. No invented package versions or empty dependency file are included here. Python alone does not install the external bioinformatics tools.
