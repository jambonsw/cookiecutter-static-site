#!/usr/bin/env sh

if git_loc="$(type -p "git")" && [ -n "$git_loc" ]; then
    git init
    git add .
    git commit -a -m "Generate project structure with cookiecutter."
fi
