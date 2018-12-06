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

## Converting fastq (or fastq.gz file) to ubam (*Only if the input file format is fastq or fastq.gz) 

* Install dsub

     https://github.com/DataBiosphere/dsub/blob/master/README.md 

* Activate dsub
```
source dsub/dsub_libs/bin/activate
```

* Run FASTQTOSAM tool

```
chmod 755 mvp-fastqtoubam.sh
./mvp-fastqtoubam.sh
```

## Running GATK
```
chmod 755 run-gatk-fd
./run-gatk-fd
```


