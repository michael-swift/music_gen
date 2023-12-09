#!/bin/bash

#name shell variables for calling in snakemake and sbatch
DATETIME=$(date "+%Y_%m_%d_%H_%M_%S")
RESTART=0

SNAKEFILE=Snakefile.smk
TARGET=''
#CLUSTER_CONFIG=config/slurm_config.yaml

#Snakemake config
NJOBS=200
WAIT=120

snakemake -s $SNAKEFILE $TARGET --use-conda --keep-target-files --rerun-incomplete -n -r --keep-going