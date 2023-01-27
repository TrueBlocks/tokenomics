all:
	@go mod tidy
	@go build -o ../accounting main.go && cd .. && ./accounting

test:
	@go test ./...
