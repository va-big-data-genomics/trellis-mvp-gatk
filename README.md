# gatk-fivedollar
GATK with five-dollar-genome-analysis-pipeline on GCP


## Prerequisites: 

1. java 
```
sudo apt-get install openjdk-8-jdk
```

2. google cloud SDK install 
          
    https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu


## Getting Started

* Clone the GATK-fivedollar repo

```
git clone https://github.com/StanfordBioinformatics/GATK-fivedollar.git
```

* Download cromwell in the GATK-fivedollar folder

```
wget https://github.com/broadinstitute/cromwell/releases/download/35/cromwell-35.jar
```

## (If needed) Converting fastq (or fastq.gz file) to ubam

* Install dsub

     https://github.com/DataBiosphere/dsub/blob/master/README.md 

* Activate dsub
```
source dsub/dsub_libs/bin/activate
```

* Run FastqToSam tool
We need these parameter to the run file as below.

$dsub_venv : your local path where dsub was installed  
$mvp_project : your google cloud project  
$mvp_fastq_bucket : google cloud bucket with your fastq files  
$mvp_ubam_bucket : google cloud bucket for your ubam file  
$FASTQ_1, $FASTQ_2 : input files  
$UBAM : output file  
RG : Read Group name  
SM : Sample Name  
 
```
chmod 755 mvp-fastqtoubam.sh
./mvp-fastqtoubam.sh
```

## Running GATK
```
chmod 755 run-gatk-fd
./run-gatk-fd
```


