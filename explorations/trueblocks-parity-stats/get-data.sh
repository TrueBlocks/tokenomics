scp -r -P 36963 wildmolasses@108.36.208.213:~/4tb-data/scraper/logs/block-scrape-data.log ./
scp -r -P 36963 wildmolasses@108.36.208.213:~/4tb-data/scraper/logs-2018-12-23-12-50-00/block-scrape-data.log.gz ./
mv block-scrape-data.log block-scrape-data-acct-addr.log
scp -r -P 36963 wildmolasses@108.36.208.213:~/4tb-data/scraper/logs-2018-12-23-12-50-00/block-scrape-data.log ./
mv block-scrape-data.log block-scrape-data-2.log
gunzip block-scrape-data.log.gz
scp -P 36963 wildmolasses@108.36.208.213:~/4tb-data/parity-sync-logs/* ./data/
