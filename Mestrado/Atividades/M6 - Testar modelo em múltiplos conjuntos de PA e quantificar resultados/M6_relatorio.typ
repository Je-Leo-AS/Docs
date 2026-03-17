#import "template.typ": *

#show: project.with(
  title: "Relatório Atividade M6 [EXPERIMENTAL]",
  authors: ("Leonardo Santos",),
)

== Objetivo

O objetivo desta atividade foi avaliar a capacidade de *generalização* do
modelo _Memory Polynomial_ (MP) com ordem polinomial dependente do atraso,
testando-o em *dois conjuntos de dados distintos* de amplificadores de
potência reais. Para isso, o _pipeline_ completo de identificação e
avaliação desenvolvido nas atividades anteriores foi replicado de forma
independente sobre cada conjunto, permitindo quantificar e comparar o
desempenho dos 125 modelos avaliados em cada cenário.

A motivação central é verificar se os padrões observados anteriormente —
em especial a relevância da ordem $P_0$ e a eficiência dos modelos com
distribuição decrescente de ordens — se mantêm estáveis diante de
amplificadores com tecnologias e características distintas.

== Descrição dos Conjuntos de Dados

Foram utilizados dois conjuntos de dados de medições experimentais:

*Conjunto 1 — `in_out_SBRT2_direto.mat`* (PA GaN HEMT)
- Amplificador classe AB, tecnologia GaN HEMT
- Frequência central: 900 MHz
- Sinal de modulação: WCDMA 3GPP, largura de banda ≈ 3,84 MHz
- Taxa de amostragem: 61,44 MSps
- Estrutura: vetores complexos `in_extraction`, `out_extraction`,
  `in_validation`, `out_validation`

*Conjunto 2 — `data_LDMOS_formatted_4500p.mat`* (PA LDMOS)
- Amplificador de tecnologia LDMOS
- Estrutura: vetores complexos `in_extraction`, `out_extraction`,
  `in_validation`, `out_validation` (4500 amostras por partição)

Os dois conjuntos representam tecnologias de amplificação distintas,
tornando a comparação relevante para avaliar a robustez da metodologia
frente a variações nas características do dispositivo sob teste.

== Metodologia

A metodologia aplicada em ambos os notebooks é idêntica à desenvolvida
nas atividades M4 e M5, com profundidade de memória fixa $M = 2$ e
varredura exaustiva de todas as combinações de ordens polinomiais
$(P_0, P_1, P_2)$ com $P_m in {1, 2, 3, 4, 5}$, totalizando
$5^3 = 125$ modelos por conjunto.

*1. Identificação dos coeficientes*

Para cada combinação de ordens, os coeficientes complexos do modelo MP
foram estimados por mínimos quadrados não lineares sobre o conjunto de
extração, minimizando:

$ J = sum_n |e(n)|^2, quad e(n) = y_"out"(n) - y_"est"(n) $

A otimização foi realizada com `scipy.optimize.least_squares` (Python),
com coeficientes iniciais nulos.

*2. Avaliação por NMSE*

O desempenho de cada modelo foi avaliado no conjunto de validação
(dados não utilizados no treinamento), pela métrica NMSE:

$ "NMSE" = 10 log_10 lr(( frac(sum_(n=1)^N |e(n)|^2,
sum_(n=1)^N |y_"real"(n)|^2) )) $

Quanto mais negativo o NMSE em dB, maior a precisão do modelo.

== Configuração dos Experimentos

#table(
  columns: (auto, auto, auto),
  align: center,
  table.header(
    [*Parâmetro*], [*Conjunto 1 (GaN)*], [*Conjunto 2 (LDMOS)*],
  ),
  [Arquivo de dados],
  [`in_out_SBRT2_direto.mat`], [`data_LDMOS_formatted_4500p.mat`],

  [Profundidade de memória ($M$)],
  [2], [2],

  [Ordens avaliadas ($P_m$)],
  [1 a 5 por atraso], [1 a 5 por atraso],

  [Total de modelos],
  [125], [125],

  [Número de ramos ($M + 1$)],
  [3], [3],

  [Aritmética],
  [Ponto flutuante], [Ponto flutuante],

  [Otimizador],
  [`least_squares` (SciPy)], [`least_squares` (SciPy)],
)

== Resultados

=== Panorama Geral dos 125 Modelos

A tabela abaixo resume o desempenho dos 125 modelos em cada conjunto:

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  table.header(
    [*Métrica*],
    [*Conjunto 1 — GaN*],
    [*Conjunto 2 — LDMOS*],
    [*Diferença (dB)*],
  ),
  [NMSE melhor modelo],
  [−26,11 dB], [−37,53 dB], [11,42],

  [NMSE pior modelo],
  [−21,41 dB], [−28,71 dB], [7,30],

  [NMSE médio],
  [−25,21 dB], [−35,20 dB], [9,99],

  [Modelo P\=[1,1,1] (3 coef.)],
  [−21,66 dB], [−28,71 dB], [7,05],

  [Modelo P\=[3,3,3] (9 coef.)],
  [−25,95 dB], [−35,25 dB], [9,30],

  [Modelo P\=[5,5,5] (15 coef.)],
  [−26,10 dB], [−37,51 dB], [11,41],
)

