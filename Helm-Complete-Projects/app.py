# 1. This is our Python API application that we are going to package into a docker image.
# It creates a simple API that prints hello world and an endpoint to return whether the app is healthy or not.
# Created by: Aswin KS

from fastapi import FastAPI  #import the FastAPI class so you can create an API application.

app = FastAPI() #This creates your web application.

@app.get("/") #When some one hit IP:def port, it reads the function read_root
async def read_root():
        return {"message": "Hello, World!"}

@app.get("/health") #A health check endpoint (very common in Kubernetes)
async def health():
        return {"status": "ok"}


