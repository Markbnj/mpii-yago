REGISTRY_NAME ?= markbnj
SHELL = /bin/bash
IMAGE_NAME ?= mpii-yago
CONTAINER_NAME ?= yago
TAG ?= 3.0.2
LOG_NAME ?= image-build.log
YAGO_TTL ?= http://resources.mpi-inf.mpg.de/yago-naga/yago/download/yago/yago3_entire_ttl.7z
YAGO_TTL_FILE ?=

stop:
	if (docker ps -a | grep -q $(CONTAINER_NAME)); then docker rm -f $(CONTAINER_NAME); fi

run: stop
	docker run -d -p 3030:3030 --name=$(CONTAINER_NAME)

clean: stop
	if (docker images | grep -q $(REGISTRY_NAME)/$(IMAGE_NAME)); then docker rmi $(REGISTRY_NAME)/$(IMAGE_NAME):$(TAG); fi
	rm -f image-build.log

build: clean .download_yago
	docker build --tag=$(REGISTRY_NAME)/$(IMAGE_NAME):$(TAG) --rm=true --force-rm=true . | tee $(LOG_NAME)
