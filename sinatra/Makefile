include ../db.mk

export DB_URI = "postgresql://$(PGUSER):$(PGPASSWORD)@$(PGHOST):$(DB_PORT)/postgres"

run: ## run the web server
	puma

integration-tests: ## run integration tests
	bundle exec rspec spec/api_spec.rb

include ../help.mk
