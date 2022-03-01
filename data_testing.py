import json
data_dir = "data/MNIST/train/all_data_0_niid_0_keep_10_train_9.json"
clients = []
groups = []
train_data = {}
total_samples = []
with open(data_dir) as json_data:
    d = json.load(json_data)
    clients.extend(d['users'])
    if 'hierarchies' in d:
        groups.extend(d['hierarchies'])
    train_data.update(d['user_data'])   # Dictionary extension
    total_samples.append(d['num_samples'])
    print(sum(total_samples[000]))
# for i in train_data :
#     print(i, train_data[i])
