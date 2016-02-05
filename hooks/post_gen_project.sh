#!/usr/bin/env sh

if foobar_loc="$(type -p "git")" && [ -n "$foobar_loc" ]; then
    git init
    git add .
    git commit -a -m "Generate project structure with cookiecutter."
fi
