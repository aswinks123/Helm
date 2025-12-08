# 😋 What we will learn in Stage-2

1. Create functions in _helpers.tpl file

2. How to use _helpers.tpl functions in the helm template

3. Explanation of the function syntax

4. Testing the deployment



## 1. Create functions in _helpers.tpl file

### What is _helpers.tpl in Helm?

1. _helpers.tpl is a template helper file

2. It is NOT rendered into Kubernetes YAML

3. It holds reusable functions (snippets) using define

4. These helpers are called using include from other templates


### Explanation of a simple function


This is a function that we created in helpers.tpl file

```
{{- define "stage2.name" -}}
{{ .Chart.Name }}
{{- end }}

```

We are going to create a named helper function called "stage2.name""

.Chart.Name is a helm object that outputs the chartname.

When we call this helper function using an include statement in other tmplate files, the function will return the name of the chart.

eg: app: {{ include "stage2.name" . }} will call the function "stage2.name"


define "<function_name>" : Used to creata a function and  end: It is the ending of the function


## 2. Refer the Yaml files

Refer the Chart.yaml, _helpers.tpl, deployment.yaml files to learn more about the files.


## 3. Deploy the chart.

### 1. Install the stage2 chart

```
aswin@Aswin-HP:Stage-2-Helpers$ helm install stage2 .
NAME: stage2
LAST DEPLOYED: Mon Dec  8 14:16:59 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None

```

### 2. Check the deployed chart and the kubernetes resources it created

```
aswin@Aswin-HP:Stage-2-Helpers$ helm ls
NAME  	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART                        	APP VERSION
stage2	default  	1       	2025-12-08 14:16:59.288365646 -0500 EST	deployed	stage2-basic-deployment-0.1.0	1.21.1   

aswin@Aswin-HP:Stage-2-Helpers$ kubectl get deploy
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
stage2-stage2-basic-deployment   2/2     2            2           15s

aswin@Aswin-HP:Stage-2-Helpers$ kubectl get po
NAME                                             READY   STATUS    RESTARTS   AGE
stage2-stage2-basic-deployment-ff8497bf8-j2k6z   1/1     Running   0          18s
stage2-stage2-basic-deployment-ff8497bf8-wwkgk   1/1     Running   0          18s

```


### Analyse the Deployment

You can see that the name of the deployment is : stage2-stage2-basic-deployment.

This name was assigned by calling the helper function "stage2.fullname".

```
{{- define "stage2.fullname" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}
```

The function returned :  "stage2-stage2-basic-deployment" that is used to name the deployment


Similarly the "stage2.labels" functions was used to name the tags of the pod.

*** Observe the Label section: *** 

```
aswin@Aswin-HP:Stage-2-Helpers$ kubectl describe pod stage2-stage2-basic-deployment-ff8497bf8-j2k6z
Name:             stage2-stage2-basic-deployment-ff8497bf8-j2k6z
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Mon, 08 Dec 2025 14:16:59 -0500
Labels:           app.kubernetes.io/instance=stage2
                  app.kubernetes.io/name=stage2-basic-deployment
                  pod-template-hash=ff8497bf8
```


## 🗒️ Learning Notes:


1. _helpers.tpl is a template helper file


2. It is NOT rendered into Kubernetes YAML


3. It holds reusable functions (snippets) using define


4. These helpers are called using include from other templates


```
5. define "<function_name>" : Used to creata a function 

<Body of the function>

end: It is the ending of the function

```


Congratulations!. We have successfully completed the stage-2