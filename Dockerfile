# Using debian as base
FROM debian:12 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Change repos
RUN REPO_URL="http:\/\/ftp.nl.debian.org\/" && \
	SEDSTR="s/(URIs:) .*?\/(debian)/\1 $REPO_URL\2/g" && \
	SEDSTR="$SEDSTR;s/(URIs:) .*?\/(debian-security)/\1 $REPO_URL\2/g" && \
	sed -E -i "$SEDSTR" /etc/apt/sources.list.d/debian.sources

# Update the container, install dependencies and clean up the image
RUN apt-get update && apt-get upgrade -y && \
	apt-get install sudo zsh vim ansible git curl -y && \
	apt-get autoremove --yes && apt-get clean autoclean

# Add personal configuration to the image
FROM base AS d3f4u1t

# Add user d3f4u1t, give it a password and enable sudo
# RUN useradd -m -G sudo d3f4u1t && \
#	echo "13254789\n13254789" | passwd d3f4u1t && \
#	echo "%sudo   ALL=(ALL:ALL) ALL" | sudo tee /etc/sudoers.d/username

# Change to user d3f4u1t, set working directory to the user's home
USER root
WORKDIR /root

# Copy everything here to the working directory in container
# COPY . .
