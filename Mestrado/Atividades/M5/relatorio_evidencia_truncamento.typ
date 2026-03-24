#import "template.typ": *

#show: project.with(
  title: "Análise Espectral e de Coeficientes: Evidências para o Truncamento Polinomial Dependente do Atraso",
  authors: ("Leonardo Santos",),
)

= Objetivo

Este relatório apresenta as evidências experimentais que fundamentam a hipótese central do modelo _Memory Polynomial_ (MP) com truncamento polinomial dependente do atraso: a não linearidade dominante do amplificador de potência (PA) está concentrada no instante atual ($m = 0$), e os ramos de memória mais antigos contribuem progressivamente menos para o comportamento não linear do sistema.

Essa observação justifica a adoção de ordens polinomiais decrescentes $P_0 >= P_1 >= P_2$, permitindo reduzir a complexidade computacional do modelo sem perda significativa de desempenho.

As evidências são organizadas em três análises complementares, todas obtidas a partir do conjunto de dados `data_LDMOS_formatted_4500p.mat` (4.500 amostras de extração e 4.500 de validação), com profundidade de memória $M = 2$ e ordens polinomiais variando de 1 a 5:

+ *Magnitude dos coeficientes* por ramo de memória;
+ *Sensibilidade do NMSE* a cada parâmetro de ordem $P_m$;
+ *Espectro do sinal de erro* residual.

= Fundamentação Teórica

== Modelo Memory Polynomial Clássico

O modelo MP clássico descreve a saída do PA como:

$ y(n) = sum_(p=1)^(P) sum_(m=0)^(M) h_(p,m) space x(n - m) lr(|x(n - m)|)^(p-1) $

onde $P$ é a ordem polinomial uniforme, $M$ é a profundidade de memória e $h_(p,m) in CC$ são os coeficientes complexos estimados por mínimos quadrados. A limitação desta formulação é que a mesma ordem $P$ é aplicada a todos os atrasos, independentemente de sua relevância não linear.

== Modelo MP com Truncamento Dependente do Atraso

A variação proposta define uma ordem polinomial máxima distinta para cada ramo de memória:

$ y(n) = sum_(m=0)^(M) sum_(p=1)^(P_m) h_(p,m) space x(n - m) lr(|x(n - m)|)^(p-1) $

onde o conjunto ${P_0, P_1, dots, P_M}$ substitui o único parâmetro $P$ do modelo clássico. O modelo MP tradicional é recuperado quando $P_0 = P_1 = dots = P_M = P$.

== Métrica de Desempenho: NMSE

O desempenho de cada modelo é quantificado pelo _Normalized Mean Squared Error_ (NMSE):

$ "NMSE" = 10 log_10 lr(( frac(sum_(n=1)^(N) |e(n)|^2, sum_(n=1)^(N) |y_"real"(n)|^2) )) quad ["dB"] $

onde $e(n) = y_"real"(n) - y_"model"(n)$. Quanto mais negativo o valor em dB, maior a precisão do modelo.

= Configuração Experimental

Os experimentos foram conduzidos com os seguintes parâmetros:

#table(
  columns: (auto, auto),
  align: (left, left),
  table.header([*Parâmetro*], [*Valor*]),
  [Arquivo de dados],          [`data_LDMOS_formatted_4500p.mat`],
  [Amostras de extração],      [4.500],
  [Amostras de validação],     [4.500],
  [Frequência de amostragem],  [61,44 MHz],
  [Frequência central],        [900 MHz],
  [Profundidade de memória M], [2 (atrasos $m = 0, 1, 2$)],
  [Faixa de ordens avaliadas], [$P_m in {1, 2, 3, 4, 5}$],
  [Janela espectral],          [Blackman],
  [Tamanho da FFT],            [8192 pontos],
  [Média por blocos],          [50 amostras → resolução 0,375 MHz/ponto],
  [Correção de atenuação],     [+24 dB (cabo) + 30 dB (W→dBm)],
)

= Evidência 1 — Magnitude dos Coeficientes por Ramo de Memória

== Metodologia

