***Created by: Aswin KS***

# Daily used Helm templating concepts

These concepts are important when working with helm templates. Let's learn them one by one.

We will use this basic pod definition and a value.yaml file to learn the concepts.

Pod.yaml file

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


1. Template Expressions  {{...}}

This is the syntax used by helm to run Go code inside a yaml file. Anything inside the {{..}} will be evaluated. Basically all dynamic content goes inside this.

eg: Change the name value from static nginx pod to -   name: {{ .Value.name }}
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

2. Whitespace Trimming   {{- ... - }}

-  : This trims all the white space from the front or rear according to where it is used.

eg:  {{-          I am far from right side}}   # It trims all the white space in front of the text.


3. .values 

.values is a built in Helm object that holds the content of values.yaml

eg: In the pod.yaml replace the static container port to:  

```
- containerPort: {{ .Values.containerPort}}
```

* We can also fetch Nested vales

eg: We can set the image name using:  

```
image: {{ .Values.image.repository }}:{{ .Values.image.tag}}
```
Note: Values are accessed with .

The result will look like this:

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
    - name: nginx
      image: nginx:1.29.3
      ports:
        - containerPort: 80
```