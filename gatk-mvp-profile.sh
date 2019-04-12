##---------------------------------------------------------------
# 	Google Cloud Configuration for GATK-MVP
# 					April 15, 2019
#					by Jina Song
##---------------------------------------------------------------

# Images and Pipeline files for running GATK-MVP dsub jobs

export mvp_fastqtoubam_image="broadinstitute/gatk:4.1.0.0"
export mvp_gatk_image="jinasong/wdl_runner:latest"

# Your Google Cloud environment variables for running GATK-MVP dsub jobs

export mvp_project="your-projectID"
export mvp_region="your-region"
export mvp_bucket="your-bucket"

