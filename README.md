# Results report
**3 iterations PageRank for small_page_links.nt**
| Workers | Pig (in seconds) | Pyspark (in seconds) | Pyspark with 10 partitions (in seconds) |
|---------|---------------|--------------------|--------------------|
| 0       | 176.168000221 | 35.802125453948975 | 37.417216062545776 |
| 2       | 162.499000072 | 36.92495846748352  | 39.87025451660156  |
| 4       | 168.486000061 | 30.144531726837158 | 31.06624746322632  |


**3 iterations PageRank for page_links_en.nt.bz2**
| Workers | Pig (in seconds) | Pyspark (in seconds) | Pyspark with 100 partitions (in seconds) |
|---------|---------------|--------------------|--------------------|
| 0       | 5802.1190002  | error (crashes around 3240) | TODO |
| 2       | 2835.23799992 | 2653.8885538578033 | 1906.3919332027435 |
| 4       | 2115.25399995 | 1725.1335825920105 | 1323.3430573940277 |

## EDIT 30/11/22: Added pyspark partitionning, refactoring and the following observations.

# Observations
The small dataset seems to show that pyspark is faster than pig. However conclusions cannot be made on the small dataset regarding both implementattions of pyspark.

Based on the larger dataset, the naive pyspark implement in in fact offering slighty better results than pig on 2 workers and noticeably better results on 4 workers. However, the 0 worker configuration doesn't seems to work with pyspark. 

Using pyspark with partitions optimization and caching, the results on the larger dataset are noticeably improved compared to the naive approach. This shows that pyspark's RAM writes is at a real advantage compared to Pig's disk writes on I/O intensive tasks. 

Number of partitions was not fully tested during this experiment due to long processing times but is probably another way to further improve those results. 
