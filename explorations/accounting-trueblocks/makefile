all:
#	@cd /Users/jrush/Development/trueblocks-core/build/ ; make ; cd - >/dev/null 2>&1
	@cd ../accounting ; make ; cd - >/dev/null 2>&1
	make data

data:
#	@cd ../accounting ; go test ./... ; cd -  >/dev/null 2>&1
	@rm -fR output/*.csv
	@mkdir -p output
	@echo "Testing stats..."
	@accounting stats.counter total average max min --nocolor >output/stats.csv 2>/dev/null
	@echo "Testing counters..."
	@accounting by_asset --nocolor >output/by_asset.csv 2>/dev/null
	@accounting by_function --nocolor >output/by_function.csv 2>/dev/null
	@echo "Testing groupers..."
	@accounting by_priced --nocolor >output/by_priced.csv 2>/dev/null
	@accounting by_address --nocolor >output/by_address.csv 2>/dev/null
	@accounting statements --nocolor usd >output/recons.csv 2>/dev/null
	@accounting senders --nocolor usd >output/senders.csv 2>/dev/null
	@accounting recipients --nocolor usd >output/recipients.csv 2>/dev/null
	@accounting pairings --nocolor usd >output/pairings.csv 2>/dev/null
	@accounting by_topic --nocolor >output/topics.csv 2>/dev/null
	@echo "Exporting..."
	@accounting profit_and_loss monthly units --verbose --verbose --nocolor >output/p_and_l.csv

tidy:
	@cd ../accounting ; make tidy ; cd - >/dev/null 2>&1

clean:
	@rm -fR output raw summary
	@mkdir -p output raw/txs raw/recons raw/logs summary
#	@cat doAll.sh | grep -v doOne >x ; cat x >doAll.sh ; rm -f x
#	@cat doSome.sh | grep -v doOne >x ; cat x >doSome.sh ; rm -f x
