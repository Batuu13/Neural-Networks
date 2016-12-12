import numpy as np
import matplotlib.pyplot as plt


class Neural:

    def __init__(self,lr = 0.0001,lh = 32,lw =4,it = 50000 , decay = 0.9999,precision = 8):
        plt.ion()
        # lw = Layer Width
        # lh = Layer Height
        # lr = Learning Rate
        # it = Iteration Count
        # precision = If the difference is a smaller than first x digits after precision point iteration stops
        self.precision = 1 / (10 ** precision)
        self.decay = decay
        self.expected = None
        self.prediction = None
        self.data = None
        self.lr2 = lr
        self.lr = lr
        self.layer_height = lh
        self.layer_width = lw
        self.iteration = it
        self.weights = []

        # initialize weights
        np.random.seed(1)
        self.initialize_weights()

    def initialize_weights(self):
        self.weights.append(2 * np.random.random((785, self.layer_height)) - 1)
        for i in range(self.layer_width - 1):
            self.weights.append(2 * np.random.random((self.layer_height, self.layer_height)) - 1)
        self.weights.append(2 * np.random.random((self.layer_height, 10)) - 1)

    # activation function (tanH)
    def activate(self, x):
        #output = 1 / (1 + np.exp(-x))  # Sigmoid
        output = 2 / (1 + np.exp(-2 * x)) - 1 # TanH
        return output

    # derivative of activation function
    def activate_d(self, x):
        #return (1 - x) * x # Sigmoid
        return 1 - x ** 2 # TanH

    def fit(self, data, output):
        # Forward Phase
        self.data = np.zeros((np.array(data).shape[0],np.array(data).shape[1] + 1))
        self.expected = output

        bias = 1
        for i in range(np.array(data).shape[0]):
            self.data[i] = np.append(data[i],bias)

        layers = []
        layers_error = []
        layers_delta = []


        # Construct Layers >> input - hidden - output
        layers.append(self.activate(np.dot(self.data, self.weights[0])));
        for k in range(1,self.layer_width + 1):
            layers.append(self.activate(np.dot(layers[k - 1], self.weights[k])))

        ###################
        # Calculate Errors And Deltas >> output - hidden - input
        layers_error.append(self.expected - layers[-1])
        layers_delta.append(layers_error[0] * self.activate_d(layers[-1]))

        for k in range(0,self.layer_width):
            layers_error.append(np.dot(layers_delta[k], self.weights[-(k+1)].T))
            layers_delta.append(layers_error[k+1] * self.activate_d(layers[-(k+2)]))
        ###################
        # Update Weights
        delta = np.dot(self.data.T,layers_delta[-1])
        self.weights[0] += np.multiply(delta, self.lr)
        for k in range(0,len(self.weights) - 1):
            delta = np.dot(layers[k].T,layers_delta[-(k+2)])
            self.weights[k+1] += np.multiply(delta, self.lr)
        last_error = np.mean(np.abs(layers[-1]))
        ###################

        for i in range(self.iteration):
            # Using decay in Learning Rate
            self.lr *= self.decay

            # Construct Layers >> input - hidden - output
            layers[0] = self.activate(np.dot(self.data, self.weights[0]))
            for k in range(1, self.layer_width + 1):
                layers[k] = self.activate(np.dot(layers[k - 1], self.weights[k]))

            ###################
            # Calculate Errors And Deltas >> output - hidden - input
            layers_error[0] = (self.expected - layers[-1])
            layers_delta[0] = (layers_error[0] * self.activate_d(layers[-1]))

            for k in range(1, self.layer_width + 1):
                layers_error[k] = (np.dot(layers_delta[k - 1], self.weights[-(k)].T))
                layers_delta[k] = (layers_error[k] * self.activate_d(layers[-(k+1)]))
            ###################
            # Update Weights
            delta = np.dot(self.data.T, layers_delta[-1])
            self.weights[0] += np.multiply(delta, self.lr)
            for k in range(0, len(self.weights) - 1):
                delta = np.dot(layers[k].T, layers_delta[-(k + 2)])
                self.weights[k + 1] += np.multiply(delta, self.lr)

            ###################
            if i % 2 == 0:
                plt.plot(i, np.mean(np.abs(layers[-1])), 'ro')
                plt.pause(0.001)
            cur_error = np.mean(np.abs(layers[-1]))
            if self.precision > abs(last_error - cur_error):
                break
            last_error = cur_error
        self.prediction = layers[-1]
        plt.draw()
        plt.pause(1)

    def _test(self, expected, prediction):
        count = 0
        for i in range(len(expected)):
            if expected[i] == np.argmax(prediction[i]):
                count += 1
        return count / len(expected)

    def get_train_error(self):
        '''
        Returns training error
        :return: training error between 0 and 1
        '''
        count = 0
        for i in range(len(self.expected)):
            if np.argmax(self.expected[i]) == np.argmax(self.prediction[i]):
                count += 1
        return count / len(self.expected)


    def predict(self,data_raw,expected_results):
        bias = 1

        data = np.zeros((np.array(data_raw).shape[0], np.array(data_raw).shape[1] + 1))
        bias = 1
        for i in range(np.array(data_raw).shape[0]):
            data[i] = np.append(data_raw[i], bias)

        cur_layer = (self.activate(np.dot(data, self.weights[0])));
        for k in range(1,self.layer_width + 1):
            cur_layer = (self.activate(np.dot(cur_layer, self.weights[k])))
        return self._test(expected_results,cur_layer)

    def get_settings(self):
        return [self.layer_width,self.layer_height,self.iteration,self.lr2]