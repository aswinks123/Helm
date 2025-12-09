# 😋 What we will learn in Stage-1

1. Using .Values for configuration

2. Using .Release.Name for dynamic naming

3. Basic Helm templating syntax {{ }}

4. Installing and upgrading a Helm chart





## To deploy the chart:


1. Navigate to the chart directory

```

cd Helm_Project_Build_from_Basic_to_Advanced_Concepts/Stage-1-Basic-Deployment

```

2. Install the helm chart:

```
aswin@Aswin-HP:Stage-1-Basic-Deployment$ helm install stage1 .
NAME: stage1
LAST DEPLOYED: Sat Dec  6 23:31:28 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None

```

3. Verify the deployment and its associated pods

```
aswin@Aswin-HP:Stage-1-Basic-Deployment$ helm ls
NAME  	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART                        	APP VERSION
stage1	default  	1       	2025-12-06 23:40:16.267128752 -0500 EST	deployed	stage1-basic-deployment-0.1.0	1.21.1     


aswin@Aswin-HP:Stage-1-Basic-Deployment$ kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
stage1-nginx   2/2     2            2           40s


aswin@Aswin-HP:Stage-1-Basic-Deployment$ kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
stage1-nginx-d6c7c7948-s8ljs   1/1     Running   0          43s
stage1-nginx-d6c7c7948-vrxns   1/1     Running   0          43s

```


## 🗒️ Learning Notes:


```
{{ ... }} : To insert dynamic values.

name: {{ .Release.Name }}-nginx  : .Release.Name is a built-in Helm variable that gives the name of the release when you install or upgrade the chart.

replicas: {{ .Values.replicaCount }}: replicaCount comes from values.yaml

```

Congratulations!. We have successfully completed the stage-1 🥳