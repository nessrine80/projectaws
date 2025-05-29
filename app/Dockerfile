FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Python and pip
RUN apt update && \
    apt install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Copy application source code
COPY backend /backend
COPY frontend /frontend

# Install Python packages
RUN pip3 install --break-system-packages -r /backend/requirements.txt

# Set working directory
WORKDIR /backend

EXPOSE 8080

CMD ["python3", "app.py"]
#test