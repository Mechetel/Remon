FROM ruby:2.6.3-stretch

RUN apt-get update -qq && curl -sL https://deb.nodesource.com/setup_10.x | bash - &&  apt-get install -y postgresql-client nodejs

RUN mkdir /remon
WORKDIR /remon

COPY Gemfile /remon/Gemfile
COPY Gemfile.lock /remon/Gemfile.lock
RUN bundler install

COPY . /remon

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
