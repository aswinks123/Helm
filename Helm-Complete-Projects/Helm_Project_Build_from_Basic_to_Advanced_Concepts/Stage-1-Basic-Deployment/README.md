# What we will learn in Stage-1

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

3. Verify the deployment and associated pod

```
aswin@Aswin-HP:Stage-1-Basic-Deployment$ kubectl get deploy
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
helloapi-hello-api-chart   1/1     1            1           23h
aswin@Aswin-HP:Stage-1-Basic-Deployment$ kubectl get pods
NAME                                        READY   STATUS    RESTARTS      AGE
helloapi-hello-api-chart-5f464bfd77-5f8ms   1/1     Running   1 (23h ago)   23h
```

Congratulations!. We have successfully completed first stage


