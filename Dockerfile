# Use a Linux base image
FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y unrar inotify-tools

# Set the working directory
WORKDIR /app

# Copy the unrar script to the container
COPY unrar.sh .

# Make the script executable
RUN chmod +x unrar.sh

# Set the script as the entry point
ENTRYPOINT ["./unrar.sh"]