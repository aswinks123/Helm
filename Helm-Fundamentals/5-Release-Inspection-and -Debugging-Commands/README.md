# Release Inspection & Debugging Commands

These commands help to analyze what is installed

### 1. helm list / helm ls

Used to list all release.

```
aswin@HP 3-Helm_Templating_Concepts$ helm ls
NAME       	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART         	APP VERSION
aswin-nginx	default  	1       	2025-11-22 14:59:48.168782462 -0500 EST	deployed	my-nginx-0.1.0	1.0  
```

### 2. helm status <release>


This will list the same information that we viewed after the chart is installed, or to see the release information. Useful if you want to revisit the details. 

```
aswin@HP:~$ helm status my-nginx
NAME: my-nginx
LAST DEPLOYED: Thu Nov 20 22:54:04 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: nginx
CHART VERSION: 22.3.2
APP VERSION: 1.29.3
-----
---------
--------------
WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
  - cloneStaticSiteFromGit.gitSync.resources
  - resources
+info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
```

### 3. helm get manifest <release>

This command displays the actual fully rendered manifest yaml file that was sent to the kubernetes. Rendered means all the values are filled and all placeholders are replaced with actual values. Values can be passed to the chart template using a value.yaml file.

```
aswin@HP:~$ helm get manifest my-nginx
---
# Source: nginx/templates/networkpolicy.yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: my-nginx
  namespace: "default"
  labels:
    app.kubernetes.io/instance: my-nginx
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: nginx
    app.kubernetes.io/version: 1.29.3
    helm.sh/chart: nginx-22.3.2
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/instance: my-nginx

and so on...

```
### 4. elm get values <release>

Shows only user-supplied values.

```
aswin@HP 3-Helm_Templating_Concepts$ helm get values aswin-nginx
USER-SUPPLIED VALUES:
null

```

### 5. helm get notes <release

TO show the NOTES.txt output from the chart.

### 6. helm get all <release>

TO print everything helm knows about the release

```
aswin@HP 3-Helm_Templating_Concepts$ helm get all aswin-nginx
NAME: aswin-nginx
LAST DEPLOYED: Sat Nov 22 14:59:48 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
CHART: my-nginx
VERSION: 0.1.0
APP_VERSION: 1.0
TEST SUITE: None
USER-SUPPLIED VALUES:
null

COMPUTED VALUES:
...
..
..

    containers:
        - name: nginx
          image: "nginx:latest"
          ports:
            - containerPort: 80
```




