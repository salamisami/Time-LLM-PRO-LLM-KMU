# Use an official Python 3.9 runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system dependencies required for Psutil and other packages that need compilation
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    gcc \
    python3-dev \
    libc-dev \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch first to ensure it's available for dependencies that require it
# Adjust the torch version and CUDA version according to your needs
RUN pip install torch==2.0.1 -f https://download.pytorch.org/whl/torch_stable.html

# Copy the requirements file into the container at /usr/src/app
COPY requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application's code
COPY . .

RUN find ./scripts -type f -print0 | xargs -0 dos2unix

# Command to keep the container running for development
CMD ["tail", "-f", "/dev/null"]