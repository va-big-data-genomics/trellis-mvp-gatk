# GATK for MVP

GATK used to process MVP data on Google Cloud Platform(GCP) without Firecloud

## Background

This GATK process was generated as part of the Department of Veteran's Affairs Million Veteran's Program. As part of this program, whole-genome sequencing was performed on genetic samples. Sequencing is done by Personalis. Results which include fastq files are delivered to Stanford Google Cloud Storage bucket. 

This GATK process is used for variant-calling of the results. This GATK pipeline is based on the five-dollar-genome-analysis-pipeline, the Broad Institute was originally designed to run on the FireCloud platform on GCP. The five-dollar-genome-analysis-pipeline uses a unaligned bam as input and gvcf as variant calling output format. The variant-calling for MVP data, on the other hand, requires more generic process without FireCloud platform and uses a fastq file as input and a vcf file as output. This GATK process provides additional steps and the modified wdl file to meet the needs of MVP.

For more information about the five-dollar-genome-analysis-pipeline, you can refer the links as below.  
* five-dollar-genome-analysis-pipeline : https://github.com/gatk-workflows/five-dollar-genome-analysis-pipeline

## Introduction

The GATK process is launched with Dsub which can run a simple batch job with Docker. We use two docker images in Dockerhub: 

* GATK 4.1.0.0 docker image for Picard tool ( broadinstitute/gatk:4.1.0.0 )
* wdl_runner docker image for Cromwell which can run the pipeline file using wdl and other required software packages ( jinasong/wdl_runner:latest )

## Prerequisites

1. Python 2.7

2. Dsub

	Dsub is a tool to run batch scripts in Google Cloud. You can install Dsub from PyPl or from github. 

	https://github.com/DataBiosphere/dsub

3. Google cloud SDK

	Google cloud SDK is a set of tools for Googld Cloud Platform. You can install the right SDK version for your Operating System. 

	https://cloud.google.com/sdk/docs/quickstarts


## Getting Started

### Setting up the environment for GATK-MVP

1. Clone the gatk-mvp repo

	```
	git clone https://github.com/StanfordBioinformatics/gatk-mvp.git
	
	```

2. Activate dsub

	```
	source dsub_libs/bin/activate
	```

3. Setup Google Cloud configration

	Edit `gatk-mvp-profile.sh` with your Google Cloud setting, such as project ID, region, and bucket.

	```
	export mvp_project="your-projectID"
	export mvp_region="your-region"
	export mvp_bucket="your-bucket"
	```
	Source this shell file with Google Cloud environment

	```
	source gatk-mvp-profile.sh
	```

### Running FastqToSam 

If you are using an unaligned bam file format as input, skip this sub-section and go to Running GATK section 

If your input file ends fastq or fastq.gz, you should start with the conversion step from a fastq file to an unaligned bam file using Picard's FastqToSam tool. We use the Picard tool which is integrated in GATK 4.1.0.0 version. 

For more information about FastqToSam, you can refer the links as below.  
* FastqToSam : https://software.broadinstitute.org/gatk/documentation/tooldocs/4.1.0.0/picard_sam_FastqToSam.php


1. Edit the `dsub_run_fastqtobam` file with the sample name, readgroup, and platform information for your fastq samples.
	```
	sample="[YOUR-SAMPLE]"
	readgroup="[YOUR-READGROUP]"
	platform="[YOUR-PLATFORM]"

	fastq1="[YOUR-FASTQ-1]"
	fastq2="[YOUR-FASTQ-2]"
	ubam="[YOUR-UBAM]"
    ```
    Change `[YOUR-FASTQ-1]`, `[YOUR-FASTQ-2]`, and `[YOUR-UBAM]`  to the input fastq file locations and the output ubam file location in your Google Cloud bucket.

2. Run FastqToSam

	```
	./dsub_run_fastqtoubam
	```

## Running GATK 

1. Make the variable with the sample name
	```
	export sample="[YOUR-SAMPLE-NAME]"
	```

2. Edit `mvp.hg38.inputs.json` file with your sample name and your unaligned bam file locations.
	```
	"##_COMMENT2": "SAMPLE NAME AND UNMAPPED BAMS - read the README to find other examples.",
    "germline_single_sample_workflow.sample_name": "[YOUR-SAMPLE-NAME]",
    "germline_single_sample_workflow.base_file_name": "[YOUR-SAMPLE-NAME]",
    "germline_single_sample_workflow.flowcell_unmapped_bams": ["[YOUR-UBAM1]","[YOUR-UBAM2]",...],
    "germline_single_sample_workflow.final_vcf_base_name": "[YOUR-SAMPLE-NAME]",
    ```
   Change the name of `mvp.hg38.inputs.json` file to `[YOUR-SAMPLE-NAME].hg38.inputs.json`
   ```
   mv mvp.hg38.inputs.json ${sample}.hg38.inputs.json
   ```

3. Upload GATK-MVP pipeline files and the json file containing your unaligned bam file locations to your Google Cloud bucket 
	```
	gsutil cp -r gatk-mvp-pipeline/ gs://${mvp_bucket}
	gsutil cp ${sample}.hg38.inputs.json gs://${mvp_bucket}/${sample}
	```

4. Run GATK

	```
	./dsub_run_gatk
	```
