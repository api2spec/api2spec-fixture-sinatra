FROM ruby:3.3-slim

WORKDIR /app

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 8080
CMD ["ruby", "app.rb"]
