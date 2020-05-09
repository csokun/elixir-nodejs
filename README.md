# Elixir Phoenix Development Kit

Elixir Phoenix development tool.

## setup

Add the following lines to your `~/.bashrc`

```bash
# setup Elixir aliases
export ELIXIR_IMAGE="csokun/elixir-studio:latest"
export ELIXIR_HOST_ROOT="$HOME/elixir"
if [ ! -d "$ELIXIR_HOST_ROOT" ]; then
    mkdir -p $ELIXIR_HOST_ROOT/.mix $ELIXIR_HOST_ROOT/.hex $ELIXIR_HOST_ROOT/nvim/.config/coc/extensions
fi
export ELIXIR_CONTAINER_ROOT="/home/elixir"
export ELIXIR_VOLUMES="-v ${ELIXIR_HOST_ROOT}/.mix:${ELIXIR_CONTAINER_ROOT}/.mix -v ${ELIXIR_HOST_ROOT}/.hex:${ELIXIR_CONTAINER_ROOT}/.hex --mount type=bind,source=${HOME}/.gitconfig,target=${ELIXIR_CONTAINER_ROOT}/.gitconfig,readonly --workdir /src"

alias iex='docker run -it ${ELIXIR_VOLUMES} -e DISPLAY=$DISPLAY -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE}'
alias iexm='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} iex -S mix'
alias elixir='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixir'
alias elixirc='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixirc'
alias mix='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} mix'
alias iexstudio='docker run -it ${ELIXIR_VOLUMES} -e DISPLAY=$DISPLAY -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} studio'
alias elc='echo "removing .mix and .hex directories" && rm -rf ${ELIXIRROOT}/.mix && rm -rf ${ELIXIRROOT}/.hex'
```
Reload your bash `source ~/.bashrc` and install hex packages.

```bash
mix local.hex
mix archive.install hex phx_new 1.5.1
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

## Live Troubleshoot

Grab demo code and watch this [https://www.youtube.com/watch?v=JvBT4XBdoUE](https://www.youtube.com/watch?v=JvBT4XBdoUE) 

```bash
git clone https://github.com/sasa1977/demo_system.git
cd demo_system/example_sytem
# build
mix deps.get && pushd assets && npm install && pods && mix compile
# start the app
iex --name app@127.0.0.1 -S mix phx.server
# start new console - remote shell to app
iex --name console@127.0.0.1 --remsh app@127.0.0.1
# congrat!!! now watch the clip & start your elixir hacking journey 
```

## Observability

To monitor `elixir` process:

```bash
> iex
:observer.start()
```