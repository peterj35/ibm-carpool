# Dockerfile
# Base Image
FROM ruby:2.3.1
MAINTAINER Future Blue Web Team <jupeter@ca.ibm.com>

# Update Environment
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Build
RUN mkdir /ibm-carpool
WORKDIR /ibm-carpool

# Install Gem Dependencies
ADD Gemfile /ibm-carpool/Gemfile
RUN bundle install

# Add Files
ADD . /ibm-carpool
