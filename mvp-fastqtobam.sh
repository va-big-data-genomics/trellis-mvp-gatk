#!/bin/bash

###############################################################
# 		FASTQ to UBAM for MVP samples	
#					
#					- 12/05/2018	
#					- Jina
###############################################################

## General use dynamic variables
export date_stamp=$(date "+%Y%m%d")

# Path to dsub virtual env activator 
export dsub_venv="/Users/jinasong/Work/MVP/dsub/dsub_libs/bin/activate/dsub-libs/bin/activate"

# Environment metadata for running MVP dsub jobs
export mvp_project="gbsc-gcp-project-mvp"
export mvp_fastq_bucket="gbsc-gcp-project-mvp-group/jina-gatk-mvp/fastq"
export mvp_ubam_bucket="gbsc-gcp-project-mvp-group/jina-gatk-mvp/ubam"
export mvp_zone="us-*"

## 0. check that environment variables have been loaded correctly
echo "Date stamp: ${date_stamp}"
echo "Project: ${mvp_project}"
echo "Fastq_Bucket: ${mvp_fastq_bucket}"
echo "Ubam_Bucket: ${mvp_ubam_bucket}"
echo "Zone: ${mvp_zone}"

## 1. Run FastQtoSam

#* For larger fastq files (like over 30 GB), use the second like command including -TMP_DIR and --MAX_RECORDS_IN_RAM options, and change the disk-size to 500

dsub \
    --zones "${mvp_zone}" \
    --project ${mvp_project} \
    --logging gs://${mvp_ubam_bucket}/${date_stamp} \
    --image broadinstitute/gatk:latest \
    --min-ram 8 \
    --min-cores 1 \
    --disk-size 200 \
    --input FASTQ_1=gs://${mvp_fastq_bucket}/SHIP5017451/SHIP5017451_0_R1.fastq.gz \
    --input FASTQ_2=gs://${mvp_fastq_bucket}/SHIP5017451/SHIP5017451_0_R2.fastq.gz \
    --output UBAM=gs://${mvp_ubam_bucket}/SHIP5017451_0.unmapped.bam \
    --command '/gatk/gatk --java-options "-Xmx8G -Djava.io.tmpdir=bla" FastqToSam -F1 ${FASTQ_1} -F2 ${FASTQ_2} -O ${UBAM} -RG SHIP5017451_0 -SM SHIP5017451 -PL ILLUMINA' 
    #--command '/gatk/gatk --java-options "-Xmx8G -Djava.io.tmpdir='pwd'/tmp" FastqToSam -TMP_DIR 'pwd'/tmp -F1 ${FASTQ_1} -F2 ${FASTQ_2} -O ${UBAM} -RG NA12878 -SM NA12878 -PL ILLUMINA -MAX_RECORDS_IN_RAM 10000000' 
