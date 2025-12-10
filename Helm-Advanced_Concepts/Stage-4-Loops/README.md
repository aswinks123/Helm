# 😋 What we will learn in Stage-4

1. What are loops (range) in Helm templating

2. How to use looping

3. Create a deployment and add environment variables from a list using range function.

4. Verifying the deployment



## 1. What are loops in Helm?

Loops in Helm are used to generate repeated YAML blocks from a list of values.

Helm loops (range) go through a list or map in values.yaml and render YAML for each item.

## 2. How a range looks like

varibales declared in values.yaml file

```
environment_variables:
  - name: ENV
    value: dev
  - name: LOG_LEVEL
    value: info
```

We loop through these values using the range function.

These values are injected to pod as an env variables.

```
env:
  {{- range .Values.env }}
  - name: {{ .name }}
    value: {{ .value | quote }}
  {{- end }}

```
## 3. Important: Behavior of "." in Helm

Generally "." in helm means current contect. "." = entire Helm context. so we use ".Values" to refer the data in values.yaml file.

But

In range "." = current item of the loop.  That is why inside the range function we used ".name" and ".value" to reference the current iterating item in the list.

## 4. Hands on

Refer the files located under template directory.


### 4.1 Deploy the chart

```
aswin@Aswin-HP:Stage-4-Loops$ helm install stage4 .
NAME: stage4
LAST DEPLOYED: Tue Dec  9 22:36:24 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None
```

### 4.2 List the helm chart and the resources it created

```
aswin@Aswin-HP:Stage-4-Loops$ helm ls
NAME  	NAMESPACE	REVISION	UPDATED                               	STATUS  	CHART             	APP VERSION
stage4	default  	1       	2025-12-09 22:36:24.26574591 -0500 EST	deployed	stage4-loops-0.1.0	1.21.1   

aswin@Aswin-HP:Stage-4-Loops$ kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
stage4-stage4-loops-79df5b868c-dv6xn   1/1     Running   0          32s
stage4-stage4-loops-79df5b868c-m5pbk   1/1     Running   0          32s
```

### 4.3 Describe the pod and verify whether the ENV variables are injected.

```
aswin@Aswin-HP:Stage-4-Loops$ kubectl describe  pod stage4-stage4-loops-79df5b868c-dv6xn |  grep -A 5 '^ *Environment:'

    Environment:
      ENV:        dev
      LOG_LEVEL:  info
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dl8x7 (ro)
Conditions:
```

We can see that the ENV variables are injected to the pod with the help of range function.


## 🗒️ Learning Notes:

Generally "." in helm means current contect.

In range "."  means current item of the loop.  


Congratulations!. We have successfully completed the stage-4 🥳