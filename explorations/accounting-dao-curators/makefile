all:
#	@cd /Users/jrush/Development/trueblocks-core/build/ ; make ; cd - >/dev/null 
#2>&1
	@cd ../accounting ; make ; cd - >/dev/null 
#2>&1
	make data

data:
#	@cd ../accounting ; go test ./... ; cd -  >/dev/null 
#2>&1
	@mkdir -p output/recons output/logs
	@rm -fR output/**/*.csv

	@echo "Testing stats..."
	@accounting stats.counter total average max min --nocolor >output/stats.csv 
#2>/dev/null

	@echo "Testing counters..."
	@accounting by_asset --nocolor >output/recons/by_asset.csv 
#2>/dev/null
	@accounting by_function --nocolor >output/recons/by_function.csv 
#2>/dev/null

	@echo "Testing groupers..."
	@accounting by_priced --nocolor >output/recons/by_priced.csv 
#2>/dev/null
	@accounting by_address --nocolor >output/recons/by_address.csv 
#2>/dev/null
	@accounting statements --nocolor usd >output/recons/recons.csv 
#2>/dev/null
	@accounting senders --nocolor usd >output/recons/senders.csv 
#2>/dev/null
	@accounting recipients --nocolor usd >output/recons/recipients.csv 
#2>/dev/null
	@accounting pairings --nocolor usd >output/recons/pairings.csv 
#2>/dev/null

	@echo "Token summaries..."
	@accounting topic_only --nocolor >output/logs/topic_only.csv 
#2>/dev/null
	@accounting contract_only --nocolor >output/logs/contract_only.csv 
#2>/dev/null
	@accounting contract_last --nocolor >output/logs/contract_last.csv 
#2>/dev/null
	@accounting contract_first --nocolor >output/logs/contract_first.csv 
#2>/dev/null
	@accounting extract --nocolor >output/logs/logs.csv 
#2>/dev/null

	@echo "Exporting..."
	@accounting profit_and_loss monthly units --verbose --verbose --nocolor >output/recons/p_and_l.csv

	@echo "Excelizing..."
	@accounting excel

tidy:
	@cd ../accounting ; make tidy ; cd - >/dev/null 
#2>&1

clean:
	@rm -fR output raw summary
	@mkdir -p output/logs output/recons raw/txs raw/recons raw/logs summary
#	@cat doAll.sh | grep -v doOne >x ; cat x >doAll.sh ; rm -f x
#	@cat doSome.sh | grep -v doOne >x ; cat x >doSome.sh ; rm -f x
