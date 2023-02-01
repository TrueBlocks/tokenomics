all:
#	@cd /Users/jrush/Development/trueblocks-core/build/ ; make ; cd - >/dev/null 2>&1
	@cd ../accounting ; make ; cd - >/dev/null 2>&1

test:
#	@cd ../accounting ; go test ./... ; cd -  >/dev/null 2>&1
	@make
	@rm -fR data/*.csv
	@mkdir -p data
	@echo "Testing stats..."
	@accounting stats.counter total average max min --nocolor >data/stats.csv 2>/dev/null
	@echo "Testing counters..."
	@accounting by_asset --nocolor >data/by_asset.csv 2>/dev/null
	@accounting by_function --nocolor >data/by_function.csv 2>/dev/null
	@echo "Testing groupers..."
	@accounting by_priced --nocolor >data/by_priced.csv 2>/dev/null
	@accounting by_address --nocolor >data/by_address.csv 2>/dev/null
	@accounting statements --nocolor usd >data/statements.csv 2>/dev/null
	@accounting senders --nocolor usd >data/senders.csv 2>/dev/null
	@accounting recipients --nocolor usd >data/recipients.csv 2>/dev/null
	@accounting pairings --nocolor usd >data/pairings.csv 2>/dev/null
	@echo "Exporting..."
	@accounting profit_and_loss --monthly units --verbose --verbose --nocolor >data/p_and_l.csv

tidy:
	@cd ../accounting ; make tidy ; cd - >/dev/null 2>&1

data:
	@make all
	@./buildOne.sh annually
	@./buildOne.sh monthly
	@./buildOne.sh daily
	@./buildOne.sh blockly
