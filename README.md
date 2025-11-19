# What is Helm?

Helm is a package manager for Kubernetes.
It simplifies deploying, configuring, and managing apps on Kubernetes


| Term       | Meaning                                              |
| ---------- | ---------------------------------------------------- |
| Chart      | A packaged Kubernetes application (YAML + templates) |
| Release    | An instance of a chart running in your cluster       |
| Repository | A place to store charts (e.g., Bitnami, Helm stable) |
| Values     | Configuration options for customizing charts         |


## Helm Architecture

Helm CLI: You run commands (helm install, helm upgrade, etc.)
Charts: Reusable packages that define Kubernetes resources.

## Basic Helm Commands

1. Add a Helm repository

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

2. Search charts

```
helm search repo mysql
helm search repo nginx
```

Note: Lists available charts in your added repositories

3. Install a chart

```
helm install <release-name> <chart-name>
helm install my-nginx bitnami/nginx
```

4. View the status of the deployed chart. It shows the instructions about the chart again.

```
helm status <chartname>
```

5. List all the packages or deployments (helm)

```
helm list or helm ls

helm list -n default  #Specify a namespace
```

6. Uninstall a helm deployment

```
helm uninstall <helm deployment name>
```

7. Check for any updates in Helm repository that we added

```
helm repo update
```

