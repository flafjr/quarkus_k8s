usage: ## Show this help in table format
	@echo "| Target                 | Description                                                       |"
	@echo "|------------------------|-------------------------------------------------------------------|"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/:.*##\s*/##/g' | awk -F'##' '{ printf "| %-22s | %-65s |\n", $$1, $$2 }'

build: ## Build and Push Image
	@./mvnw package -Dquarkus.container-image.build=true -Dquarkus.container-image.push=true

deploy: build ## Deploy In K8s
	@kubectl apply -f target/kubernetes/kubernetes.yml

delete: ## Delete objects created by Quarkus
	@kubectl delete -f target/kubernetes/kubernetes.yml

rollout: ## TODO: REVIEW - ?
	@kubectl rollout undo deployment my-application
