***Created by : Aswin KS***

# Basic Helm Commands

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


### 2. helm list/ helm ls

Lists all the installed helm releases

```
aswin@HP:~$ helm ls
NAME      	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART         	APP VERSION
aswi-nginx	default  	3       	2025-11-18 23:13:30.803907047 -0500 EST	deployed	my-nginx-0.1.0	1.16.0     
my-nginx  	default  	1       	2025-11-20 22:54:04.052454207 -0500 EST	deployed	nginx-22.3.2  	1.29.3     
```
You can see the my-nginx that we installed just now. Verify it by running : kubectl get deploy command

```
aswin@HP:~$ kubectl get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
my-nginx   1/1     1            1           3m44s
```

### 3. helm status

This will list the same information that we viewed after the chart is installed. Useful if you want to revisit the details.

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
### 4. helm get manifest

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
### 5. helm upgrade

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

### 6. helm upgrade --install

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
### 7. helm history  and rollback

When upgrading, if an error occurs, you can rollback to previous release.



a. View the revision history
    helm history command displays the entire history of a release.

```
aswin@HP:~$ helm history my-nginx
REVISION	UPDATED                 	STATUS  	CHART       	APP VERSION	DESCRIPTION     
1       	Thu Nov 20 23:09:31 2025	deployed	nginx-22.3.2	1.29.3     	Install complete
```
b. Rollback to previous revision

```
aswin@HP:~$ helm history my-nginx
REVISION	UPDATED                 	STATUS  	CHART       	APP VERSION	DESCRIPTION     
1       	Thu Nov 20 23:09:31 2025	deployed	nginx-22.3.2	1.29.3     	Install complete
aswin@HP:~$ helm rollback my-nginx 1
Rollback was a success! Happy Helming!
```

### 8. helm uninstall

Command used to remove all the resources created by this release (A release is an instance of a chart deployed to a Kubernetes, A chart is just a manifest files. When a chart is installed, it is called a release.)

```
aswin@HP:~$ helm uninstall my-nginx
release "my-nginx" uninstalled

```

9. Render the template locally with out installing

This is used to see what yaml the Helm will generate 

```
aswin@HP:~/helm-learning/Helm/Helm-Fundamentals/3-Helm_Templating_Concepts$ helm template my-pod/
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