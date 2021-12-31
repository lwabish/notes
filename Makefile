registry=ccr.ccs.tencentyun.com/lwabish
time:=$(shell date +"%Y%m%d-%H%M%S")
commit=$(shell git rev-parse --short HEAD)
# tag=$(time)-$(commit)
tag=$(commit)

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
	kubectl config use-context tencent
	helm upgrade -i -n default lwabish-notes ./chart --set registry=$(registry) --set tag=$(tag)
	kubectl config use-context home