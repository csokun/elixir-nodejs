FROM elixir:1.9.4
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install curl gcc g++ make inotify-tools software-properties-common -y --no-install-recommends \
    # config nodejs source
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    # configure yarn source
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    # install nodejs & yarn
    && apt-get update && apt-get install nodejs yarn -y --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["iex"]