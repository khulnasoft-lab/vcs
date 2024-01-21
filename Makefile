GOLANGCI_LINT_VERSION?=1.45.0
GOLANGCI_LINT=/usr/local/bin/golangci-lint

$(GOLANGCI_LINT):
	curl -sSLO https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz
	shasum -a 256 golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz | grep "^${GOLANGCI_LINT_SHA256}  " > /dev/null
	tar -xf golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz
	sudo mv golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64/golangci-lint /usr/local/bin/golangci-lint
	rm -rf golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64*

.PHONY: test
test:
	@echo "==> Running tests"
	go test -v

.PHONY: lint
lint: $(GOLANGCI_LINT)
	@$(GOLANGCI_LINT) run
