FROM ruby:3.3-slim

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 8080
CMD ["ruby", "app.rb"]
