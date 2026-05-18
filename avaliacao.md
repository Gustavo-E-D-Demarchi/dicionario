# Avaliacao do pedido vs rascunho (dicionario.pas)

## Esboco da estrutura
- Lista principal (dupla): ant <-> prox, key, ponteiro para dicionario
- Dicionario (simples): portugues, ingles, prox

## Requisitos do enunciado
- Lista principal ordenada alfabeticamente e com encadeamento duplo
- Lista de verbetes ordenada alfabeticamente
- Prototipo com: incluir palavra-chave, incluir no dicionario, remover do dicionario, consultar, escrever todo dicionario

## O que o rascunho ja tem
- Tipos com os campos corretos (lista + verbete)
- Rascunho de insercao ordenada na lista principal
- Funcoes de leitura (ler/ler_int) e loop principal com menu
- Consulta basica de chave na lista

## O que falta / fora de curva
- Insercao ordenada correta no dicionario (verbete) e ajuste de prox
- Operacoes completas: remover (lista e dicionario), consultar dicionario, consultar geral
- Impressao de todo o dicionario
- Validacoes basicas (entrada vazia, chave inexistente)

## Problemas tecnicos atuais
- adicionar_dicionario recebe record, mas usa como ponteiro (nil/prox) e mistura tipos (Tlista vs verbete)
- falta "then" em um if do consultar
- menu tem erros de sintaxe (falta ';', condicao vazia no else if)
- menu chama procedimentos sem passar parametros exigidos
- funcoes remover/consultar_geral nao existem
- em adicionar_lista, o novo no nao inicializa dicionario
