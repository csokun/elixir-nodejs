#!/usr/bin/env bash
set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod \
    coc-elixir  \
    coc-json \
    coc-html \
    coc-emmet \
    coc-snippets \
    coc-tailwindcss \
    coc-tsserver 