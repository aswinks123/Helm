# Release History & Rollback Commands

### 1. helm history  and rollback

When upgrading, if an error occurs, you can rollback to previous release.

a. View the revision history
    helm history command displays the entire history of a release.

```
# To see the history

aswin@HP:~$ helm history my-nginx
REVISION	UPDATED                 	STATUS  	CHART       	APP VERSION	DESCRIPTION     
1       	Thu Nov 20 23:09:31 2025	deployed	nginx-22.3.2	1.29.3     	Install complete


# To Rollback to previous revision

aswin@HP:~$ helm rollback my-nginx 1
Rollback was a success! Happy Helming!
```


