FROM elixir:1.10

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV TERM xterm-256color

RUN apt-get update && apt-get install tmux ripgrep git curl gcc g++ make python3-pip python3-setuptools inotify-tools ca-certificates -y --no-install-recommends \
    # config nodejs source
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    # configure yarn source
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    # install nodejs & yarn
    && apt-get update && apt-get install nodejs yarn -y --no-install-recommends \
    && pip3 install wheel \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 elixir && \
    useradd -s /bin/bash -r -u 1000 -g elixir elixir && \
    cp /bin/bash /bin/sh

ENV HOME=/home/elixir

# tmux
COPY tmux/.tmux.conf $HOME/.tmux.conf

RUN git clone https://github.com/elixir-lsp/elixir-ls.git $HOME/.elixir-ls && \
    cd $HOME/.elixir-ls && \
    mix local.hex --force && mix local.rebar --force && \
    mix deps.get && mix compile && mix elixir_ls.release -o release

# neovim
COPY config/ $HOME/.config/
# ADD https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz /tmp/
ADD https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz /tmp/
RUN cd /tmp && tar -xf nvim-linux64.tar.gz && \
    cp -a nvim-linux64/* /usr/local/ && \
    rm -rf /tmp/* && \
    # install Plug
    curl -sfLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    nvim +PlugInstall +qall && \
    cd $HOME/.config/coc/extensions && \
    chmod +x install.sh && ./install.sh && \
    # neovim alias
    ln -s /usr/local/bin/nvim /usr/local/bin/vim && \
    ln -s /usr/local/bin/nvim /usr/local/bin/vi

# git prompt
COPY bin/studio /usr/local/bin/studio
COPY .bashrc $HOME/.bashrc
RUN curl -sL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o $HOME/.git-prompt.sh && \
    chmod +x $HOME/.git-prompt.sh && \
    chmod +x /usr/local/bin/studio

WORKDIR /src

# switch user
RUN chown -R elixir $HOME /src \
    && echo "source ~/.bashrc" >> $HOME/.bash_profile

USER elixir
RUN yarn global add neovim && \
    pip3 install --user neovim

CMD ["iex"]