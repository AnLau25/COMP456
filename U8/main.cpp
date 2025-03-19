#include <iostream>
#include <ios>
#include <iomanip>
#include <string>
#include <cmath>//PI
#include <cstring> // Required for std::strlen
#include <vector>
#include <random>
#include "network.h"




int main() {
    // Define network with 2 input neurons, 3 hidden neurons, and 1 output neuron
    Network nn(2, 2, 1);

    // XOR dataset
    std::vector<std::vector<double>> X = { {0, 0}, {0, 1}, {1, 0}, {1, 1} };
    std::vector<std::vector<double>> y = { {0}, {1}, {1}, {0} };

    // Train the network
    nn.train(X, y, 20000, 0.1);

    std::cout<<"Predictions after traing:"<<std::endl;
    for (const auto& sample : X) {
        std::vector<double> output = nn.feedforward(sample);
        for (double val : output) {
            std::cout << val << " ";
        }
        std::cout << std::endl;
    }

    std::cout<<"Nano!"<<std::endl;
    
    return 0;
}

/*
    Backpropagation:
    Layered perceptron network
    Works just like a perceptron, just many??

    XOR Table:
    1 1 --> 0
    1 0 --> 1
    0 1 --> 1
    0 0 --> 0
*/