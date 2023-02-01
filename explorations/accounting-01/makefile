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
	@accounting statements --nocolor units >data/statements.csv 2>/dev/null
	@accounting senders --nocolor units >data/senders.csv 2>/dev/null
	@accounting recipients --nocolor units >data/recipients.csv 2>/dev/null
	@accounting pairings --nocolor units >data/pairings.csv 2>/dev/null
	@echo "Exporting..."
	@accounting profit_and_loss daily units --verbose --verbose --nocolor >data/p_and_l.csv
	@echo "0x1f9840a85d5af5bf1d1762f925bdaddc4201f984" >filter.csv
	@accounting profit_and_loss daily units --verbose --verbose --nocolor >data/p_and_l_uni.csv
	@echo "0x77777feddddffc19ff86db637967013e6c6a116c" >filter.csv
	@accounting profit_and_loss daily units --verbose --verbose --nocolor >data/p_and_l_torn.csv
	@rm -f filter.csv

tidy:
	@cd ../accounting ; make tidy ; cd - >/dev/null 2>&1

data:
	@make all
	@./buildOne.sh annually
	@./buildOne.sh monthly
	@./buildOne.sh daily
	@./buildOne.sh blockly
