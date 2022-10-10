#!/bin/bash
gsutil cp ../small_page_links.nt gs://x3ia020-pagerank

gsutil cp pagerank-notype.py gs://x3ia020-pagerank

gsutil rm -rf gs://x3ia020-pagerank/out/pyspark_pagerank_data

gcloud dataproc clusters create cluster-1w --enable-component-gateway --region europe-west1 \
--zone europe-west1-c --master-machine-type n1-standard-4 --master-boot-disk-size 500 --single-node \
--worker-machine-type n1-standard-4 --worker-boot-disk-size 500 --image-version 2.0-debian10 --project x3ia020-pagerank

gcloud dataproc jobs submit pyspark --region europe-west1 --cluster cluster-1w gs://x3ia020-pagerank/pagerank-notype.py  -- gs://x3ia020-pagerank/small_page_links.nt 3

gcloud dataproc clusters delete cluster-1w --region europe-west1