Um modelo MP completo foi treinado com $P_0 = P_1 = P_2 = 5$, atingindo NMSE de $-38,47$ dB. Os coeficientes estimados $h_(p,m)$ foram organizados em uma matriz de dimensão $(M+1) times P_"max"$ e avaliados segundo a energia de cada ramo:

$ E_m = sum_(p=1)^(P_"max") |h_(p,m)|^2 $

== Resultados

Os valores de energia obtidos por ramo foram:

#table(
  columns: (auto, auto, auto),
  align: (center, center, center),
  table.header([*Atraso m*], [*Energia $E_m$*], [*Relativa a $m=0$*]),
  [$m = 0$], [20,5751], [100,0%],
  [$m = 1$], [13,7146], [66,7%],
  [$m = 2$], [4,8489],  [23,6%],
)

A energia decai monotonicamente com o atraso ($E_0 > E_1 > E_2$), confirmando que o PA responde predominantemente ao sinal atual. O ramo $m = 2$ concentra apenas 23,6% da energia do ramo $m = 0$, evidenciando que a contribuição não linear das amostras mais antigas é substancialmente menor.

#figure(
  image("assets/ev1_magnitude_coeficientes.png"),
  caption: [Magnitude dos coeficientes $|h_(p,m)|$ (esquerda) e energia $E_m$ por ramo de memória (direita). O decaimento de $E_0 = 20,58$ para $E_2 = 4,85$ evidencia que a não linearidade dominante está concentrada no instante atual.]
)

== Interpretação

O decaimento de energia ao longo dos ramos de memória é a causa física direta que justifica a atribuição de ordens polinomiais menores aos ramos mais antigos. Se $E_m$ cai com $m$, não há razão para manter uma ordem polinomial elevada em ramos que contribuem pouco para o comportamento não linear total do sistema.

= Evidência 2 — Sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$

== Metodologia

Para isolar a contribuição de cada parâmetro, dois parâmetros foram fixados em 1 enquanto o terceiro variou de 1 a 5. O ganho total $Delta "NMSE"_m = "NMSE"(P_m = 1) - "NMSE"(P_m = 5)$ quantifica o retorno obtido ao investir complexidade em cada ramo.

== Resultados

Os valores de NMSE obtidos, com ponto de partida comum em $-28,71$ dB (modelo com $P_0 = P_1 = P_2 = 1$), foram:

#table(
  columns: (auto, auto, auto, auto),
  align: (center, center, center, center),
  table.header([*Parâmetro variado*], [*NMSE em $P=1$*], [*NMSE em $P=5$*], [*Δ NMSE*]),
  [$P_0$], [$-28,71$ dB], [$-35,36$ dB], [*6,66 dB*],
  [$P_1$], [$-28,71$ dB], [$-32,14$ dB], [3,43 dB],
  [$P_2$], [$-28,71$ dB], [$-30,20$ dB], [1,49 dB],
)

#figure(
  image("assets/ev2_sensibilidade_nmse.png"),
  caption: [Sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$. A curva de $P_0$ apresenta a maior inclinação, com ganho de 6,66 dB, contra 3,43 dB de $P_1$ e apenas 1,49 dB de $P_2$.]
)

== Interpretação

O ganho de $P_0$ (6,66 dB) é 1,94× maior que o de $P_1$ (3,43 dB) e 4,47× maior que o de $P_2$ (1,49 dB). Isso demonstra quantitativamente que:

- O ramo $m = 0$ possui não linearidades relevantes até ordens polinomiais altas — justificando $P_0$ elevado;
- O ramo $m = 2$ satura rapidamente com ordem 2 ou 3, tornando ordens superiores computacionalmente custosas e de retorno marginal;
- A distribuição $P_0 > P_1 > P_2$ é a alocação ótima de complexidade para o modelo MP.

= Evidência 3 — Espectro do Sinal de Erro Residual

== Metodologia

