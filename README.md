
# Docker Public & Private Repositories

Welcome folks! Please find the commands used during the session

Git clone this repository and delete the .git file before creating the docker image

```
git clone https://github.com/thedevopschannel/sample-nginx-app.git
```
Building Docker Image and pushing to a Public Docker Repository 
------------
```
docker build -t sample-nginx-app:v1 .
docker tag sample-nginx-app:v1 thedevopschannel/sample-nginx-app:v1
docker tag sample-nginx-app:v1 thedevopschannel/sample-nginx-app:v1
docker push thedevopschannel/sample-nginx-app:v1

```

Building Docker Image and pushing to a Private Docker Repository 
-------------
First login to the repository from the termination to manke and entry of the dockerhub access token at /root/.docker/config.json file

```
docker login  -u thedevopschannel #replace with your dockerhub username

provide-the-access-key
```
Building the docker image & pushing to the private dockerhub registry
```
docker build -t sample-nginx-private:v1 .
docker tag sample-nginx-private:v1 thedevopschannel/sample-nginx-private:v1
docker tag sample-nginx-private:v1 thedevopschannel/sample-nginx-private:v1
docker push thedevopschannel/sample-nginx-private:v1
```

Creating a Kubernetes secret for the Pods to use
------------
```
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=/root/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
```

Sample Pod Manifest file
--------------
```
apiVersion: v1
kind: Pod
metadata:
  name: private-web-pod
spec:
  containers:
  - name: private-app
    image: thedevopschannel/sample-nginx-private:pvt1
  imagePullSecrets:
  - name: regcred
```
Expose the App
```
kubectl expose pod podname --target-port=80 --port=8080 --type=NodePort
```

