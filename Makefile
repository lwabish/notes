registry=ccr.ccs.tencentyun.com/lwabish
time:=$(shell date +"%Y%m%d-%H%M%S")
commit=$(shell git rev-parse --short HEAD)
# tag=$(time)-$(commit)
tag=$(commit)

.PHONY all: build img install 
preview:
	mkdocs serve
build:
	mkdocs build
img:
	cp -f Dockerfile site/
	docker build -t $(registry)/notes:$(tag) site/
	docker push $(registry)/notes:$(tag)
	docker rmi $(registry)/notes:$(tag)

install:
	kubectl config use-context home
	helm upgrade -i -n default notes ./chart --set registry=$(registry) --set tag=$(tag)