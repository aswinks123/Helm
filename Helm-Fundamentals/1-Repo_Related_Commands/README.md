***Created by : Aswin KS***

# Helm Repository Related Commands

Repository related commands are used to interact with the repository that holds various helm charts.

### 1. helm repo add

This command add the the repository to our server. Helm charts are located in the repository.

```
aswin@HP:~$ helm repo add bitnami https://charts.bitnami.com/bitnami
"bitnami" has been added to your repositories
```

### 2. helm repo list or helm repo ls

This command is used to list all the added repositories

```
aswin@HP:~$ helm repo list
NAME   	URL                               
bitnami	https://charts.bitnami.com/bitnami
aswin@HP:~$ helm repo ls
NAME   	URL                               
bitnami	https://charts.bitnami.com/bitnami

```

### 3. helm repo update

If Bitnami updates the any charts, You will get the latest version.

```
aswin@HP:~$ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈

```
### 4. helm search repo <package/chart>

This command is used to search for a particular package that is available in the added repository.

```
aswin@HP:~$ helm search repo nginx
NAME                            	CHART VERSION	APP VERSION	DESCRIPTION                                       
bitnami/nginx                   	22.3.2       	1.29.3     	NGINX Open Source is a web server that can be a...
bitnami/nginx-ingress-controller	12.0.7       	1.13.1     	NGINX Ingress Controller is an Ingress control...
bitnami/nginx-intel             	2.1.15       	0.4.9      	DEPRECATED NGINX Open Source for Intel is a lig...
```

### 5. helm repo remove

Used to remove an added repository

```
aswin@HP:~$ helm repo remove bitnami
"bitnami" has been removed from your repositories
```

### 6. helm pull bitnami/nginx

This will download the nginx chart to your server. Please note that this will not install the package, but only download the charts. (Refer the below to see the downloaded file). If you want to untar the chart , add the flag --untar (elm pull bitnami/nginx --untar)

```
aswin@HP:~$ helm pull bitnami/nginx
aswin@HP:~$ ls -ltr | tail -1
-rw-r--r--  1 aswin aswin     60819 Nov 20 22:48 nginx-22.3.2.tgz
```

### 7. helm env

Shows environment variables Helm uses.

```
aswin@HP Helm-Fundamentals$ helm env
HELM_BIN="helm"
HELM_BURST_LIMIT="100"
HELM_CACHE_HOME="/home/aswin/.cache/helm"
HELM_CONFIG_HOME="/home/aswin/.config/helm"
HELM_DATA_HOME="/home/aswin/.local/share/helm"
HELM_DEBUG="false"
HELM_KUBEAPISERVER=""
HELM_KUBEASGROUPS=""
HELM_KUBEASUSER=""
```
