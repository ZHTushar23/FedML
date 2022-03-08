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

#''' sh script_name.sh 
#.GPU 2.total_Client_num 3.client_per_round 4.Batch_size
#5.dataset 6.dataset_path 7.model 8.data_distribution
#9.Round 10.Epoch 11.Lr 12.client_optimizer 13.client_index 


# 1. MNIST standalone FedAvg
cd ./fedml_experiments/standalone/fedavg
sh run_fedavg_standalone_pytorch.sh 1 1000 10 10 mnist ./../../../data/mnist lr hetero 100 1 0.03 sgd 1
# 2. FEMNIST standalone FedAvg
# sh run_fedavg_standalone_pytorch.sh 1 3400 10 20 femnist ./../../../data/FederatedEMNIST/datasets cnn hetero 1600 1 0.1 sgd 1

# 3. Shakespeare standalone FedAvg
# sh run_fedavg_standalone_pytorch.sh 1 2 2 4 shakespeare ./../../../data/shakespeare rnn hetero 1 1 0.8 sgd 1
# sh run_fedavg_standalone_pytorch.sh 1 715 10 4 fed_shakespeare ./../../../data/fed_shakespeare/datasets rnn hetero 1300 1 1 sgd 1