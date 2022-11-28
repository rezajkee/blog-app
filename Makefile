MANAGE := poetry run python manage.py

.PHONY: runserver
runserver:
	@$(MANAGE) runserver

.PHONY: makemigrations
makemigrations:
	@$(MANAGE) makemigrations

.PHONY: migrate
migrate:
	@$(MANAGE) migrate

.PHONY: collectstatic
collectstatic:
	@$(MANAGE) collectstatic

.PHONY: shell
shell:
	@$(MANAGE) shell_plus

.PHONY: install
install:
	poetry install

.PHONY: flake8
flake8:
	poetry run flake8 mysite

.PHONY: black-check
black-check:
	poetry run black --check mysite  
# poetry run black --check --exclude=migrations mysite (без настроек в pyproject)

.PHONY: black-diff
black-diff:
	poetry run black --diff mysite
# poetry run black --diff --exclude=migrations mysite  (без настроек в pyproject)

.PHONY: black
black:
	poetry run black mysite
# poetry run black --exclude=migrations mysite  (без настроек в pyproject)

.PHONY: isort-check
isort-check:
	poetry run isort mysite --check-only

.PHONY: isort-diff
isort-diff:
	poetry run isort mysite --diff

.PHONY: isort
isort:
	poetry run isort mysite

.PHONY: exportreq
exportreq:
	poetry export -f requirements.txt --output requirements.txt

.PHONY: makemessages
makemessages:
	cd mysite/ ;\
	poetry run django-admin makemessages -l ru ;\
	cd ..

.PHONY: compilemessages
compilemessages:
	cd mysite/ ;\
	poetry run django-admin compilemessages ;\
	cd ..

.PHONY: test
test:
	poetry run pytest

.PHONY: test-coverage
test-coverage: # запись покрытия для CodeClimate
	poetry run pytest --cov=mysite --cov-report xml