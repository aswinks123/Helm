***Created by: Aswin KS***

# Daily used Helm templating concepts

This concepts are important when working with helm templates. Let's learn it one by one.

We will use this basic pod definition and a value.yaml file to learn the concepts.

Pod file

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80

```

Value.yaml file

```
Add the value file here at last
```


1. Template Expressions - {{...}}

This is the syntax used by helm to run Go code inside a yaml file. Anything inside the {{..}} will be evaluated. Basically all dynamic content goes inside this.

eg: name: {{ .Value.name }}
#This will fetch the name key from values.yaml and substitute it in the {{..}}

```
aswin@HP 3-Helm_Templating_Concepts$ helm template my-pod
---
# Source: my-pod/templates/pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:

# You can see the name is now dynamically fetched from the values.yaml file.

```
