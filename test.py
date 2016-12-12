import numpy as np
import mnist_loader
import NN

def split_data_train(raw_data):
    d = []
    e = []

    for i in range(len(raw_data)):
        d.append(raw_data[i][0])
        e.append(raw_data[i][1])

    d = np.array(d).reshape(data_size, 784)
    e = np.array(e).reshape(data_size, 10)
    return [d, e]

def split_data_test(raw_data):
    d = []
    e = []
    for i in range(len(raw_data)):
        d.append(raw_data[i][0])
        e.append(raw_data[i][1])
    d = np.array(d).reshape(10000, 784)
    e = np.array(e).reshape(10000, 1)
    return [d, e]

training_data, validation_data, test_data = mnist_loader.load_data_wrapper()

# test data is always 10K
data_size = 25000
batch_size = 25000
t1 = training_data[:data_size]
v1 = test_data[:10000]
data = []
expected = []
## GET TRAINING DATA
td, te  = split_data_test(v1)
data, expected = split_data_train(t1)

# Batches
for k in range(int(data_size/batch_size)):
    X = data[k*batch_size:(k+1) * batch_size]
    y = expected[k*batch_size:(k+1) * batch_size]

    neural = NN.Neural(it=300);
    neural.fit(X,y);
    result = neural.get_train_error();
    test = neural.predict(td,te)
    print(result , test)

file = open("tests.txt", 'a')

file.write("Train Size: {0} - Settings: {1} ".format(data_size,neural.get_settings()))
file.write("=> Train Error: {0} - Test Error: {1}\n".format(result,test))
file.close()