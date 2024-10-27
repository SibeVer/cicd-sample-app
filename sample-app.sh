#!/bin/bash

# Check if the Docker container named 'samplerunning' is already running
if [ "$(docker ps -q -f name=samplerunning)" ]; then
    # Stop the container if it's running
    docker stop samplerunning
fi

# Check again and remove the container if it exists (after stopping)
if [ "$(docker ps -aq -f name=samplerunning)" ]; then
    docker rm samplerunning
fi

# Small delay to ensure Docker has stopped and removed the container
sleep 2

# Build the Docker image
docker build -t sampleapp .

# Run the container with the specified name
docker run -d -p 5050:5050 --name samplerunning sampleapp


set -euo pipefail


mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

cat > tempdir/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdir || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