O Conjunto 2 (LDMOS) apresentou desempenho sistematicamente superior em
todos os modelos, com NMSE médio cerca de *10 dB mais negativo* do que
o Conjunto 1 (GaN). Essa diferença absoluta de desempenho reflete as
características distintas de cada amplificador — em particular, o grau
de não linearidade e a profundidade de memória efetiva do dispositivo
sob as condições de medição utilizadas.

=== Influência da Ordem Polinomial por Atraso

Em ambos os conjuntos, a ordem polinomial $P_0$ — associada ao instante
atual ($m = 0$) — mostrou-se o fator de maior impacto no NMSE. O
aumento de $P_0$ de 1 para 2 já produz ganhos expressivos nos dois casos:

- *GaN:* de −21,66 dB ($P_0 = 1$) para −23,19 dB ($P_0 = 2$),
  ganho de ≈ 1,5 dB
- *LDMOS:* de −28,71 dB ($P_0 = 1$) para −33,03 dB ($P_0 = 2$),
  ganho de ≈ 4,3 dB

As ordens $P_1$ e $P_2$ têm impacto menor e decrescente, confirmando
que a não linearidade dominante está concentrada no instante atual
em ambas as tecnologias.

=== Modelos com Distribuição Decrescente ($P_0 >= P_1 >= P_2$)

Os modelos que respeitam a restrição $P_0 >= P_1 >= P_2$ concentram
a maioria das soluções de maior desempenho em ambos os conjuntos.
A tabela abaixo apresenta exemplos representativos:

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  table.header(
    [*Ordens $(P_0, P_1, P_2)$*],
    [*Nº coef.*],
    [*NMSE GaN (dB)*],
    [*NMSE LDMOS (dB)*],
    [*Diferença (dB)*],
  ),
  [\[3, 2, 1\]], [6],  [−25,53], [−34,75], [9,22],
  [\[3, 3, 2\]], [8],  [−25,60], [−35,24], [9,64],
  [\[4, 3, 2\]], [9],  [−25,64], [−36,31], [10,67],
  [\[5, 3, 2\]], [10], [−25,49], [−37,00], [11,51],
  [\[5, 4, 3\]], [12], [−26,07], [−37,44], [11,37],
  [\[5, 5, 5\]], [15], [−26,10], [−37,51], [11,41],
)

Esse padrão reforça a hipótese de que a complexidade polinomial deve
ser alocada prioritariamente no instante atual, com redução progressiva
nos atrasos mais antigos — e esse comportamento se mantém independente
da tecnologia do amplificador.

== Análise de Generalização

A comparação entre os dois conjuntos revela os seguintes comportamentos:

*Padrões preservados em ambas as tecnologias:*

- A ordem $P_0$ é o principal determinante de desempenho nos dois casos.
- Modelos com distribuição decrescente ($P_0 >= P_1 >= P_2$) concentram
  as melhores soluções em ambos os conjuntos.
- O ganho marginal ao adicionar coeficientes além de 9–10 é pequeno
  nas duas tecnologias.
- A saturação de desempenho ocorre em faixas similares de complexidade.

*Diferenças observadas:*

- O nível absoluto de NMSE é ≈ 10 dB melhor no LDMOS, sugerindo que
  esse amplificador possui memória efetiva menos profunda ou
  não linearidades mais bem capturadas pela estrutura MP com $M = 2$.
- O ganho ao aumentar $P_0$ é proporcionalmente maior no LDMOS (≈ 4,3 dB
  vs. ≈ 1,5 dB na transição $P_0$: 1→2), indicando maior sensibilidade
  à ordem polinomial no instante atual para esse dispositivo.
- A faixa de variação de NMSE entre o melhor e o pior modelo é mais ampla
  no LDMOS (8,82 dB) do que no GaN (4,70 dB), sugerindo que a escolha
  das ordens tem impacto proporcionalmente maior nesse caso.

== Conclusão

Esta atividade demonstrou que o modelo _Memory Polynomial_ com ordem
polinomial dependente do atraso exibe *comportamento consistente e
generalizável* entre diferentes tecnologias de amplificadores de potência.
Os padrões estruturais identificados no Conjunto 1 (GaN HEMT) — relevância
de $P_0$, eficiência dos modelos com ordens decrescentes e saturação de
desempenho em baixa complexidade — foram integralmente reproduzidos no
Conjunto 2 (LDMOS), ainda que com níveis absolutos de NMSE distintos.

Esses resultados fortalecem a validade da abordagem proposta e indicam que
as configurações ótimas identificadas pela análise de Pareto são robustas
frente a variações no tipo de amplificador, tornando-as candidatas
confiáveis para uso nas etapas subsequentes do trabalho — em particular
na implementação via LUTs e na análise em aritmética de ponto fixo.

== Próxima Etapa

Com a generalização do modelo validada em dois conjuntos de dados, a
próxima etapa consiste em estender a análise para a implementação do
modelo MP com tabelas de consulta (LUTs), avaliando o impacto da
granularidade das tabelas e das estratégias de interpolação no NMSE,
utilizando ambos os conjuntos como referência de desempenho.
