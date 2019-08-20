docker build -t arvindcs12/multi-client:latest -t arvindcs12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arvindcs12/multi-server:latest -t arvindcs12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arvindcs12/multi-worker:latest -t arvindcs12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arvindcs12/multi-client:latest
docker push arvindcs12/multi-server:latest
docker push arvindcs12/multi-worker:latest

docker push arvindcs12/multi-client:$SHA
docker push arvindcs12/multi-server:$SHA
docker push arvindcs12/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arvindcs12/multi-server:$SHA
kubectl set image deployments/client-deployment client=arvindcs12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arvindcs12/multi-worker:$SHA