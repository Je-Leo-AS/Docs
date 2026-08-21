# Roteiro de fala - Apresentacao CASW

## Slide 1 - Titulo

Bom dia. Nesta apresentacao, abordarei a modelagem comportamental de amplificadores de potencia de radiofrequencia por meio de polinomios com memoria e ordens polinomiais dependentes do atraso. A ideia central e que diferentes atrasos de memoria nao contribuem da mesma forma para a resposta do amplificador. Por isso, nao precisam receber a mesma complexidade no modelo. Ao longo da apresentacao, mostrarei como essa abordagem afeta a precisao da modelagem, o comportamento espectral e o custo de implementacao em hardware.

## Slide 2 - Why PA Modeling Matters

O amplificador de potencia, ou PA, e um componente fundamental do transmissor sem fio. Para melhorar a eficiencia energetica, e desejavel opera-lo proximo da saturacao. Entretanto, nessa regiao, as nao linearidades se tornam mais intensas e produzem distorcao dentro da banda e crescimento espectral nas bandas adjacentes.

Em sinais de banda larga, tambem surgem efeitos de memoria eletricos e termicos. Isso significa que a saida do amplificador depende tanto da amostra atual quanto de amostras anteriores. A pre-distorcao digital, conhecida como DPD, e utilizada para compensar esse comportamento, mas depende de um modelo comportamental preciso do PA. Assim, o desafio de engenharia e manter uma boa precisao sem tornar a implementacao digital em tempo real excessivamente cara.

## Slide 3 - The Limitation of the Classic MP

O polinomio com memoria classico, ou MP, representa a saida como uma soma de funcoes de base nao lineares para diferentes atrasos. Uma de suas principais vantagens e permanecer linear em relacao aos coeficientes, permitindo que eles sejam estimados de maneira simples pelo metodo dos minimos quadrados.

A limitacao e que o modelo classico utiliza a mesma ordem polinomial maxima em todos os atrasos. Essa escolha pressupoe que a amostra atual e todas as amostras anteriores precisam do mesmo nivel de detalhamento nao linear. Na pratica, a amostra atual costuma apresentar a contribuicao mais forte, enquanto os atrasos mais antigos tendem a ter menor relevancia. Portanto, uma ordem uniforme pode acrescentar coeficientes, operacoes e registradores que oferecem pouco ganho de precisao.

## Slide 4 - Delay-dependent Polynomial Orders

A proposta substitui a unica ordem maxima P por uma ordem especifica P indice m para cada atraso de memoria. Quando todas as ordens sao iguais, o modelo se reduz ao polinomio com memoria classico.

Essa modificacao nao altera a linearidade em relacao aos coeficientes. Consequentemente, ainda podemos utilizar minimos quadrados para a identificacao. O que muda e a quantidade de termos e a composicao da matriz de regressao.

A hipotese adotada e um perfil decrescente de ordens: uma ordem elevada para a amostra atual, uma ordem intermediaria para o primeiro atraso e uma ordem menor para o segundo. Em outras palavras, P zero maior ou igual a P um, que por sua vez e maior ou igual a P dois. Dessa forma, a complexidade e distribuida conforme a relevancia esperada de cada ramo de memoria.

## Slide 5 - Experimental Method

A avaliacao utilizou dados de dois amplificadores diferentes: um PA LDMOS e um PA GaN HEMT classe AB. Para o LDMOS, foram utilizadas 4.500 amostras complexas na extracao e outras 4.500 na validacao. O amplificador GaN foi excitado por um sinal WCDMA 3GPP, com portadora de 900 megahertz, largura de banda de 3,84 megahertz e taxa de amostragem de 61,44 megamostras por segundo.

A profundidade de memoria escolhida foi dois, incluindo a amostra atual e dois atrasos. Cada uma das ordens P zero, P um e P dois variou independentemente entre um e cinco, resultando em 125 configuracoes. Para cada configuracao, foi construida a matriz de regressao, os coeficientes foram estimados por minimos quadrados e o modelo foi avaliado com amostras independentes.

A principal metrica foi o erro quadratico medio normalizado, ou NMSE. Quanto mais negativo o valor em decibeis, melhor o ajuste. Algumas estruturas tambem foram implementadas em VHDL de ponto fixo, validadas com GHDL e sintetizadas com Yosys.

## Slide 6 - Sensitivity Is Concentrated at the Current Sample

Este experimento analisa separadamente o efeito de aumentar a ordem de cada ramo. O resultado confirma a hipotese principal. O aumento de P zero, correspondente a amostra atual, proporciona uma melhora de 6,66 decibeis no NMSE. Para o primeiro atraso, a melhora e de 3,43 decibeis e, para o segundo, de apenas 1,49 decibel.

