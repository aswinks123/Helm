# Helm Repository Related Commands

Repository related commands are used to interact with the repository that holds various helm charts.

1. helm repo add

This command add the the repository to our server. Helm charts are located in the repository.

```
aswin@HP:~$ helm repo add bitnami https://charts.bitnami.com/bitnami
"bitnami" already exists with the same configuration, skipping

```

2. helm repo list or helm repo ls

This command is used to list all the added repositories

```
aswin@HP:~$ helm repo list
NAME   	URL                               
bitnami	https://charts.bitnami.com/bitnami
aswin@HP:~$ helm repo ls
NAME   	URL                               
bitnami	https://charts.bitnami.com/bitnami

```

3. helm repo update

If Bitnami updates the any charts, You will get the latest version.

```
aswin@HP:~$ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈

```

