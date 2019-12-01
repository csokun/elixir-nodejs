FROM elixir:1.9.4
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install tmux git curl gcc g++ make inotify-tools ca-certificates -y --no-install-recommends \
    # config nodejs source
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    # configure yarn source
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    # install nodejs & yarn
    && apt-get update && apt-get install nodejs yarn -y --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# tmux
COPY tmux/.tmux.conf /root/.tmux.conf

RUN git clone https://github.com/elixir-lsp/elixir-ls.git /root/.elixir-ls && \
    cd /root/.elixir-ls && \
    mix local.hex --force && mix local.rebar --force && \
    mix deps.get && mix compile && mix elixir_ls.release -o release

# neovim
COPY nvim/* /root/.config/nvim/
ADD https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz /tmp/
RUN cd /tmp && tar -xf nvim-linux64.tar.gz && \
    cp -a nvim-linux64/* /usr/local/ && \
    rm -rf /tmp/* && \
    # install Plug
    curl -fLo /root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    nvim +PlugInstall +qall && \
    nvim -c 'CocInstall -sync coc-elixir coc-json coc-html coc-emmet coc-tsserver|q' && \
    # neovim alias
    ln -s /usr/local/bin/nvim /usr/local/bin/vim && \
    ln -s /usr/local/bin/nvim /usr/local/bin/vi

WORKDIR /src

CMD ["iex"]