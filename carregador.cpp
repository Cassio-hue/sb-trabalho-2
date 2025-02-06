#include <iostream>
#include <bits/c++config.h>

using namespace std;

extern "C" int soma(int a, int b);

int main(int argc, char *argv[]) {

    if (argc % 2 == 0) {
        cout << "Número de argumentos inválido" << endl;
        return 1;
    }

    // cout << "Length of array = " << argc << endl;
    // for (int i = 0; i < argc; i++) {
    //     cout << "argv[" << i << "] = " << argv[i] << endl;
    // }

    int resultado = soma(10, 5);
    cout << "Soma (Assembly externo): " << resultado << endl;


    return 0;
}