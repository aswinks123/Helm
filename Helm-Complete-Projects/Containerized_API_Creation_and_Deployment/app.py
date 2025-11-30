# 1. This is our Python API application that we are going to package into a docker image.
# It creates a simple API that prints hello world and an endpoint to return whether the app is healthy or not.
# Created by: Aswin KS

from fastapi import FastAPI  #import the FastAPI class so you can create an API application.

app = FastAPI() #This creates your web application.

@app.get("/") #When some one hit IP:def port, it reads the function read_root
async def read_root():
        return {"message": "API Version : v1. Happy Learning!"}

@app.get("/health") #A health check endpoint (very common in Kubernetes)
async def health():
        return {"status": "ok"}


# Requirements (fastapi, uvicorn) PIP modules

# To run: uvicorn app:app --host 0.0.0.0 --port 8000 --reload

"""
uvicorn → runs the FastAPI server

app:app → use the app object from app.py

--host 0.0.0.0 → allow access from anywhere (needed for Docker/K8s)

--port 8000 → run on port 8000

--reload → auto-restart when code changes (for development)

"""