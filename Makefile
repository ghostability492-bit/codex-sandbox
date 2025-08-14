IMAGE ?= wan-cve-audit
ARGS ?=

.RECIPEPREFIX := >
.PHONY: docker-build docker-run

docker-build:
>docker build -t $(IMAGE) .

docker-run: docker-build
>docker run --rm -it --net=host -v $(PWD)/artifacts:/workspace/artifacts $(IMAGE) $(ARGS)

.PHONY: dry-run
dry-run:
>sudo ./wan-cve-audit.sh $(ARGS)
