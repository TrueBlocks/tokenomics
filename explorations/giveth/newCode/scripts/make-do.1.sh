#!/usr/bin/env bash

echo "Making ./scripts/do."$1".sh..."
echo "#!/usr/bin/env bash" >tmp-file ; \
    echo "" >>tmp-file ; \
    giveth data eligible --round $1 --fmt txt | \
        grep 0x | \
        sort -k 7 | \
        cut -f7,8,9 | \
        sed 's/^/chifra transactions --source --account_for /' | \
        tr '\t' '|' | \
        sed 's/|/ /' | \
        sed 's/|/ --chain /' >>tmp-file ; \
    mv tmp-file scripts/do.$1.sh ; \
    chmod uog+x scripts/do.$1.sh
