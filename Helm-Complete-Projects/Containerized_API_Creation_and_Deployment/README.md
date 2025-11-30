PART 1: Creation Application, Containerize it and push to Docker Hub

1. Create a Python API Web application - Done

Note: Refer the app.py file


2. Create a Docker file and Build the image - Done

Note: Refer the Dockerfile 

```
aswin@Aswin-HP:Containerized_API_Creation_and_Deployment$ docker build -t 1365890/hello-api:1.0 .
[+] Building 0.9s (11/11) FINISHED                                                                                                                                            docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                    0.0s
 => => transferring dockerfile: 462B                                                                                                                                                    0.0s
 => [internal] load metadata for docker.io/library/python:3.10-slim                                                                                                                     0.7s
 => [auth] library/python:pull token for registry-1.docker.io                                                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                                                       0.0s
 => => transferring context: 65B                                                                                                                                                        0.0s
 => [1/5] FROM docker.io/library/python:3.10-slim@sha256:c299e10e0070171113f9a1f109dd05e7e634fa94589b056e0e87bb22b2b382a2                                                               0.0s
 => => resolve docker.io/library/python:3.10-slim@sha256:c299e10e0070171113f9a1f109dd05e7e634fa94589b056e0e87bb22b2b382a2                                                               0.0s
 => [internal] load build context                                                                                                                                                       0.0s
 => => transferring context: 63B                                                                                                                                                        0.0s
 => CACHED [2/5] WORKDIR /app                                                                                                                                                           0.0s
 => CACHED [3/5] COPY requirements.txt .                                                                                                                                                0.0s
 => CACHED [4/5] RUN pip install --no-cache-dir -r requirements.txt                                                                                                                     0.0s
 => CACHED [5/5] COPY app.py .                                                                                                                                                          0.0s
 => exporting to image                                                                                                                                                                  0.1s
 => => exporting layers                                                                                                                                                                 0.0s
 => => exporting manifest sha256:c225fc8547b730e17dc2a6272cbecc385e0ff7393fc81080e77a4c85a756377d                                                                                       0.0s
 => => exporting config sha256:737fe79f452a1d7471a611c0e799eab1b9c70517ae0e1599a5a685fae9d7ae2c                                                                                         0.0s
 => => exporting attestation manifest sha256:c8f919bd6388679b41b517af38edd8b3fcf2312d669021149869a89d4cb993aa                                                                           0.0s
 => => exporting manifest list sha256:c0536ca3f3533d6db55b79e265c0097d3be56bca6f0782e167897e802f582dbb                                                                                  0.0s
 => => naming to docker.io/1365890/hello-api:1.0                                                                                                                                        0.0s
 => => unpacking to docker.io/1365890/hello-api:1.0                                                                                                                                     0.0s

```
3. Test the image Locally - Done
3. Push the image to Docker Hub

```
aswin@Aswin-HP:Containerized_API_Creation_and_Deployment$ docker push 1365890/hello-api:1.0 
The push refers to repository [docker.io/1365890/hello-api]
0e4bc2bd6656: Pushed 
9793cbb1e51a: Pushed 
683c3659b1e9: Pushed 
f86ba98c4d0f: Pushed 
fa4bcb808c4c: Pushed 
c4e9fa770e86: Pushed 
b16cdfa6e2f4: Pushed 
53fe20ff2b63: Pushed 
d6f24ba36563: Pushed 
1.0: digest: sha256:0eaeda308f414d319cc500b769e5c6986733e0ed31882ce1ea73ecbccc74f018 size: 856
```

