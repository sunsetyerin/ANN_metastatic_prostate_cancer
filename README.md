Metastatic Prostate Cancer Subtype Prognosis with Deep Learning 
===================================================

## 1. Metastatic Prostate Cancer

- The second leading cause of cancer deaths among US men
- About 50% of men diagnosed with local prostate cancer will get metastatic cancer during their lifetime 
- Finding cancer early and treating it can lower that rate

![image](https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/9244ec4d-c0cd-4bf4-999f-17904bf00cd9)

## 2. Data Source

- Genomic correlates of clinical outcome in advanced prostate cancer
- Abida, W. et al. (2019). Genomic correlates of clinical outcome in advanced prostate cancer. 
Proceedings of the national academy of sciences, 116 (23), s. 11428–11436. doi:10.1073/pnas.1902651116
[paper link](https://pubmed.ncbi.nlm.nih.gov/31061129/)

## 3. Data Description

- Androgen receptor signaling inhibitor (ARSI; abiraterone or enzalutamide)
- RB1 alteration was with poor survival
- RB1, AR, and TP53 alterations were associated with a shorter time on treatment with an ARSI
- RB1, AR, and TP53

<img width="388" alt="image" src="https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/7a896d68-35a5-4093-9eb6-377ad0428bf2">

## 4. Gleason Score

Prostate Cancer is classified by the Gleason Score.\
A Prostate Cancer Gleason Score or Grade helps to determine how aggressively the prostate cancer is likely to behave.\
The score will help classify the cancer by grading how quickly it it is likely to grow.\
The score also is a an indicator in how likely it is to spread outside of the prostate gland.

<img width="1167" alt="image" src="https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/05d94535-b4a6-49c1-865f-b8ee5344610b">

## 5. Guppy Basecall

Oxford Nanopore Technologies apparels uses `MinKNOW` software to basecall
reads in realtime, at the expense of the production of the event table
(formerly produced by `Albacore`). `Albacore` is discontinued and `Guppy`
is currently favored. It can produce a move table during basecall that is
similar to the deprecated event table (make sure to use `--fast5_out`).
`TailfindR` requires one of those tables.

Download available [here](https://community.nanoporetech.com/downloads).

Current configs are using an installation available to dlhost01 & dlhost03.
`/opt/ont-guppy_3.2.2/bin/guppy_basecaller`

## 6. TailfindR

`TailfindR` is designed to be supplied with a single directory containing all
the `.fast5` files. It supports parallelization by specifying the number of
cores to attribute to the `TailfindR` job. However, it was designed and tested
with MinIONs output files and I noticed that it doesn't scale well to a full
PromethION flowcell. The first large usage of `TailfindR` on gphost04 using the
sequencing run of the COLO829 cell line with 1563 `.fast5` files of ~4000 reads
(~6.25M reads) took 1.5 weeks to process all files and failed to produce the
compilation of the results after another 2 weeks.

The chosen workaround to address the issue is to generate temporary directories
each containing a softlink towards a single (or few) `.fast5` file(s) (see
`rule tailfindr_butler`). A `TailfindR` job is then generated for each
temporary directories. Numerous `TailfindR` jobs should be submitted to a
cluster such as `numbers` through `snakemake`.

## 7. Flair

`Flair` is a workflow in itself and requires its own environment to run. Both
the scripts used for direct_rna analysis and environment `.yaml` files are
provided in the `flair` submodule.

Unlike `TailfindR` the input is a single `.fast5` which prompts the need for
catenation of the multiple 4000 reads `.fast5` produced by `Guppy`. 

## 8. Albacore

`Albacore` is a deprecated basecaller that was discontinued by Oxford Nanopore
Technologies to the benefit of the currently maintained `Guppy`. It is included
to this workflow as a requirement for `EpiNano` m6A caller which relies on the
basecall errors of `Albacore` to assign methylated sites.

`EpiNano` states that it requires
[Albacore v2.1.7](https://github.com/enovoa/EpiNano#considerations-when-using-this-software),
to provide accurate prediction. This version is unavailable. The community only
have access to `Albacore v2.3.4`.
[link to Nanoporetech community](https://community.nanoporetech.com/downloads)

*NOTE* `Albacore` is used along with the multiread `.fast5` wrapper available
via the `seamlessf5` package.

## 9. EpiNano

The current version of `EpiNano` allows m6A sites calling at the genomic
position level. The calling at read level is
[under development](https://github.com/enovoa/EpiNano#considerations-when-using-this-software).
