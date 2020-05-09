#!/usr/bin/env bash
set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

npm install coc-elixir coc-json coc-html coc-emmet coc-snippets coc-tsserver --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod