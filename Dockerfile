FROM ruby:2.6.3-stretch

RUN apt-get update \
  && apt-get install -y nodejs postgresql-client

RUN mkdir /railsredditclone
WORKDIR /railsredditclone
COPY Gemfile /railsredditclone/Gemfile
COPY Gemfile.lock /railsredditclone/Gemfile.lock
RUN gem uninstall bundler -a \
      && gem install bundler -v 2.0.1 \
      && bundle install

COPY . /railsredditclone


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
