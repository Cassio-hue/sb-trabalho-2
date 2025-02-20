// Código Principal em Linguagem C.
#include <stdio.h>
#include <stdlib.h>

// Declaração das funções Assembly Intel IA-32 Bits NASM.
extern void verificar_memoria(int tamanho_programa, int *enderecos, int *tamanhos, int num_blocos);
// extern void imprimir_resultado(char *mensagem);

// Ler os argumentos da linha de comando.
int main(int argc, char *argv[]){

  // Verificar se o usuário passou a quantidade de argumentos corretamente na linha de comando.
  if ((argc != 4) && (argc != 6) && (argc != 8) && (argc != 10)){
    printf("[ERRO]: Número inválido de argumentos!\n");
    return 1;
  }

  // Converter os argumentos para números inteiros.
  int tamanho_programa = atoi(argv[1]);
  int num_blocos = (argc - 2) / 2;

  // Armazenar os argumentos em variáveis locais com alocação dinâmica.
  int *enderecos = (int *)malloc(num_blocos * sizeof(int));
  int *tamanhos = (int *)malloc(num_blocos * sizeof(int));

  // Imprimir os valores dos argumentos lidos da linha de comando.
  for (int i = 0; i < num_blocos; i++) {
    enderecos[i] = atoi(argv[2 + i * 2]);  // Endereço do bloco
    tamanhos[i] = atoi(argv[3 + i * 2]);  // Tamanho do bloco
  }


  // Chamar a função em Assembly para verificar a memória passando os argumentos pela pilha.
  verificar_memoria(tamanho_programa, enderecos, tamanhos, num_blocos);

  // Liberar a memória alocada
  free(enderecos);
  free(tamanhos);

  return 0;
}