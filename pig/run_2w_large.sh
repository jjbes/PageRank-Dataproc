#!/bin/bash
gcloud dataproc clusters create cluster-2w --enable-component-gateway --region europe-west1 \
--zone europe-west1-c --master-machine-type n1-standard-4 --master-boot-disk-size 500 --num-workers 2 \
--worker-machine-type n1-standard-4 --worker-boot-disk-size 500 --image-version 2.0-debian10 --project x3ia020-pagerank

gsutil cp pagerank_large.py gs://x3ia020-pagerank

gsutil rm -rf gs://x3ia020-pagerank/out

gcloud dataproc jobs submit pig --region europe-west1 --cluster  cluster-2w -f gs://x3ia020-pagerank/pagerank_large.py

#gsutil cat gs://x3ia020-pagerank/out/pagerank_data_3/part-r-00000

gcloud dataproc clusters delete cluster-2w --region europe-west1