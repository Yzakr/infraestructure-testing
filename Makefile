tinit:
	terraform init
tapply:
	terraform apply
tdestroy:
	terraform destroy
dbuild:
	docker build -t hello-world .
dconvert:
	docker tag hello-world:latest XXXXXXXX.dkr.ecr.us-west-1.amazonaws.com/helloworld:latest
dapply:
	docker push XXXXXXXX.dkr.ecr.us-west-1.amazonaws.com/helloworld:latest