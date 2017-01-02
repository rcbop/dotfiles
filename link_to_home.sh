#!/bin/bash
for f in "$PWD/files/"; do ln -s "$f" "$HOME/.${f}"; done
