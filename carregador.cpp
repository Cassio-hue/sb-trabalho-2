#include <iostream>

using namespace std;

extern "C" int calcular_espaco(int programa, int num_enderecos, int* blocos);

int main(int argc, char *argv[]) {
    int programa = atoi(argv[1]);
    int num_enderecos = (argc - 2) / 2;
    int* blocos = new int[num_enderecos * 2];

    if (argc % 2 != 0 || argc < 3) {
        cout << "Número de argumentos inválido" << endl;
        return 1;
    }

    for (int i = 0; i < num_enderecos * 2; i++) {
        blocos[i] = atoi(argv[i + 2]);
    }

    calcular_espaco(programa, num_enderecos, blocos);
    delete[] blocos;

    return 0;
}