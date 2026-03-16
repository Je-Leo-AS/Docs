#import "template.typ": *

#show: project.with(
  title: "Análise Espectral e de Coeficientes: Evidências para o Truncamento Polinomial Dependente do Atraso",
  authors: ("Leonardo Santos",),
)

= Objetivo

Este relatório apresenta as evidências experimentais que fundamentam a hipótese central do modelo _Memory Polynomial_ (MP) com truncamento polinomial dependente do atraso: a não linearidade dominante do amplificador de potência (PA) está concentrada no instante atual ($m = 0$), e os ramos de memória mais antigos contribuem progressivamente menos para o comportamento não linear do sistema. Essa observação justifica a adoção de ordens polinomiais decrescentes $P_0 <= P_1 <= P_2$, permitindo reduzir a complexidade computacional do modelo sem perda significativa de desempenho.

As evidências são organizadas em três análises complementares:

+ *Magnitude dos coeficientes* por ramo de memória;
+ *Sensibilidade do NMSE* a cada parâmetro de ordem $P_m$;
+ *Espectro do sinal de erro* residual.

= Fundamentação Teórica

== Modelo Memory Polynomial Clássico

O modelo MP clássico descreve a saída do PA como:

$ y(n) = sum_(p=1)^(P) sum_(m=0)^(M) h_(p,m) space x(n - m) lr(|x(n - m)|)^(p-1) $

onde $P$ é a ordem polinomial uniforme, $M$ é a profundidade de memória e $h_(p,m) in CC$ são os coeficientes complexos estimados por mínimos quadrados. A limitação desta formulação é que a mesma ordem $P$ é aplicada a todos os atrasos, independentemente de sua relevância não linear.

== Modelo MP com Truncamento Dependente do Atraso

A variação proposta neste trabalho define uma ordem polinomial máxima distinta para cada ramo de memória:

$ y(n) = sum_(m=0)^(M) sum_(p=1)^(P_m) h_(p,m) space x(n - m) lr(|x(n - m)|)^(p-1) $

onde o conjunto ${P_0, P_1, dots, P_M}$ substitui o único parâmetro $P$ do modelo clássico. O modelo MP tradicional é recuperado quando $P_0 = P_1 = dots = P_M = P$.

A hipótese de trabalho é que a escolha $P_0 > P_1 > dots > P_M$ é suficiente para capturar os efeitos não lineares dominantes do PA, concentrados majoritariamente na amostra atual, enquanto os termos de memória mais antigos requerem apenas baixa ordem polinomial.

== Métrica de Desempenho: NMSE

O desempenho de cada modelo é quantificado pelo _Normalized Mean Squared Error_ (NMSE):

$ "NMSE" = 10 log_10 lr(( frac(sum_(n=1)^(N) |e(n)|^2, sum_(n=1)^(N) |y_"real"(n)|^2) )) quad ["dB"] $

onde $e(n) = y_"real"(n) - y_"model"(n)$ é o erro de modelagem. Quanto mais negativo o valor em dB, maior a precisão do modelo.

= Configuração Experimental

Os dados utilizados foram adquiridos de um amplificador de potência classe AB, tecnologia GaN HEMT, operando a 900 MHz com sinal de envoltória WCDMA conforme o padrão 3GPP (largura de banda de 3,84 MHz). A aquisição foi realizada com um analisador vetorial de sinais Rohde & Schwarz a uma taxa de amostragem de 61,44 MHz.

A análise adota profundidade de memória $M = 2$, resultando em três ramos ($m = 0, 1, 2$) com ordens $P_0$, $P_1$ e $P_2$ variando de 1 a 5.

= Evidência 1 — Magnitude dos Coeficientes por Ramo de Memória

== Metodologia

Um modelo MP completo foi treinado com $P_0 = P_1 = P_2 = 5$ para expor todos os coeficientes estimados. Os coeficientes foram organizados em uma matriz $h_(p,m)$ de dimensão $(M+1) times P_"max"$ e avaliados segundo duas métricas:

- *Magnitude individual*: $|h_(p,m)|$ para cada par $(p, m)$;
- *Energia do ramo*: $E_m = sum_p |h_(p,m)|^2$, que quantifica a contribuição total do atraso $m$.

== Interpretação

Se a energia $E_m$ decresce com o atraso $m$, isso indica que o PA atribui pesos cada vez menores às amostras passadas — ou seja, a resposta não linear ao impulso do sistema decai com o tempo. Esse comportamento é a causa física direta que justifica a atribuição de ordens polinomiais menores aos ramos de memória mais antigos.

*Resultado esperado:* $E_0 >> E_1 > E_2$, confirmando que o ramo $m = 0$ concentra a não linearidade dominante do sistema.

#figure(
  
  image("assets/ev1_magnitude_coeficientes.png", width: 70%),

  caption: [Magnitude dos coeficientes $|h_(p,m)|$ e energia $E_m$ por ramo de memória.]
)

= Evidência 2 — Sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$

== Metodologia

Para isolar a contribuição de cada parâmetro, adota-se a seguinte estratégia: mantêm-se dois parâmetros fixos em 1 e varia-se o terceiro de 1 a $P_"max" = 5$. Três curvas NMSE são obtidas:

- *Curva de $P_0$*: $(P_0, 1, 1)$ com $P_0 in {1, dots, 5}$;
- *Curva de $P_1$*: $(1, P_1, 1)$ com $P_1 in {1, dots, 5}$;
- *Curva de $P_2$*: $(1, 1, P_2)$ com $P_2 in {1, dots, 5}$.

