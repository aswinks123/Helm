# 😋 What we will learn in Stage-3

1. What are conditionals in Helm templating

2. How to define and use conditionals

3. Create a deployment with conditionals

4. Verifying the deployment



## 1. What are Conditionals in Helm?

Conditionals control whether a feature should be enabled or disabled based on the condition set.

### How a conditional looks like


Refer this example code.  Notice the "enabled: true " flag. It is a conditional that determine whether the code should be applied or not.

When we deploy the container, whether the requests and limits apply depends on whether the value of "enabled" is true or false.


```
resources:
 # This is the conditional flag. This determine wherther to enable or disable requests and limits.
  enabled: true 
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "250m"
    memory: "256Mi"

```

## 2. Where the conditional is applied?

Refer the deployment.yaml file. we added the conditional to control whether our pod should have requests and limit set.

Notice the "{{- if .Values.resources.enabled }} " expression.

It states that, if the content of Values.resource.enabled is set to true, add the request and limit to the pod. if not do not add it.

```
   spec:
      containers:
        - name: nginx
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - containerPort: {{ .Values.app.containerPort }}

          # Adding the requests and limits. This will be controlled by the "enabled" variable in values.yaml file.
          #--------------------------------------------------------------------------------------------------------

          {{- if .Values.resources.enabled }}  # It will be triggered only when the "enabled" variable is set to true.
          resources:
            requests:
              cpu: {{ .Values.resources.requests.cpu }}
              memory: {{ .Values.resources.requests.memory }}
            limits:
              cpu: {{ .Values.resources.limits.cpu }}
              memory: {{ .Values.resources.limits.memory }}
          {{- end }}

```


## 3. Deploy the chart.

```
aswin@Aswin-HP:Stage-3-Conditionals$ helm install stage3 .
NAME: stage3
LAST DEPLOYED: Mon Dec  8 23:53:05 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None


```

### 3.1 Check the deployed chart and the kubernetes resources it created

```
aswin@Aswin-HP:Stage-3-Conditionals$ helm ls
NAME  	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART                    	APP VERSION
stage3	default  	1       	2025-12-08 23:53:05.632519432 -0500 EST	deployed	stage3-conditionals-0.1.0	1.21.1   

aswin@Aswin-HP:Stage-3-Conditionals$ kubectl get deploy
NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
stage3-stage3-conditionals   2/2     2            2           23s

aswin@Aswin-HP:Stage-3-Conditionals$ kubectl get pods
NAME                                          READY   STATUS    RESTARTS   AGE
stage3-stage3-conditionals-56d99869b9-4vkqd   1/1     Running   0          26s
stage3-stage3-conditionals-56d99869b9-zg827   1/1     Running   0          26s

```


### 3.2 Describe the pod

Currently  enabled: false is set in values.yaml file, so the requests and limits are not enforced.

```
aswin@Aswin-HP:Stage-3-Conditionals$ kubectl get pods
NAME                                          READY   STATUS    RESTARTS   AGE
stage3-stage3-conditionals-56d99869b9-4vkqd   1/1     Running   0          3m2s
stage3-stage3-conditionals-56d99869b9-zg827   1/1     Running   0          3m2s

aswin@Aswin-HP:Stage-3-Conditionals$ kubectl describe pod stage3-stage3-conditionals-56d99869b9-4vkqd | grep -A 5 '^[[:space:]]*Limits:'

# It didnt print any result because the limits are not enabled.

aswin@Aswin-HP:Stage-3-Conditionals$ 

```

Now set the "enabled: true" and upgrade the chart.

enabled: true 

```
aswin@Aswin-HP:Stage-3-Conditionals$ helm upgrade stage3 .
Release "stage3" has been upgraded. Happy Helming!
NAME: stage3
LAST DEPLOYED: Mon Dec  8 23:58:03 2025
NAMESPACE: default
STATUS: deployed
REVISION: 2
DESCRIPTION: Upgrade complete
TEST SUITE: None

```

Chek whether the request and limits are enabled or not:

```
aswin@Aswin-HP:Stage-3-Conditionals$ kubectl describe pod stage3-stage3-conditionals-9df974467-hc2md |  grep -A 5 '^[[:space:]]*Limits:'
   
    Limits:
      cpu:     250m
      memory:  256Mi
    Requests:
      cpu:        100m
      memory:     128Mi

```

Now request and limits are enabled because the value of enabled in values.yaml is set to true.


## 🗒️ Learning Notes:

Conditionals are useful to control whether a feature should be enabled or disabled when creating the chart.


Congratulations!. We have successfully completed the stage-2