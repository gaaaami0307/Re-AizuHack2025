FROM ruby:3.3.3
RUN apt-get update -qq
RUN apt-get install --no-install-recommends -y build-essential git libvips pkg-config nodejs npm && npm install n -g && n lts
RUN apt-get install -y curl && \
    curl -fsSL https://get.docker.com | sh && \
    sudo usermod -aG docker $USER
RUN npm install -g yarn
RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
