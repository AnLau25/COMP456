#ifndef NETWORK_H//Guard that guards against multiple inclussion
#define NETWORK_H

#include <string>
#include <iostream>

class Network{
    
    private:
        int input, hyde, output;
        std::vector<std::vector<double>>weights_in; 
        std::vector<std::vector<double>>weights_out;

        std::vector<double>bias_hyde;
        std::vector<double>bias_out;
        
        std::vector<double> activation_hyde;
        std::vector<double> activation_out;
        
        std::vector<double> out_hyde;
        std::vector<double> out_predcited;

        
        
    public: 
        Network (int _input, int _hyde, int _output): input(_input), hyde(_hyde), output(_output),
        bias_hyde(hyde, 0.0), bias_out(output, 0.0),
        activation_hyde(hyde, 0.0), activation_out(output, 0.0) {

            initialWeights(weights_in, input, hyde);
            initialWeights(weights_out, hyde, output);
        }

        void initialWeights(std::vector<std::vector<double>>& weights, int rows, int cols){
            std::random_device rd; //Random seed
            std::mt19937 gen (rd()); //Mersenne twister
            std::normal_distribution<double>dist(0.0, 1.0); //Media de 0, std dev 1

            weights.resize(rows, std::vector<double>(cols)); //re-size the weights matrix

            for (int i = 0; i<rows; i++){ //Inputing random values 
                for (int j = 0; j<cols; j++){
                    weights[i][j] = dist(gen);
                }
            }
        }

        //sigmoid funtion and derivate
        static double sigmoid(double X){
            return 1.0 / (1.0 + std::exp(-X));
        } 

        static double sigmoid_derived(double X){
            return X * (1.0 - X);
        }

        std::vector<double> feedforward(const std::vector<double>& X){

            //hiden layer activation
            for (int i = 0; i < hyde; i++) {
                double sum = bias_hyde[i];
                for (int j = 0; j < input; j++) {
                    sum += X[j] * weights_in[j][i];
                }
                activation_hyde[i] = sigmoid(sum);
            }

            //output layer activation
            for (int i = 0; i < output; i++) {
                double sum = bias_out[i];
                for (int j = 0; j < hyde; j++) {
                    sum += activation_hyde[j] * weights_out[j][i];
                }
                activation_out[i] = sigmoid(sum);
            }
            
            return activation_out;
        }

        void backward(const std::vector<double>& X, const std::vector<double>& y, double learning_rate){

            //output layer error
            std::vector<double> out_error(output);
            std::vector<double> out_delta(output);
            for (int i = 0; i<output; i++){
                out_error[i] = y[i] - activation_out[i];
                out_delta[i] = out_error[i] * sigmoid_derived(activation_out[i]);
            }

            //hyden layer error
            std::vector<double> hyde_error(hyde, 0.0);
            std::vector<double> hyde_delta(hyde, 0.0);
            for (int i = 0; i<hyde; i++){
                double sum = 0.0;
                for (int j = 0; j<output; j++ ){
                    sum += out_delta[j] * weights_out[i][j];
                }
                hyde_error[i] = sum;
                hyde_delta[i] = hyde_error[i] * sigmoid_derived(activation_hyde[i]);
            }

            //output weight update
            for (int i =0; i<hyde; i++){
                for(int j=0; j<output; j++){
                    weights_out[i][j] += learning_rate * out_delta[j] * activation_hyde[i];
                }
            }

            //hidden weights update
            for (int i =0; i<input; i++){
                for(int j=0; j<hyde; j++){
                    weights_in[i][j] += learning_rate * hyde_delta[j] * X[i];
                }
            }

            //bias update
            for (int i = 0; i<output; i++){
                bias_out[i] += learning_rate*out_delta[i];
            }
            for (int i = 0; i<hyde; i++){
                bias_hyde[i] += learning_rate*hyde_delta[i];
            }
        }

        double meanSquaredError(const std::vector<double>& y, const std::vector<double>& output) {
            double sum = 0.0;
            for (size_t i = 0; i < y.size(); ++i) {
                sum += std::pow(y[i] - output[i], 2);
            }
            return sum / y.size();
        }

        void train(std::vector<std::vector<double>>& X, std::vector<std::vector<double>>& y, int iters,double learning_rate){
            for (int i= 0; i<iters; ++i){
                double total_loss = 0.0;
                for (size_t j = 0; j<X.size(); j++){
                    std::vector<double> output = feedforward(X[j]);
                    backward(X[j],y[j], learning_rate);
                    total_loss +=meanSquaredError(y[j], output);
                }
                if (i%4000==0){
                    std::cout<<"Iter "<<i<<", Loss: "<<total_loss/X.size()<< std::endl;
                }
            }
        }
};

#endif // NETWORK_H