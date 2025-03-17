#ifndef DRIVER_H//Guard that guards against multiple inclussion
#define DRIVER_H

#include <string>
#include <iostream>

class Driver{
    //Proprietà
    private:
        std::string nom{"Waiting for name"};
        int num{0};
        int pts{0};

    //Behaviors
    public: 
        Driver() = default;//Construttore vuoto
        //Es lo mismo que poner los valores default aca
        Driver (std::string _nom, int _num, int _pts);

        //Getters
        std::string get_nom();

        int get_num();

        int get_pts();

        //Setters
        void set_nom(std::string _nom);

        void set_num(int _num);

        void set_pts(int _pts);

        void Display();
};

#endif // DRIVER_H