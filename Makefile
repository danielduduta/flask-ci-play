DOCKER_EXE ?= docker

deployment-image:
	${DOCKER_EXE} build -t ciplay:deployment --target deployment .
.PHONY: deployment-image


testing-image:
	${DOCKER_EXE} build -t ciplay:testing --target testing .
.PHONY: deployment-image

tests:
	${DOCKER_EXE} run ciplay:testing
.PHONY: tests
