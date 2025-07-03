# Use the official Ruby base image
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libsqlite3-dev

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the working directory
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Set the command to run your main Ruby application file
CMD ["ruby", "main.rb"]