#!/usr/bin/env bash

echo "#!/usr/bin/env bash" >$1.sh
echo "" >>$1.sh
seq -f "%f" 0 $2 15000000 | cut -f1 -d. | sed 's/$/.0/' | sed 's/^/.\/bin\/chifra-'$1' receipts --no_header \$@ /' >>$1.sh
