# Elixir Phoenix Development Kit

Elixir Phoenix development tool.

## setup

Add the following lines to your `~/.bashrc`

```bash
# setup Elixir aliases
export ELIXIRROOT="$HOME/elixir"
if [ ! -d "$ELIXIRROOT" ]; then
    mkdir -p $ELIXIRROOT
fi
export MIXPATH="/root/.mix"
export HEXPATH="/root/.hex"
export ELIXIR_VOLUMES="-v ${ELIXIRROOT}/.mix:${MIXPATH} -v ${ELIXIRROOT}/.hex:${HEXPATH} --workdir /src"
export ELIXIR_IMAGE="csokun/elixir-studio"
alias iex='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE}'
alias iexm='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} iex -S mix'
alias elixir='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixir'
alias elixirc='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixirc'
alias mix='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} mix'
alias iexstudio='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} tmux new-session \; split-window -h \; split-window -v \; attach'
alias elc='echo "removing .mix and .hex directories" && rm -rf ${ELIXIRROOT}/.mix && rm -rf ${ELIXIRROOT}/.hex'
```
Reload your bash `source ~/.bashrc` and install hex packages.

```bash
mix local.hex
mix archive.install hex phx_new 1.4.11
```

Nice done! you now ready to hack crack Phoenix.

## Hello World

```bash
mkdir phoenix
cd phoenix
mix phx.new helloworld --no-ecto
mix phx.server
```

Visit: http://localhost:4000 to checkout your Phoenix hello world app.

## Coding

```bash
cd phoenix/helloworld
iexstudio
```
