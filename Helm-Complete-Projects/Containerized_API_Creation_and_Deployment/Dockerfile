FROM python:3.10-slim

# Set working directory 
WORKDIR /app

# Copy the Dependency file
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the images /app diretory
COPY app.py app/

#Expose the port: For Documentation Purpose
EXPOSE 8000

# Start the API server using uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]