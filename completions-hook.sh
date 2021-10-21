#!/usr/bin/env bash

function install_completions(){
  # hack to ensure the completion function looks right
  PATH="$out/bin:$PATH"

  for shell in zsh bash; do
    scala-cli completions "$shell" > "completions_$shell"
    installShellCompletion --name _scala-cli "--$shell" "completions_$shell"
    echo "installed completions for $shell"
  done
}

postFixupHooks+=(install_completions)
