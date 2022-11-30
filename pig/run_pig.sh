#!/bin/bash

#--------------------------------------Data and scripts uploading--------------------------------------#

gsutil cp ../small_page_links.nt gs://x3ia020-pagerank

gsutil cp pagerank-pig.py gs://x3ia020-pagerank

gsutil cp pagerank-pig-large.py gs://x3ia020-pagerank

gsutil rm -rf gs://x3ia020-pagerank/out

#-------------------------------------------Clusters creation-------------------------------------------#

# 0 worker cluster creation
#
#gcloud dataproc clusters create cluster-x3ia020 --enable-component-gateway --region europe-west1 \
#--zone europe-west1-c --master-machine-type n1-standard-4 --master-boot-disk-size 500 --single-node \
#--worker-machine-type n1-standard-4 --worker-boot-disk-size 500 --image-version 2.0-debian10 --project x3ia020-pagerank

# 2 workers cluster creation
#
gcloud dataproc clusters create cluster-x3ia020 --enable-component-gateway --region europe-west1 \
--zone europe-west1-c --master-machine-type n1-standard-4 --master-boot-disk-size 500 --num-workers 2 \
--worker-machine-type n1-standard-4 --worker-boot-disk-size 500 --image-version 2.0-debian10 --project x3ia020-pagerank

# 4 workers cluster creation
#
#gcloud dataproc clusters create cluster-x3ia020 --enable-component-gateway --region europe-west1 \
#--zone europe-west1-c --master-machine-type n1-standard-4 --master-boot-disk-size 500 --num-workers 4 \
#--worker-machine-type n1-standard-4 --worker-boot-disk-size 500 --image-version 2.0-debian10 --project x3ia020-pagerank

#--------------------------------Launching Spark jobs on different datasets--------------------------------#

# Small Dataset
#
gcloud dataproc jobs submit pig --region europe-west1 --cluster  cluster-x3ia020 -f gs://x3ia020-pagerank/pagerank-pig.py

# Large Dataset 
#
#gcloud dataproc jobs submit pig --region europe-west1 --cluster  cluster-x3ia020 -f gs://x3ia020-pagerank/pagerank-pig-large.py


#---------------------------------------------Cluster deletion---------------------------------------------#

gcloud dataproc clusters delete cluster-x3ia020 --region europe-west1

