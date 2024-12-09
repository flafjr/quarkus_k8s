usage: ## Show this help in table format
	@echo "| Target                 | Description                                                       |"
	@echo "|------------------------|-------------------------------------------------------------------|"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/:.*##\s*/##/g' | awk -F'##' '{ printf "| %-22s | %-65s |\n", $$1, $$2 }'

dev: ## Run app in DEV mode
	@./mvnw compile quarkus:dev

local: ## Run app in DEV mode
	@./mvnw compile quarkus:dev -Dquarkus.profile=local
build: ## Build and Push Image - Currently ignoring tests until profile are correctly configured
	@./mvnw package -DskipTests=true -Dquarkus.container-image.build=true

deploy: build ## Deploy In K8s - build
	@kubectl apply -f target/kubernetes/kubernetes.yml

delete: ## Delete objects created by Quarkus
	@kubectl delete -f target/kubernetes/kubernetes.yml

rollout: ## TODO: REVIEW - ?
	@kubectl rollout undo deployment my-application

dc-local: ## Docker Compose UP
	@docker-compose up -d

dc-local-down: ## Docker Compose DOWN
	@docker-compose down -v

k8s-convert: ## Converts docker compose to Kubernetes - https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/
	@kompose convert

k8s-apply: k8s-convert ## Converts docker compose to Kubernetes and apply it
	@kubectl apply

k8s-pfw: ## port forwarding to quarkus service
	@kubectl port-forward --namespace quarkus-postgres svc/quarkus-k8s 8080:80

logs: ## Logs to K8S quarkus service
	@kubectl logs svc/quarkus-k8s

postgres: ## Logs to K8S quarkus service
	@helm upgrade --install postgres-local-postgresql bitnami/postgresql --namespace quarkus-postgres --set postgresqlPassword=mysecretpassword

k8s-db-pfw: ## port forwarding to DB
	@kubectl port-forward --namespace quarkus-postgres svc/postgres-local-postgresql 5432:5432
