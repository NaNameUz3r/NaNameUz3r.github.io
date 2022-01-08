FROM ruby:2.7 as jekyll

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update \
  && apt-get install -y ruby-full build-essential zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

RUN gem install \
  jekyll \
  bundler:1.17.2

EXPOSE 4000

WORKDIR /site

#FROM jekyll as jekyll-serve
#RUN bundle install 

#CMD [ "bundle", "exec", "jekyll", "serve", "--watch", "-H", "0.0.0.0", "-P", "4000" ]

