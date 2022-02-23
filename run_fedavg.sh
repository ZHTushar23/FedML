#!/bin/bash

# set -ex

# code checking
pyflakes .

# activate the fedml environment
source "$HOME/anaconda3/etc/profile.d/conda.sh"
conda activate fedml

wandb login 78c739f995847a7e26856bd82ad7315c355ac09e
wandb off

assert_eq() {
  local expected="$1"
  local actual="$2"
  local msg

  if [ "$expected" == "$actual" ]; then
    return 0
  else
    echo "$expected != $actual"
    return 1
  fi
}

round() {
  printf "%.${2}f" "${1}"
}

# 1. MNIST standalone FedAvg
cd ./fedml_experiments/standalone/fedavg
# sh run_fedavg_standalone_pytorch.sh 1 1000 10 10 mnist ./../../../data/mnist lr hetero 100 1 0.03 sgd 1
sh run_fedavg_standalone_pytorch.sh 1 3400 10 20 femnist ./../../../data/FederatedEMNIST/datasets cnn hetero 1600 1 0.1 sgd 1