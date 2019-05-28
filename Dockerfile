FROM ruby:2.6

# Mainter Label
LABEL maintainer="Cian Gallagher <cian@ciangallagher.net>" \
      vendor="JustInfluence"

# Make sure image is up to date
RUN apt-get update -qq && \
    apt-get -qq -y upgrade && \
    apt-get install -y build-essential

# Specify src path for gem and bundle path
ENV APP_HOME /usr/src/app
ENV BUNDLE_PATH /usr/src/bundle

# Create working directory
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Run bundler
COPY Gemfile* ./
RUN gem update --system --no-document \
    && gem install bundler --no-document \
    && gem cleanup all

COPY . $APP_HOME/
