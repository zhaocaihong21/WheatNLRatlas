# Workflow and input contracts

This document describes the recovered workflow, not an already validated end-to-end runner. Commands for downstream steps must be launched from a fresh data working directory, replacing `/path/to/WheatNLRatlas` with the downloaded repository path.

## Upstream steps to recover

1. Recover the exact raw-read quality-control, Chinese Spring BWA mapping and unmapped-read extraction commands, including pair handling.
2. Record the final reference list with accession, version, download URL, checksum and numeric assembly ID. Resolve the differing reference counts in the materials.
3. Recover NLR annotation and BED conversion, including any reference-locus redundancy removal.
4. Recover multi-reference mapping and paired-alignment filtering, with exact software versions and options.
5. Verify the coverage calculation against the actual study outputs before using it for threshold selection.

The manual gives Bowtie2 `--score-min L,0,-0.03 --no-mixed --no-discordant`; preserve the actual scoring settings in the methods. A score threshold is not a fixed percentage sequence identity.

For BEDTools versions >=2.24.0, the following is a *proposed current-version command to verify*, not a recovered historical command:

```bash
bedtools coverage -a reference.nlr.bed -b sample.sorted.bam > sample_coverage_001.bed
```

Use precisely four columns in the input BED for the eight-column contract below. Check the original BEDTools version before replacing the manual's `-abam BAM -b BED` command. Retain zero-count intervals for bookkeeping; decide separately whether they were excluded for density estimation in the original analysis. Alignment counts are not automatically counts of distinct paired fragments.

## Coverage table

Tab-delimited, no header, one row per NLR interval:

| Column | Meaning |
| --- | --- |
| 1 | Chromosome / sequence identifier |
| 2 | BED start, zero-based |
| 3 | BED end, exclusive |
| 4 | NLR identifier |
| 5 | Number of overlapping alignment records/features |
| 6 | Number of interval bases covered at least once |
| 7 | Interval length |
| 8 | Covered fraction, column 6 / column 7 |

Column 6 is not the sum of aligned read bases over all reads. Columns 2–3 must use the same reference coordinate system as the BAM. For GFF-to-BED conversion, confirm whether the source is one-based inclusive before subtracting one from the start.

## Downstream execution order

The recovered scripts use count `89` and coverage `0.8890`, except step 7.4 which uses older-looking filenames. These numbers are study-specific parameters requiring confirmation, not universal NLR detection criteria.

1. Put nonempty eight-column coverage files under `21.out_bedtools_coverage_equal/<sample>/`. Step 5.2 reads column 5 and column 8 from files in these subdirectories. Resolve zero-count and insufficient-data handling before running:

```bash
Rscript /path/to/WheatNLRatlas/scripts/original/WheatNLRatlas.5.2.R
```

This script explores peaks and troughs; it does not automatically write or validate a classification threshold.

2. Once the study threshold is confirmed, filter each coverage file using the manual's rule:

```bash
awk '$5 >= 89 && $8 >= 0.8890' input_coverage.bed > output_filtered.bed
```

Create the real output parent directories first. Organize filtered files as `31.out_bedtools_filter_readcountgt89_nlrcovgt0.8890_equal/<sample>/<sample>_coverage_<assembly>.bed`. Despite `gt` in directory names, the documented rule is inclusive `>=`.

3. Supply `00.Name_498var.txt` with one sample identifier per line and no header. Create `01.out_var_nlrname_count89cov0.8890/` in the fresh working directory. Run:

```bash
python3 /path/to/WheatNLRatlas/scripts/original/WheatNLRatlas.6.1.py
cat 01.out_var_nlrname_count89cov0.8890/* | sort -V | uniq > 02.name_allnlr_count89cov0.8890_uniq.txt
python3 /path/to/WheatNLRatlas/scripts/original/WheatNLRatlas.6.3.py
python3 /path/to/WheatNLRatlas/scripts/original/WheatNLRatlas.7.1.py
```

The concatenation path above matches the script; the manual has an extra underscore in this path. `sort -V` requires a compatible sort implementation such as GNU sort on Linux.

The constructed locus identifier is `<assembly>_<nlr_ID>_<BED_start_plus_1>`. Step 6.3 takes the text before the first underscore in each sample file name as the sample ID, so sample IDs containing underscores are unsafe without code changes. Assembly identifiers must also match the naming rules and metadata exactly, preserving leading zeros.

The output matrix is `03.out_Rmap_498wheat_count89cov0.8890.txt`, with header `variant` followed by NLR IDs. The universe of columns is the union of detected IDs, not every annotated locus in every reference. The filename does not prove that there are 498 rows. Step 7.1 writes per-sample and per-NLR totals in two `04.out_*.txt` files.

4. Supply real metadata before step 7.2. The script reads these files without skipping headers:

| File | Fields required by code |
| --- | --- |
| `00.Info_Ling508.txt` | Tab-delimited; column 2 joins sample ID; columns 1, 3 and 4 are appended |
| `00.Code_161Ref_Species_Genome_GenePools_Genus_NLRsource.txt` | Tab-delimited; column 1 joins assembly ID; columns 2, 3, 6 and 7 are appended |

```bash
python3 /path/to/WheatNLRatlas/scripts/original/WheatNLRatlas.7.2.py
```

For heatmap compatibility, verify sample metadata outputs as sample ID, NLR count, source ID, type, new ID; and NLR metadata outputs as NLR ID, sample count, assembly annotation, species, genus, source. These semantic labels are inferred from step 7.3 and require comparison with the actual tables.

5. Step 7.3 expects `03.2.out_Rmap_498wheat_count89cov0.8890_newid.txt`; its generation is missing. Recover the old-to-new sample mapping and reorder both sample and locus metadata by matrix IDs before drawing. Do not merely rename the step 6.3 output. Step 7.4 must also be reconciled with the final threshold and six-column NLR metadata output. Once resolved and verified:

```bash
Rscript /path/to/WheatNLRatlas/scripts/original/WheatNLRatlas.7.3.R
Rscript /path/to/WheatNLRatlas/scripts/original/WheatNLRatlas.7.4.R
```

These final commands currently describe the intended order; they are not a claim that the supplied draft runs without changes.

## Interpretation

The matrix is based on read mapping and thresholded detection. Low coverage, paralogous mapping and shared loci across references affect interpretation. Neither physical absence, introgression nor a specific resistance allele is established by the binary call alone. Document the study's validation and locus redundancy policy separately.
