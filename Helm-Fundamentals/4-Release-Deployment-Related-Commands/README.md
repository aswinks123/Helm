# Release and Deployment Commands

These commands are used to create, upgrade, and remove releases in Kubernetes

 ### 1. helm install

helm install command deploys an application to kubernetes using a chart

```
aswin@HP:~$ helm install my-nginx bitnami/nginx
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
### What happened?

Helm fetches the chart

Renders the template to YAML

Sends the YAML file to Kubernetes

Kubernetes created the required resources

A helm release name called my-nginx is created

### 2. helm upgrade

It is used to modify an existing helm release

Eg: Changing the service type of nginx from clusterIP to NodePort etc.

```
aswin@HP:~$ helm upgrade my-nginx bitnami/nginx --set image.tag=1.25.2
Release "my-nginx" has been upgraded. Happy Helming!

aswin@HP:~$ helm get manifest my-nginx | grep image
          image: registry-1.docker.io/bitnami/nginx:1.25.2
          imagePullPolicy: "IfNotPresent"
          image: registry-1.docker.io/bitnami/nginx:1.25.2
          imagePullPolicy: "IfNotPresent"
```

In this example we changed the nginx image tag from latest to 1.25.2

### 3. helm upgrade --install

This is useful in CI/CD scenarios: When the command runs the first time, it installs the release. But if it runs again it will only upgrade (Only nre changes). This makes deployment faster.

During First run:
```
aswin@HP:~$ helm upgrade --install my-nginx bitnami/nginx
Release "my-nginx" does not exist. Installing it now.
NAME: my-nginx
LAST DEPLOYED: Thu Nov 20 23:09:31 2025
```
During next runs: (Note that the charts are only upgraded, and not installed again as it already exist)

```
aswin@HP:~$ helm upgrade --install my-nginx bitnami/nginx
Release "my-nginx" has been upgraded. Happy Helming!
NAME: my-nginx
LAST DEPLOYED: Thu Nov 20 23:08:31 2025
```

### 4. helm uninstall

Command used to remove all the resources created by this release (A release is an instance of a chart deployed to a Kubernetes, A chart is just a manifest files. When a chart is installed, it is called a release.)

```
aswin@HP:~$ helm uninstall my-nginx
release "my-nginx" uninstalled

```

###  5. helm install <release-name> <chart-name> --dry-run --debug

Simulate Installation, show rendered manifest, but doesn't deploy it

```
aswin@HP 3-Helm_Templating_Concepts$ helm install test-nginx-release my-pod  --dry-run --debug 
install.go:225: 2025-11-25 10:54:52.818974766 -0500 EST m=+0.055701441 [debug] Original chart version: ""
install.go:242: 2025-11-25 10:54:52.819044329 -0500 EST m=+0.055770444 [debug] CHART PATH: /home/aswin/helm-learning/Helm/Helm-Fundamentals/3-Helm_Templating_Concepts/my-pod

NAME: test-nginx-release
LAST DEPLOYED: Tue Nov 25 10:54:52 2025
NAMESPACE: default
STATUS: pending-install
REVISION: 1
TEST SUITE: None
USER-SUPPLIED VALUES:
{}

COMPUTED VALUES:
containerPort: 80
image:
  repository: nginx
  tag: 1.29.3
name: test-pod

HOOKS:
MANIFEST:
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