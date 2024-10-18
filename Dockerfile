# Use the official Ruby image as a base image
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (if needed)
RUN rails assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

