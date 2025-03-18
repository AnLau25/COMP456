#ifndef NETWORK_H//Guard that guards against multiple inclussion
#define NETWORK_H

#include <string>
#include <iostream>

class Network{
    
    private:
        int input, hyde, output;
        std::vector<std::vector<double>>weights_in; 
        std::vector<std::vector<double>>weights_out; 


    public: 
        Network (int _input, int _hyde, int _output){
            input = _input; 
            hyde = _hyde; 
            output = _output;
            initialWeights(weights_in, input, hyde);
            initialWeights(weights_out, hyde, output);

        }

        void initialWeights(std::vector<std::vector<double>>& matrix, int rows, int cols){
            std::random_device rd; //Random seed
            std::mt19937 gen (rd()); //Mersenne twister
            std::normal_distribution<double>dist(0.0, 1.0); //Media de 0, std dev 1

            matrix.resize(rows, std::vector<double>(cols)); //re-size the matrix

            for (int i = 0; i<rows; i++){ //Inputing random values 
                for (int j = 0; j<cols; j++){
                    matrix[i][j] = dist(gen);
                }
            }
        }

        static double sigmoid(double X){
            return 1.0 / (1.0 + std::exp(-X));
        } 

        static double sigmoid_derived(double X){
            return X * (1.0 - X);
        }

        
};

#endif // NETWORK_H