Isso mostra que adicionar complexidade em diferentes ramos nao produz o mesmo beneficio. A complexidade aplicada a amostra atual e consideravelmente mais valiosa do que aquela aplicada aos atrasos mais antigos. A consequencia pratica e que podemos reduzir as ordens desses atrasos e ainda preservar grande parte da capacidade de modelagem.

## Slide 7 - Accuracy with Fewer Coefficients

A tabela compara alguns perfis de ordem nos dois conjuntos de dados. O modelo completo cinco, cinco, cinco possui 15 coeficientes e apresenta o melhor NMSE absoluto. Entretanto, configuracoes com ordens decrescentes chegam muito perto desse resultado utilizando menos termos.

Para o amplificador GaN, o modelo quatro, tres, dois utiliza nove coeficientes, uma reducao de 40 por cento, e fica apenas 0,46 decibel abaixo do modelo completo. Para o LDMOS, o modelo cinco, tres, dois utiliza dez coeficientes, uma reducao de 33 por cento, e fica a somente 0,51 decibel do modelo completo.

O perfil mais adequado pode variar conforme o dispositivo, mas o resultado geral permanece: as ordens decrescentes preservam a maior parte da precisao. Assim, o modelo com o menor NMSE nem sempre representa a melhor escolha de engenharia.

## Slide 8 - The Improvement Is Also Spectral

Embora o NMSE seja calculado no dominio do tempo, tambem e importante observar o comportamento no dominio da frequencia. A figura compara o espectro medido e os espectros do erro de modelagem para diferentes configuracoes.

Os resultados espectrais seguem a mesma tendencia observada no NMSE. O aumento da ordem nos ramos mais relevantes reduz o erro tanto proximo da banda principal quanto nas regioes adjacentes. Por outro lado, aumentar as ordens dos atrasos menos relevantes oferece uma melhoria comparativamente pequena. Esse resultado e importante porque a reducao do erro nas bandas adjacentes esta diretamente relacionada aos objetivos da pre-distorcao digital.

## Slide 9 - Hardware Cost Follows Structural Complexity

Em seguida, avaliamos se a reducao matematica tambem produz uma vantagem concreta na implementacao. As arquiteturas foram descritas em VHDL de ponto fixo, comparadas com a referencia em Python, validadas com GHDL e sintetizadas com Yosys.

Considerando a arquitetura cinco, cinco, cinco como 100 por cento, a implementacao cinco, tres, dois utiliza aproximadamente 60 por cento das celulas e dos registradores. A versao quatro, tres, dois utiliza cerca de 58 por cento. A economia nao ocorre apenas no armazenamento dos coeficientes: a remocao dos termos de ordem mais alta tambem reduz produtos parciais, a profundidade das somas e a quantidade de registradores intermediarios.

Assim, o modelo cinco, tres, dois reduz em aproximadamente 40 por cento os principais recursos de sintese, mantendo o NMSE do LDMOS a apenas 0,51 decibel do modelo completo. Esses resultados ainda sao de sintese logica; nao foi utilizado um FPGA especifico nem realizado place-and-route, portanto medidas de temporizacao e potencia ficam como trabalho futuro.

## Slide 10 - Pareto Frontier: The Design Decision

A fronteira de Pareto torna explicita a relacao entre precisao e complexidade. Um modelo e Pareto-otimo quando nao e possivel melhorar sua precisao sem aumentar a complexidade, nem reduzir sua complexidade sem perder precisao.

Modelos como quatro, tres, dois e cinco, tres, dois ocupam uma regiao de compromisso interessante. Configuracoes que mantem ordens elevadas nos ramos de memoria menos relevantes consomem mais recursos sem produzir uma melhora proporcional no NMSE.

Com base nisso, uma regra pratica de projeto e iniciar com uma ordem elevada na amostra atual e reduzir progressivamente as ordens ao longo da memoria. O perfil final, naturalmente, deve ser validado para o dispositivo e para a condicao de operacao considerados.

## Slide 11 - Takeaways

Podemos destacar tres conclusoes principais. Primeiro, a relevancia nao linear diminui ao longo dos atrasos analisados, e a amostra atual e responsavel pelo maior ganho de NMSE. Segundo, as ordens dependentes do atraso preservam a maior parte da precisao do polinomio com memoria classico nos conjuntos de dados GaN e LDMOS. Terceiro, a reducao estrutural se converte em economia concreta de hardware, chegando a aproximadamente 40 por cento nos principais recursos de sintese para os modelos selecionados.

A mensagem principal e que a complexidade polinomial deve ser distribuida de acordo com a relevancia de cada atraso, e nao de maneira uniforme. Essa abordagem oferece um caminho direto para modelos comportamentais mais compactos e adequados a implementacoes de pre-distorcao digital em tempo real. Obrigado pela atencao.
