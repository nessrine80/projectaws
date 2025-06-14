FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Python, pip, and tesseract
RUN apt update && \
    apt install -y python3 python3-pip tesseract-ocr && \
    rm -rf /var/lib/apt/lists/*

# Copy application source code
COPY backend /backend
COPY frontend /frontend

# Install Python packages
RUN pip3 install -r /backend/requirements.txt

# Set working directory
WORKDIR /backend

EXPOSE 8080

CMD ["python3", "app.py"]
#test