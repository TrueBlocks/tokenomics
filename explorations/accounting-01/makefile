all:
#	@cd /Users/jrush/Development/trueblocks-core/build/ ; make ; cd - >/dev/null 2>&1
	@cd ../accounting ; make ; cd - >/dev/null 2>&1

test:
#	@cd ../accounting ; go test ./... ; cd -  >/dev/null 2>&1
	@make
	@rm -fR tests/working
	@mkdir -p tests/working tests/gold
	@echo "Testing stats..."
	@accounting stats.counter total average max min --nocolor >tests/working/stats.txt 2>/dev/null
	@echo "Testing counters..."
	@accounting by_asset --nocolor >tests/working/by_asset.txt 2>/dev/null
	@accounting by_function --nocolor >tests/working/by_function.txt 2>/dev/null
	@echo "Testing groupers..."
	@accounting by_priced --nocolor >tests/working/by_priced.txt 2>/dev/null
	@accounting by_address --nocolor >tests/working/by_address.txt 2>/dev/null
	@accounting statements --nocolor usd >tests/working/statements.txt 2>/dev/null
	@accounting senders --nocolor usd >tests/working/senders.txt 2>/dev/null
	@accounting recipients --nocolor usd >tests/working/recipients.txt 2>/dev/null
	@accounting pairings --nocolor usd >tests/working/pairings.txt 2>/dev/null
	@diff -r tests/working tests/gold

tidy:
	@cd ../accounting ; make tidy ; cd - >/dev/null 2>&1

data:
	@make all
	@./buildOne.sh annually
	@./buildOne.sh monthly
	@./buildOne.sh daily
	@./buildOne.sh blockly
