FROM ruby:2.6.3-stretch

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

RUN mkdir /railsredditclone
WORKDIR /railsredditclone

ENV BUNDLE_PATH /box

COPY Gemfile /railsredditclone/Gemfile
COPY Gemfile.lock /railsredditclone/Gemfile.lock
RUN gem uninstall bundler -a \
      && gem install bundler -v 2.0.1 \
      && bundle install

COPY package.json .
COPY yarn.lock .
RUN yarn install --check-files

COPY . /railsredditclone

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
