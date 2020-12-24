# Trueblocks Analytics
## Rscripts supporting filemaker pro demo

Example command line use (use from project working directory):

```
Rscript -e "rmarkdown::render('output.Rmd'), params = list(\
    filepath = 'PATH_TO_DATA', \
    address = 'YOUR_ADDRESS', \
    name = 'NAME_OF_ACCOUNT' \
  )"
open output.html
```

An example using real data:

```
Rscript -e "rmarkdown::render('output.Rmd', params = list(\
    filepath = 'data/TheButton-0x2b0ec0993a00b2ea625e3b37fcc74742f43a72fe.csv', \
    address = '0x2b0ec0993a00b2ea625e3b37fcc74742f43a72fe', \
    name = 'The Button' \
  ))"
open output.html
```

The shell script `wrangle` is used to add a header row to the exported data. I can't figure out how to do this inside of FileMaker Pro.
This script is called directly from FileMaker Pro. It uses the account name and address to build a file called `output.csv` in the `./data/` folder. The 'R' script always reads from `output.csv`.

example wrangle use:

```
bash wrangle.sh AragonDreamDAOParty 0xecbc1cf6e45aada03cf557cfd20f85be9b29327d data/AragonDreamDAOParty-0xecbc1cf6e45aada03cf557cfd20f85be9b29327d.csv

bash wrangle.sh EtherumTipJar 0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359 data/EtherumTipJar-0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359.csv
```

```
name=$1
address=$2
path=$3

cd $path

echo "Processing: ----- $name --- $address -----------------"
cat "data/header.csv"     | tr '\r' '\n' >data/output.csv
cat "data/$name-$address.csv" | tr '\r' '\n' | sed 's/ PM//g' | sed 's/ AM//' | sed 's/invocation/call/' >>data/output.csv

Rscript -e "rmarkdown::render('output.Rmd', params = list(filepath = 'data/output.csv', address = '$address', name = '$name' ))"
open output.html

```

**Other Ideas:**

- see WHERE on a contract your activity took place. E.g. line chart of activity on a contract, with red dots on your transactions. Would require a different script with "highlighted account" parameter.

(KEEP THE IDEAS COMING)
