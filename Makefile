usage: ## Show this help in table format
	@echo "| Target                 | Description                                                       |"
	@echo "|------------------------|-------------------------------------------------------------------|"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/:.*##\s*/##/g' | awk -F'##' '{ printf "| %-22s | %-65s |\n", $$1, $$2 }'

dev: ## Run app in DEV mode
	@./mvnw compile quarkus:dev

build: ## Build and Push Image
	@./mvnw package -Dquarkus.container-image.build=true -Dquarkus.container-image.push=true

deploy: ## Deploy In K8s - build
  @./mvnw clean package
	@kubectl apply -f target/kubernetes/kubernetes.yml

delete: ## Delete objects created by Quarkus
	@kubectl delete -f target/kubernetes/kubernetes.yml

rollout: ## TODO: REVIEW - ?
	@kubectl rollout undo deployment my-application

local: ## Docker Compose UP
	@docker-compose up -d

local-down: ## Docker Compose DOWN
	@docker-compose down -v

k8s-convert: ## Converts docker compose to Kubernetes - https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/
	@kompose convert

k8s-apply: k8s-convert ## Converts docker compose to Kubernetes and apply it
	@kubectl apply
