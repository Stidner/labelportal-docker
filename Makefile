run:
	docker-compose up -d app

shell:
	docker-compose exec --user www-data app bash

shell-front:
	docker-compose exec node sh

root:
	docker-compose exec app bash

stop:
	docker-compose kill

destroy:
	docker-compose down

logs:
	docker-compose logs app

logs-front:
	docker-compose logs node
