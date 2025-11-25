# Chart-Level Commands

These commands operate on chart files (templates, values, metadata).

They do not interact with released deployments.

### 1. helm show values 

This command is used to see the values.yaml in the chart, Similar to running cat values.yaml

```
aswin@HP:~$ helm show values my-pod
name: test-pod
containerPort: 80

image:
  repository: nginx
  tag: 1.29.3

```

### 2. helm show chart <chart>

Shows the chart metadata from chart.yaml file

```
aswin@HP 3-Helm_Templating_Concepts$ helm show chart my-pod
apiVersion: v2
appVersion: 1.16.0
description: A Helm chart for Kubernetes
name: my-pod
type: application
version: 0.1.0
```

### 3. helm show all chart <chart>

This print everything (chart+values+templates)

```
aswin@HP 3-Helm_Templating_Concepts$ helm show all my-pod
apiVersion: v2
appVersion: 1.16.0
description: A Helm chart for Kubernetes
name: my-pod
type: application
version: 0.1.0

---
name: test-pod
containerPort: 80

image:
  repository: nginx
  tag: 1.29.3
```

### 4. helm template (Render the template locally with out installing)

This is used to see what yaml the Helm will generate 

```
aswin@HP:$ helm template my-pod/
---
# Source: my-pod/templates/pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
    - name: nginx
      image: nginx:1.29.3
      ports:
        - containerPort: 80

# Values are fetched from values.yaml file to render it.
```
### 5. helm lint <chart>

Validates the chart for best practice and error such as wrong indentation.
```
aswin@HP 3-Helm_Templating_Concepts$ helm lint my-pod
==> Linting my-pod
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
```

### 6. helm package <chart-folder>

Package the chart in to a tar ball (.tgz)

```
aswin@HP 3-Helm_Templating_Concepts$ helm package my-pod

Successfully packaged chart and saved it to: /home/aswin/helm-learning/Helm/Helm-Fundamentals/3-Helm_Templating_Concepts/my-pod-0.1.0.tgz

```

### 7. helm dependency update

Download dependent charts listed in charts.yaml file.
Dependent chart are those created along with the main chart and are dependent. It is specified in chart.yaml file.