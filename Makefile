build:
	docker build -t localhost:5000/ccnmtl/omeka .

push:
	docker push localhost:5000/ccnmtl/omeka

pull:
	docker pull localhost:5000/ccnmtl/omeka
