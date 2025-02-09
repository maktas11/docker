FROM python:3.11-slim

# Copy the requirements file to the working directory
COPY requirements.txt .

RUN apt-get update
RUN yes | apt-get install build-essential python-dev-is-python3 libffi-dev
RUN yes | apt install libcurl4-openssl-dev libssl-dev

# Install the required Python packages
RUN pip install --no-cache-dir -U pip && pip install --no-cache-dir -Ur requirements.txt

# Copy the application code to the working directory
COPY . .

# Set the entrypoint command to run the Flask server
EXPOSE 8088

ENTRYPOINT ["python", "gunicorn", "--access-logfile", "-", "--bind", "0.0.0.0:8088", "--threads=5", "--preload", "endpoint.py"]

