# This dockerfile will package the code with all the libs and dependencies
FROM ruby:latest

#RUN apt-get -y update && apt-get -y install ruby-bundler
WORKDIR /app 

COPY ./code /app/

RUN bundle install

# Need to install following bundles for the application to work 
RUN bundle add nio4r && bundle add puma && bundle add thin && bundle add falcon && bundle add webrick

CMD ["bundle","exec","rackup","-o","0.0.0.0"]