O sinal de erro $e(n) = y_"real"(n) - y_"model"(n)$ foi obtido no conjunto de validação para sete configurações de modelo. A densidade espectral de potência (PSD) foi estimada pela metodologia do script MATLAB de referência: janela de Blackman, FFT de 8192 pontos normalizada por $N$, média por blocos de 50 amostras e eixo em frequência absoluta centrado em 900 MHz. Os modelos avaliados foram:

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  table.header([*Modelo*], [$P_0$], [$P_1$], [$P_2$], [*NMSE*]),
  [Referência],        [1], [1], [1], [$-28,71$ dB],
  [Var. $P_0$ baixa],  [3], [1], [1], [—],
  [Var. $P_0$ alta],   [5], [1], [1], [$-35,36$ dB],
  [Var. $P_1$ baixa],  [1], [3], [1], [—],
  [Var. $P_1$ alta],   [1], [5], [1], [$-32,14$ dB],
  [Var. $P_2$ baixa],  [1], [1], [3], [—],
  [Var. $P_2$ alta],   [1], [1], [5], [$-30,20$ dB],
)

== Resultados

#figure(
  image("assets/ev3_espectro_erro.png"),
  caption: [PSD do erro residual para variações de $P_0$ (esquerda), $P_1$ (centro) e $P_2$ (direita). O painel de $P_0$ exibe o maior afundamento espectral ao aumentar a ordem, tanto na banda quanto nas adjacências.]
)

#figure(
  image("assets/ev_bonus_psd_completo.png"),
  caption: [PSD comparativa: sinal de entrada, saída medida do PA e erros de modelagem de múltiplos modelos sobrepostos. Evidencia visualmente a redução do espalhamento espectral ao aumentar $P_0$.]
)

== Interpretação

O espectro do erro representa a distorção que o modelo não conseguiu capturar. A redução espectral observada no painel de $P_0$ é consistente tanto na banda do sinal (erro de modelagem AM/AM e AM/PM) quanto nas bandas adjacentes (_regrowth_ espectral residual). Nos painéis de $P_1$ e $P_2$, as curvas permanecem próximas, indicando que aumentar essas ordens traz pouco benefício espectral adicional.

Essa evidência é diretamente relevante para aplicações de pré-distorção digital (DPD): o _regrowth_ espectral não capturado pelo modelo se traduz em limitação do ACLR após a pré-distorção, afetando a conformidade com máscaras espectrais regulatórias.

= Discussão Conjunta das Evidências

As três evidências são complementares e convergem para a mesma conclusão:

*Evidência 1 — causa física:* a energia dos coeficientes decai de $E_0 = 20,58$ para $E_1 = 13,71$ e $E_2 = 4,85$. O PA atribui pesos progressivamente menores às amostras passadas, indicando que a resposta não linear ao impulso do sistema é de curta duração.

*Evidência 2 — impacto no desempenho:* o retorno de aumentar $P_0$ (Δ = 6,66 dB) é 4,47× maior que o de $P_2$ (Δ = 1,49 dB). Alocar complexidade no ramo $m = 0$ é a estratégia ótima de modelagem.

*Evidência 3 — domínio da frequência:* $P_0$ elevado suprime mais eficientemente o espectro do erro residual, tanto na banda quanto nas adjacências. Os painéis de $P_1$ e $P_2$ apresentam curvas praticamente sobrepostas.

Essa estrutura sustenta naturalmente a arquitetura híbrida MP + LUT: os termos de alta ordem associados a $m = 0$ — de maior custo aritmético — são candidatos naturais à substituição por tabelas de consulta (LUTs), enquanto os ramos de memória ($m >= 1$), com ordens menores, permanecem implementados polinomialmente com baixo custo computacional.

= Conclusão

As três evidências experimentais apresentadas demonstram consistentemente que:

+ A energia dos coeficientes decai com o atraso: $E_0 = 20,58 > E_1 = 13,71 > E_2 = 4,85$, confirmando memória não linear de curta duração;
+ O ganho de NMSE ao aumentar $P_0$ (6,66 dB) é 4,47x maior que ao aumentar $P_2$ (1,49 dB), demonstrando que a complexidade deve ser concentrada no instante atual;
+ O espectro do erro residual confirma no domínio da frequência que $P_0$ é o parâmetro dominante para supressão do _regrowth_ espectral.

Esses resultados validam experimentalmente a proposta de truncamento polinomial dependente do atraso com $P_0 >= P_1 >= P_2$ e fornecem suporte direto para a implementação de arquiteturas híbridas MP + LUT.
