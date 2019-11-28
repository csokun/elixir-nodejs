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
export ELIXIR_IMAGE="csokun/elixir-nodejs"
alias iex='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE}'
alias iexm='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} iex -S mix'
alias iexjs='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} npm i'
alias elixir='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixir'
alias elixirc='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} elixirc'
alias mix='docker run -it ${ELIXIR_VOLUMES} -v ${PWD}:/src --rm --network=host ${ELIXIR_IMAGE} mix'
alias elc='echo "removing .mix and .hex directories" && rm -rf ${ELIXIRROOT}/.mix && rm -rf ${ELIXIRROOT}/.hex'
```