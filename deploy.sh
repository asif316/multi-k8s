docker build -t asifhdocker/multi-client:latest -t asifhdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t asifhdocker/multi-server:latest -t asifhdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t asifhdocker/multi-worker:latest -t asifhdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push asifhdocker/multi-client:latest
docker push asifhdocker/multi-server:latest
docker push asifhdocker/multi-worker:latest

docker push asifhdocker/multi-client:$SHA
docker push asifhdocker/multi-server:$SHA
docker push asifhdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=asifhdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=asifhdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=asifhdocker/multi-worker:$SHA