A *inclinação* de cada curva indica o potencial de ganho de NMSE ao aumentar a ordem daquele ramo específico.

== Interpretação

O ganho total $Delta "NMSE"_m = "NMSE"(P_m = 1) - "NMSE"(P_m = 5)$ quantifica o retorno obtido ao investir complexidade em cada ramo. Um $Delta$ grande em $P_0$ e pequeno em $P_2$ demonstra diretamente que:

- O ramo $m = 0$ ainda possui não linearidades a capturar quando sua ordem é aumentada;
- O ramo $m = 2$ satura rapidamente, contribuindo pouco para o ganho de modelagem.

Isso fornece justificativa quantitativa para concentrar a complexidade em $P_0$ e adotar ordens reduzidas para $P_1$ e $P_2$.

#figure(
  
  image("assets/ev2_sensibilidade_nmse.png", width: 70%),

  
  caption: [Sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$. A curva de $P_0$ apresenta maior inclinação, evidenciando que a não linearidade dominante está no instante atual.]
)

= Evidência 3 — Espectro do Sinal de Erro Residual

== Metodologia

O sinal de erro $e(n) = y_"real"(n) - y_"model"(n)$ é obtido no conjunto de validação para sete configurações de modelo. A densidade espectral de potência (PSD) do erro é estimada pelo método de Welch e apresentada em três painéis comparativos, um para cada parâmetro variado.

As configurações avaliadas são:

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  table.header([*Modelo*], [$P_0$], [$P_1$], [$P_2$]),
  [Referência],  [1], [1], [1],
  [Var. $P_0$ — baixa],  [3], [1], [1],
  [Var. $P_0$ — alta],   [5], [1], [1],
  [Var. $P_1$ — baixa],  [1], [3], [1],
  [Var. $P_1$ — alta],   [1], [5], [1],
  [Var. $P_2$ — baixa],  [1], [1], [3],
  [Var. $P_2$ — alta],   [1], [1], [5],
)

== Interpretação

O espectro do sinal de erro representa a distorção que o modelo *não conseguiu capturar*. Uma redução no nível espectral do erro — tanto na banda do sinal quanto nas bandas adjacentes (_regrowth_ espectral) — indica melhora direta na qualidade da modelagem.

*Resultado esperado:* O painel de variação de $P_0$ exibe o maior afundamento espectral do erro ao aumentar a ordem. Os painéis de $P_1$ e $P_2$ apresentam curvas praticamente sobrepostas, indicando ganho marginal com o aumento dessas ordens.

Essa evidência conecta diretamente o argumento de modelagem ao domínio da frequência, mostrando que um $P_0$ elevado é essencial para suprimir o _regrowth_ espectral residual — critério diretamente associado ao desempenho de sistemas DPD em termos de ACLR e conformidade com máscaras espectrais regulatórias.

#figure(
  
  image("assets/ev3_espectro_erro.png", width: 70%),
  
  caption: [Espectro do sinal de erro residual para variações de $P_0$, $P_1$ e $P_2$. O painel de $P_0$ apresenta o maior afundamento espectral, reforçando a dominância da não linearidade no instante atual.]
)

= Discussão Conjunta das Evidências

As três evidências apresentadas são complementares e convergem para a mesma conclusão:

*Evidência 1 (coeficientes)* estabelece a causa física: o PA responde predominantemente ao sinal atual. A energia dos coeficientes decai com o atraso, indicando que a resposta não linear ao impulso do sistema é de curta duração.

*Evidência 2 (NMSE)* quantifica o impacto no desempenho: o retorno ao aumentar $P_0$ é significativamente superior ao retorno de aumentar $P_1$ ou $P_2$. Isso demonstra que alocar complexidade no ramo $m = 0$ é a estratégia ótima de modelagem.

*Evidência 3 (espectro)* traduz o argumento para o domínio de frequência: um $P_0$ elevado suprime mais eficientemente o espectro do erro residual, tanto na banda quanto nas adjacências. Como a conformidade com máscaras espectrais é o requisito central dos sistemas DPD, essa evidência conecta diretamente o argumento estrutural à aplicação prática.

Em conjunto, essas análises sustentam a hipótese de que a distribuição de complexidade $P_0 <= P_1 <= P_2$ é não apenas eficiente computacionalmente, mas também fundamentada no comportamento físico do amplificador. Além disso, essa estrutura cria condições naturais para a adoção de arquiteturas híbridas: os termos de alta ordem associados a $m = 0$ — de maior custo aritmético — são candidatos naturais à substituição por tabelas de consulta (LUTs), enquanto os ramos de memória ($m <= 1$), com ordens menores, permanecem implementados de forma polinomial com baixo custo.

= Conclusão

Este relatório apresentou três evidências experimentais complementares que fundamentam a adoção de ordens polinomiais decrescentes no modelo MP com truncamento dependente do atraso. A análise da magnitude dos coeficientes, da sensibilidade do NMSE e do espectro do sinal de erro residual demonstram consistentemente que:

+ A não linearidade dominante do PA está concentrada no instante atual ($m = 0$);
+ Ramos de memória mais antigos saturam rapidamente com ordens polinomiais baixas;
+ A distribuição $P_0 <= P_1 <= P_2$ é a alocação ótima de complexidade para o modelo MP.

Esses resultados validam experimentalmente a proposta de truncamento polinomial dependente do atraso e fornecem suporte direto para a implementação de arquiteturas híbridas MP + LUT, conforme desenvolvido nos capítulos subsequentes da dissertação.
