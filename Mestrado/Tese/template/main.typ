#import "../src/lib.typ": *

#set math.equation(numbering: "(1)")

#show: template.with(
  title: [
    Modelagem Comportamental e Implementação em VHDL de Amplificadores de Potência Usando Polinômios com Memória
  ],
  title-foreign: [
    Behavioral Modeling and VHDL Implementation of Power Amplifiers Using Memory Polynomials
  ],

  lang: "pt",
  lang-foreign: "en",

  author: [Leonardo de Andrade Santos],
  city: [Curitiba],
  year: [2026],

  institution: "template/assets/logo-ufpr.png",

  description: [
    Dissertação apresentada ao Programa de Pós-Graduação em Engenharia Elétrica, Área de
    Concentração em Telecomunicações, Departamento de Engenharia Elétrica, Setor de
    Tecnologia, Universidade Federal do Paraná, como parte das exigências para obtenção do
    título de Mestre em Engenharia Elétrica.

    Orientadores: Eduardo Gonçalves de Lima, Sibilla Batista da Luz Franca
  ],

  keywords: ([DPD], [Polinômio de memória], [VHDL]),
  keywords-foreign: ([DPD], [Memory polynomial], [VHDL]),

  outline-figure: true,
  outline-table: true,

  abbreviations: (
    [DPD],   [Pré-Distorcedor Digital],
    [FPGA],  [Field-Programmable Gate Array (Matriz de Portas Programáveis em Campo)],
    [PA],    [Amplificador de Potência],
    [RF],    [Radio Frequency (Rádio Frequência)],
    [PARF],  [Amplificador de Potência de Rádio Frequência],
    [HDL],   [Hardware Description Language (Linguagem de Descrição de Hardware)],
    [VHSIC], [Very High-Speed Integrated Circuit (Circuito Integrado de Velocidade Muito Elevada)],
    [VHDL],  [VHSIC Hardware Description Language],
    [SOP],   [Sum of Products (Soma de Produtos)],
    [LAB],   [Logic Array Block],
    [ALM],   [Adaptive Logic Module],
    [LE],    [Logic Element],
    [HEMT],  [High Electron Mobility Transistor (Transistor de Efeito de Campo de Heterojunção)],
    [VSA],   [Vector Signal Analyzer (Analisador de Sinal Vetorial)],
    [NMSE],  [Normalized Mean Squared Error (Erro Médio Quadrado Normalizado)],
  ),
)

// ─────────────────────────────────────────────────────────────────────────────
// RESUMO
// ─────────────────────────────────────────────────────────────────────────────

#abstract[
A evolução dos sistemas de comunicação sem fio possibilitou o surgimento de diversas aplicações
móveis e wireless, como desenvolvimento web e Internet das Coisas (IoT). Nesse contexto, a
melhoria da eficiência energética é altamente desejável, tanto em dispositivos móveis, que buscam
maior autonomia de bateria, quanto em estações rádio-base, que visam reduzir perdas associadas
à dissipação de calor. Entretanto, o aumento da eficiência energética geralmente implica a redução
da linearidade dos amplificadores de potência (PAs) utilizados nos transmissores de rádio. Essa
limitação é particularmente crítica em sistemas modernos de comunicação, nos quais a largura de
banda disponível é restrita e o uso de modulações complexas, que exploram variações simultâneas
de amplitude e fase, é essencial para alcançar elevadas taxas de transmissão. Modulações sensíveis
à amplitude tornam-se especialmente suscetíveis às não linearidades do PA, resultando em
degradação do desempenho e aumento dos erros de transmissão.

Uma solução amplamente empregada para conciliar eficiência energética e linearidade é a utilização
da pré-distorção digital (Digital Predistortion --- DPD) em cascata com o PA. A eficácia dessa
técnica depende diretamente da disponibilidade de modelos matemáticos capazes de representar
com precisão o comportamento não linear e com memória do amplificador. Neste trabalho,
inicialmente investiga-se uma variação do modelo Memory Polynomial (MP), na qual a ordem
polinomial passa a depender do atraso de memória, permitindo maior flexibilidade na modelagem e
redução da complexidade computacional sem prejuízo significativo de desempenho. Além da
avaliação em software, o trabalho investiga a implementação desse modelo em VHDL, com
validação funcional em ponto fixo e análise da complexidade estrutural obtida na síntese lógica.
]

// ─────────────────────────────────────────────────────────────────────────────
// ABSTRACT
// ─────────────────────────────────────────────────────────────────────────────

#abstract-foreign[
The evolution of wireless communication systems has enabled the emergence of various mobile and
wireless applications, such as web development and the Internet of Things (IoT). In this context,
improving energy efficiency is highly desirable, both for mobile devices seeking greater battery life
and for radio base stations aiming to reduce losses associated with heat dissipation. However,
increasing energy efficiency generally implies reducing the linearity of power amplifiers (PAs) used
in radio transmitters. This limitation is particularly critical in modern communication systems, where
the available bandwidth is restricted and the use of complex modulations, exploiting simultaneous
amplitude and phase variations, is essential to achieve high transmission rates. Amplitude-sensitive
modulations are especially susceptible to PA nonlinearities, resulting in performance degradation
and increased transmission errors.

A widely used solution to reconcile energy efficiency and linearity is the use of digital predistortion
(DPD) in cascade with the PA. The effectiveness of this technique depends directly on the
availability of mathematical models capable of accurately representing the nonlinear and memory
behavior of the amplifier. This work investigates a variation of the Memory Polynomial (MP) model,
in which the polynomial order depends on the memory delay, allowing greater modeling flexibility
and reduced computational complexity without significant performance loss. In addition to the
software-based evaluation, the work investigates the VHDL implementation of this model,
including fixed-point functional validation and an analysis of the structural complexity obtained
after logic synthesis.
]

// ═════════════════════════════════════════════════════════════════════════════
= Introdução
// ═════════════════════════════════════════════════════════════════════════════

A evolução dos sistemas de comunicação móveis, impulsionada pela crescente demanda por
comunicações mais rápidas e eficientes, tem levado à implementação de uma variedade de
serviços, incluindo aplicações multimídia, desenvolvimento web e aplicações IoT @Yu2024. No
entanto, essa evolução também trouxe desafios significativos, como a necessidade de melhorar a
eficiência energética, tanto para dispositivos móveis, visando aumentar a autonomia da bateria,
quanto para estações de rádio base, visando reduzir o consumo de energia devido às perdas de
calor. Para atender a essas demandas, estratégias de modulação que alteram tanto a fase quanto a
amplitude de ondas portadoras em radiofrequência se tornaram essenciais @Kenington2000. Além
disso, a modulação na amplitude requer linearidade na transmissão para evitar erros e
interferências na comunicação entre usuários vizinhos @Cripps2006.

Essa complexa tarefa recai sobre o projetista do amplificador de potência de radiofrequência (PA),
que enfrenta o desafio de desenvolver um hardware eficiente em termos energéticos e linear ao
mesmo tempo, uma vez que esses dois objetivos podem entrar em conflito @Cripps2006. Uma
solução para contornar esse desafio é a implementação de um pré-distorcedor digital (DPD) em
banda base, que visa compensar a distorção causada pelo PA @Cripps2006. O DPD é conectado em
cascata ao PA e requer um modelo de alta precisão e baixa complexidade computacional para
representar as características de transferência direta e inversa do amplificador.

Existem diversas abordagens para modelar o PA. Neste projeto, adota-se o modelo de polinômio
com memória com ordem polinomial dependente do atraso, buscando concentrar a complexidade
nos termos mais relevantes e reduzir operações associadas aos atrasos mais antigos. Além da
validação em software, também é investigada a implementação direta da estrutura em VHDL, com
ênfase na equivalência funcional em ponto fixo e na redução de recursos de hardware.

== Objetivo Geral

Investigar, em software Python, estruturas alternativas do modelo _Memory Polynomial_ (MP) para
a modelagem matemática de PAs, com ênfase em abordagens que
utilizam ordens polinomiais dependentes do atraso, avaliando o compromisso entre complexidade
computacional e precisão do modelo.

== Objetivos Específicos

Para alcançar o objetivo geral, este trabalho foi desenvolvido com base nos seguintes objetivos
específicos:

+ Implementar, em software Python, o modelo _Memory Polynomial_ tradicional para a modelagem
  comportamental de amplificadores de potência;

+ Desenvolver e implementar uma variação do modelo MP com ordens polinomiais dependentes do
  atraso, permitindo truncamentos polinomiais distintos para cada ramo de memória;

+ Avaliar o desempenho dos modelos propostos por meio de métricas de erro, com ênfase no
  _Normalized Mean Square Error_ (NMSE);

+ Analisar a relação entre a complexidade estrutural dos modelos, expressa pelo número de
  coeficientes, e a precisão obtida, por meio de uma abordagem de otimização multiobjetivo
  baseada na fronteira de Pareto;

+ Identificar configurações de modelos MP que apresentem melhor compromisso entre desempenho
  e complexidade, visando futuras implementações eficientes.

// ═════════════════════════════════════════════════════════════════════════════
= Revisão de Literatura
// ═════════════════════════════════════════════════════════════════════════════

De maneira geral, as abordagens de modelagem de amplificadores de potência podem ser
classificadas em duas categorias principais: modelagem física e modelagem comportamental. A
modelagem física baseia-se no conhecimento detalhado da topologia do circuito, dos dispositivos
semicondutores e dos componentes passivos que constituem o amplificador. Embora essa
abordagem possa oferecer elevada precisão, sua aplicação é limitada pela alta complexidade
computacional e pela dificuldade de obtenção de todos os parâmetros físicos necessários. Em
contrapartida, a modelagem comportamental, também conhecida como empírica, fundamenta-se
exclusivamente na observação da relação entre os sinais de entrada e saída do sistema, sem a
necessidade de informações detalhadas sobre a estrutura interna do circuito. Essa característica
torna os modelos comportamentais particularmente atrativos para aplicações de simulação e
linearização, devido à sua menor complexidade computacional.

No contexto da pré-distorção digital, a modelagem comportamental é amplamente preferida, uma
vez que o objetivo principal é reproduzir o comportamento inverso observável do PARF. Além das
não linearidades estáticas, os efeitos de memória --- isto é, a dependência da saída atual em
relação a amostras passadas do sinal de entrada --- desempenham um papel relevante no
comportamento do amplificador. Dessa forma, os sistemas podem ser classificados como sem
memória ou com memória, sendo esta última categoria a mais representativa para amplificadores
operando com sinais de larga banda.

Dentre os diversos modelos comportamentais propostos na literatura, destacam-se os modelos
polinomiais com memória e as redes neurais artificiais. Embora as redes neurais apresentem
elevada capacidade de aproximação, sua implementação pode acarretar maior complexidade
computacional. Neste trabalho, opta-se por modelos baseados em simplificações da série de
Volterra, priorizando estruturas polinomiais devido ao seu compromisso favorável entre capacidade
de modelagem e custo computacional.

== Amplificadores de Potência em RF

Os dispositivos ativos que compõem o PA apresentam comportamento inerentemente não linear,
especialmente quando operam próximos à região de saturação. Como consequência, essas não
linearidades afetam diretamente sinais passa banda, que possuem múltiplas componentes
espectrais concentradas em torno da frequência central.

A @fig:comportamentopassabanda ilustra o comportamento típico de um PA passa banda,
evidenciando os sinais de entrada e saída tanto no domínio do tempo quanto no domínio da
frequência. Observa-se que, enquanto o espectro do sinal de entrada está confinado à banda
desejada, o sinal de saída apresenta um espalhamento espectral. Esse fenômeno ocorre devido à
geração de produtos de intermodulação provocados pelas não linearidades do amplificador,
resultando no surgimento de componentes espectrais fora da banda original do sinal.

#figure(
  image("Figuras/comportamento passa banda.png", width: 100%),
  caption: [Exemplo de distorção no espectro de Frequência do PARF],
  source: [#cite(<Pedro2005>, form: "prose")],
) <fig:comportamentopassabanda>

Esse espalhamento espectral é particularmente indesejável em sistemas de comunicação sem fio,
pois pode causar interferência em canais adjacentes, degradando o desempenho de usuários
vizinhos e violando requisitos regulatórios de emissão espectral.

== Linearização de Amplificadores de Potência

As não linearidades inerentes aos PARFs causam distorções significativas em sinais passa banda,
resultando em espalhamento espectral e interferência em canais adjacentes. Esse efeito torna-se
especialmente crítico nos sistemas modernos de comunicação sem fio, nos quais a largura de banda
disponível é limitada e há uma demanda crescente por maiores taxas de transmissão de dados.
Para atender a esses requisitos, são amplamente empregadas modulações digitais complexas que
variam simultaneamente a amplitude e a fase do sinal, como QAM e OFDM @Kenington2000.

Entretanto, tais esquemas de modulação impõem elevados requisitos de linearidade ao sistema de
transmissão, uma vez que qualquer não linearidade introduzida pelo PARF afeta diretamente a
envoltória do sinal, comprometendo sua integridade e degradando a qualidade da comunicação.

== Modelos Comportamentais

=== Séries de Volterra

A série de Volterra constitui uma extensão da série de Taylor para a representação de sistemas
não lineares dinâmicos com memória, sendo amplamente utilizada na modelagem de amplificadores
de potência @Pedro2005. Por meio dessa abordagem, a saída do sistema é expressa
como uma combinação de integrais múltiplas envolvendo o sinal de entrada e núcleos que
caracterizam o comportamento do sistema em diferentes ordens de não linearidade.

Matematicamente, a saída $y(t)$ de um sistema descrito pela série de Volterra pode ser expressa
como:

$ y(t) = h_0 + sum_(n=1)^(infinity) integral_(-infinity)^(infinity) "cdots" integral_(-infinity)^(infinity) h_n (tau_1, dots.c, tau_n) product_(i=1)^(n) x(t - tau_i) , d tau_i $ <eq:Volterra>

em que $h_n (tau_1, dots.c, tau_n)$ representa o núcleo de Volterra de ordem $n$, responsável por
descrever os efeitos não lineares e de memória do sistema. Embora a série de Volterra forneça uma
descrição bastante geral e precisa do comportamento de sistemas não lineares com memória, sua
aplicação prática é limitada pela elevada complexidade computacional. Por esse motivo, na maioria
das aplicações, a série é truncada para ordens finitas, restringindo o número de termos
considerados.

=== Polinômio com Memória

O modelo de polinômio com memória (_Memory Polynomial_ --- MP) surge como uma simplificação
da série de Volterra, obtida pela consideração apenas dos termos diagonais, isto é, daqueles que
compartilham o mesmo atraso temporal @Kim2001. Essa simplificação reduz
significativamente a complexidade do modelo, ao mesmo tempo em que preserva a capacidade de
representar não linearidades e efeitos de memória de forma satisfatória para uma ampla classe de
amplificadores de potência.

O modelo MP pode ser descrito matematicamente por:

$ y(n) = sum_(p=1)^(P) sum_(m=0)^(M) h_(p,m) , x(n - m) |x(n - m)|^(p-1) $ <eq:mp>

em que $P$ representa a ordem de não linearidade do modelo, $M$ corresponde à profundidade de
memória considerada, e $h_(p,m)$ são os coeficientes do modelo. Uma das principais vantagens do
modelo de polinômio com memória é sua linearidade nos parâmetros, o que facilita a estimação dos
coeficientes por meio de técnicas de otimização convencionais. Além disso, esse modelo apresenta
boa eficácia na representação de amplificadores de potência com efeitos de memória moderados,
sendo amplamente empregado em aplicações de pré-distorção digital.

Observa-se que, na formulação tradicional do modelo MP, a ordem polinomial máxima $P$ é adotada
de forma uniforme para todos os termos de memória, independentemente do atraso considerado.
Essa restrição, embora simplifique a estrutura do modelo, não é imposta pela formulação original da
série de Volterra e pode resultar em um aumento desnecessário da complexidade computacional,
especialmente para termos associados a atrasos mais elevados, cujos efeitos não lineares tendem
a ser menos pronunciados. Dessa forma, a adoção de ordens polinomiais diferenciadas em função
do atraso de memória surge como uma alternativa potencial para reduzir a complexidade do modelo,
mantendo sua capacidade de representação.

Do ponto de vista de implementação em hardware, especialmente em sistemas que operam com
altas taxas de amostragem, torna-se fundamental explorar arquiteturas eficientes que permitam a
paralelização das operações aritméticas. Nesse contexto, a implementação em VHDL do modelo MP
com truncamento polinomial dependente do atraso permite avaliar de forma direta se a redução de
complexidade observada em software se traduz em menor utilização de recursos em hardware
digital, preservando a equivalência funcional do modelo.

// ═════════════════════════════════════════════════════════════════════════════
= Material e Métodos
// ═════════════════════════════════════════════════════════════════════════════

== Modelo MP original <sec:mp-original>

Conforme detalhado no Capítulo~2, amplificadores de potência RF são dispositivos inerentemente
não lineares e sujeitos a efeitos de memória, decorrentes tanto da natureza dos sinais de banda
larga aplicados quanto das não linearidades impostas pelos circuitos internos do amplificador.
Sistemas desse tipo podem ser representados matematicamente por meio da série de Volterra.

Uma característica importante da série de Volterra, conforme destacado em @Pedro2005,
é sua linearidade em relação aos parâmetros, o que permite a estimação dos coeficientes do modelo
por meio de técnicas de identificação linear, como o método dos mínimos quadrados. No entanto, o
número de parâmetros da série de Volterra cresce rapidamente com o aumento da ordem do
polinômio e com a quantidade de termos de memória considerados, resultando em modelos de
elevada complexidade computacional.

Para viabilizar o uso da série de Volterra em aplicações práticas, mesmo com polinômios de ordem
elevada e múltiplos termos de memória, diversos modelos comportamentais propostos na literatura
aplicam simplificações dessa representação matemática. Um exemplo é o modelo comportamental
apresentado em @Kim2001, conhecido como modelo MP.

O modelo MP pode ser interpretado como uma extensão do modelo polinomial estático,
incorporando efeitos de memória por meio de uma forma reduzida da série de Volterra. Nessa
abordagem, apenas produtos de amostras correspondentes ao mesmo instante de tempo são
considerados. Matematicamente, o modelo MP é descrito pela @eq:mp, na qual todos os polinômios
que compõem o modelo possuem a mesma ordem @Kim2001.

Entre as principais características do modelo MP, destaca-se o fato de que ele é baseado em
multiplicações de sinais avaliados no mesmo instante de tempo, como $tilde(x)(n)|tilde(x)(n)|$ e
$tilde(x)(n-1)|tilde(x)(n-1)|$. Além disso, como o modelo depende de informações passadas da
fase da envoltória do sinal de entrada, ele é capaz de representar fenômenos associados às
variações de fase da envoltória, incluindo as conversões PM--AM (_phase modulation to amplitude
modulation_) e PM--PM (_phase modulation to phase modulation_). A @fig:mp_padrao apresenta o
diagrama de blocos do modelo MP.

#figure(
  image("Figuras/mp_padrao.png", width: 75%),
  caption: [Diagrama de blocos do modelo MP],
  source: [#cite(<Kim2001>, form: "prose")],
) <fig:mp_padrao>

=== Polinômio com Memória com Truncamento Polinomial Dependente do Atraso

Conforme discutido na Seção~2.3.2, o modelo de Polinômio com Memória (MP) tradicional adota
uma ordem polinomial máxima uniforme para todos os termos de memória. Embora essa abordagem
simplifique a estrutura do modelo, ela pode resultar em um aumento desnecessário da complexidade
computacional, uma vez que os efeitos não lineares associados a amostras mais antigas tendem a
ser menos significativos do que aqueles relacionados à amostra atual.

Com o objetivo de explorar essa característica, propõe-se neste trabalho uma variação do modelo
MP na qual a ordem polinomial máxima passa a ser definida de forma independente para cada
atraso de memória. Dessa forma, o modelo deixa de utilizar um único parâmetro de ordem
polinomial $P$ e passa a empregar um conjunto de ordens $\{P_0, P_1, dots.c, P_M\}$, em que
$P_m$ representa a ordem polinomial máxima associada ao termo de atraso $m$.

Matematicamente, o modelo proposto pode ser expresso como:

$ y(n) = sum_(m=0)^(M) sum_(p=1)^(P_m) h_(p,m) , x(n - m) |x(n - m)|^(p-1) $ <eq:mp_truncado>

em que $M$ corresponde à profundidade de memória do modelo, $P_m$ define a ordem polinomial
máxima associada ao atraso $m$, e $h_(p,m)$ são os coeficientes complexos a serem estimados.
Observa-se que o modelo MP tradicional constitui um caso particular da @eq:mp_truncado, obtido
quando se impõe $P_0 = P_1 = dots.c = P_M = P$.

A principal motivação dessa abordagem reside na possibilidade de reduzir o número total de
coeficientes do modelo sem comprometer significativamente sua capacidade de representação. Em
particular, espera-se que a escolha de ordens polinomiais decrescentes com o aumento do atraso,
isto é, $P_0 > P_1 > dots.c > P_M$, seja suficiente para capturar os efeitos não lineares dominantes
do amplificador de potência, concentrados majoritariamente na amostra atual e nos atrasos mais
próximos.

Do ponto de vista de identificação, o modelo proposto preserva a linearidade nos parâmetros,
permitindo a estimação dos coeficientes por meio de técnicas de mínimos quadrados
convencionais, de forma análoga ao MP clássico. A diferença reside na construção da matriz de
regressão, que passa a incorporar apenas os termos polinomiais correspondentes a cada ordem
$P_m$, resultando em uma matriz de menor dimensão.

Além da redução de complexidade computacional, essa estrutura oferece vantagens diretas para a
implementação em hardware. Como o número de termos polinomiais deixa de ser uniforme entre os
atrasos, a descrição em VHDL pode ser reorganizada para eliminar explicitamente operações
aritméticas desnecessárias, reduzindo o número de blocos funcionais do circuito sem alterar a
formulação matemática do modelo.

== Implementação em VHDL do modelo MP truncado

A validação em hardware foi realizada por meio da implementação em VHDL de duas arquiteturas:
a versão original do modelo MP, com ordem polinomial uniforme em todos os atrasos, e a versão
truncada com ordem dependente do atraso. Ambas foram descritas em ponto fixo e organizadas em
uma estrutura baseada em soma de produtos complexos, preservando os ramos de memória e o
cálculo explícito dos termos polinomiais.

Na versão truncada, a redução da ordem polinomial nos atrasos mais antigos foi acompanhada por
uma reorganização da arquitetura para remover diretamente as operações redundantes. Dessa
forma, a comparação entre as duas implementações permite avaliar não apenas a equivalência
funcional em relação ao modelo de referência em Python, mas também os ganhos efetivos de
complexidade estrutural obtidos após a síntese lógica.

Para a verificação funcional e estrutural, foram utilizadas ferramentas open source. A análise e a
simulação do código VHDL foram conduzidas com GHDL, a síntese lógica foi realizada com Yosys e
a inspeção dos sinais temporais foi feita com GTKWave. A comparação entre as saídas em ponto
fixo obtidas em Python e em VHDL, bem como a análise das curvas AM-AM e AM-PM, foi empregada
como critério de validação funcional das implementações.

== Evidências experimentais para o truncamento polinomial

Com o objetivo de fundamentar experimentalmente a hipótese de que a não linearidade dominante
do amplificador está concentrada no instante atual, foi realizada uma análise específica sobre o
conjunto `data_LDMOS_formatted_4500p.mat`, contendo 4.500 amostras para extração e 4.500
amostras para validação. Nessa etapa, foram consideradas profundidade de memória $M = 2$ e
ordens polinomiais variando de 1 a 5, utilizando três análises complementares: magnitude dos
coeficientes por ramo de memória, sensibilidade do NMSE a cada parâmetro $P_m$ e espectro do
erro residual.

Na análise dos coeficientes, foi treinado um modelo MP completo com $P_0 = P_1 = P_2 = 5$,
obtendo-se NMSE de $-38,47$ dB. A energia dos ramos de memória foi então calculada por

$ E_m = sum_(p=1)^(P_"max") |h_(p,m)|^2, $

permitindo quantificar a contribuição relativa de cada atraso à não linearidade total do sistema.
Adicionalmente, para avaliar a sensibilidade do modelo a cada ordem polinomial, dois parâmetros
foram mantidos fixos em 1 enquanto o terceiro variou entre 1 e 5, medindo-se o ganho de NMSE
produzido pelo aumento de complexidade em cada ramo. Por fim, o sinal de erro residual foi
analisado no domínio da frequência com janela de Blackman, FFT de 8192 pontos e média por
blocos, permitindo verificar como a variação de $P_0$, $P_1$ e $P_2$ afeta o _regrowth_ espectral.

== Avaliação em múltiplos conjuntos de dados

Para verificar a capacidade de generalização da metodologia, o _pipeline_ completo de identificação
e avaliação dos modelos MP com ordem dependente do atraso foi aplicado a dois conjuntos de
dados experimentais distintos: `in_out_SBRT2_direto.mat`, correspondente a um PA GaN HEMT, e
`data_LDMOS_formatted_4500p.mat`, correspondente a um PA LDMOS. Em ambos os casos, foram
avaliadas exaustivamente todas as 125 combinações possíveis de ordens $(P_0, P_1, P_2)$ com
$P_m in {1, 2, 3, 4, 5}$ e profundidade de memória $M = 2$.

Os coeficientes complexos de cada modelo foram estimados em Python com
`scipy.optimize.least_squares`, utilizando os conjuntos de extração, e o desempenho foi avaliado
nos conjuntos de validação por meio do NMSE. Essa etapa permitiu comparar não apenas o nível
absoluto de desempenho entre tecnologias distintas de amplificadores, mas também a estabilidade
dos padrões estruturais observados anteriormente, como a predominância de $P_0$ e a eficiência
dos modelos com distribuição decrescente de ordens.

== Identificação do sistema DPD + PA

Além da modelagem direta do amplificador, foi avaliado um sistema completo de pré-distorção
digital baseado no modelo MP. Nessa etapa, utilizou-se o conjunto
`data_LDMOS_formatted_4500p.mat` para identificar inicialmente o modelo do PA com profundidade
de memória $M = 2$ e ordem polinomial $P = 5$, totalizando 15 coeficientes complexos. Em
seguida, foi adotada a arquitetura _Indirect Learning Architecture_ (ILA), na qual o DPD é treinado
como o inverso do PA a partir do mapeamento entre a saída medida do amplificador e o sinal de
entrada original.

A cascata final considerada foi composta por $x(n) -> "DPD"(x(n)) -> "PA"("DPD"(x(n)))$. Para
evitar extrapolação do modelo polinomial, foi aplicado um fator global de ganho na entrada do
sistema. Foram avaliadas duas estratégias: uma baseada na razão entre amplitudes máximas de
entrada e saída do PA, resultando em valor aproximado de 0,83, e outra com ganho fixo de 0,95,
que apresentou melhor aproveitamento da faixa dinâmica e melhor qualidade de linearização nas
curvas AM-AM e AM-PM.

// ═════════════════════════════════════════════════════════════════════════════
= Resultados e Discussão
// ═════════════════════════════════════════════════════════════════════════════

Este capítulo apresenta os resultados obtidos a partir da validação inicial das estruturas de
modelagem propostas na @sec:mp-original, com foco na caracterização do desempenho do modelo
_Memory Polynomial_ (MP) clássico aplicado à modelagem comportamental de um amplificador de
potência real. Além da validação em ponto flutuante, são apresentados os resultados do modelo MP
com truncamento polinomial dependente do atraso e sua implementação em VHDL, com ênfase na
equivalência funcional em ponto fixo e na redução de complexidade estrutural obtida em síntese.

A validação dos resultados apresentados é realizada por meio da análise do erro entre o sinal de
saída medido do amplificador de potência (PA) real e o sinal de saída estimado pelo modelo
comportamental. Quanto menor o valor desse erro, maior é a precisão do modelo considerado.

Para a análise do desempenho dos modelos implementados, realiza-se a avaliação do sinal de erro
por meio do _Normalized Mean Square Error_ (NMSE) --- Erro Quadrático Médio Normalizado
@Muha1999. Matematicamente, o NMSE é definido por:

$ "NMSE" = 10 log_(10) lr(( frac(
  sum_(n=1)^(N) |e(n)|^2,
  sum_(n=1)^(N) |y_"real" (n)|^2
) )) $ <eq:nmse>

em que $y_"real" (n)$ representa a amostra do sinal de saída do PA real no instante $n$, $e(n)$
corresponde ao erro entre o sinal de saída real e o sinal de saída estimado pelo modelo, definido
como $e(n) = y_"real" (n) - y_"model" (n)$, e $N$ é o número total de amostras consideradas
na análise.

Os dados utilizados na validação dos modelos são provenientes de medições experimentais
realizadas em um amplificador de potência classe AB, do tipo HEMT, fabricado com tecnologia GaN.
O amplificador foi excitado por um sinal portador com frequência central de 900~MHz, modulado por
um sinal de envoltória WCDMA conforme o padrão 3GPP, com largura de banda aproximada de
3,84~MHz. Os sinais de entrada e saída do amplificador foram adquiridos utilizando um analisador
vetorial de sinais (VSA) da Rohde & Schwarz, com taxa de amostragem de 61,44~MHz.

== Modelagem do PA com MP original

Nesta seção são apresentados os resultados da modelagem comportamental do amplificador de
potência (PA) utilizando o modelo _Memory Polynomial_ (MP) original, conforme descrito no
Capítulo~3. Esta etapa tem como principal objetivo estabelecer uma referência de desempenho
(_baseline_) que servirá de comparação para as abordagens alternativas propostas neste trabalho,
em especial o modelo MP com truncamento polinomial dependente do atraso.

A implementação do modelo foi realizada em ambiente Python, empregando aritmética em vírgula
flutuante, com o intuito de avaliar o desempenho do MP em um cenário de alta precisão numérica,
sem restrições impostas por quantização ou limitações de hardware. Essa escolha permite isolar os
efeitos da estrutura do modelo, garantindo que eventuais limitações observadas estejam associadas
predominantemente à capacidade de representação do modelo MP, e não a aspectos relacionados
à implementação ou à aritmética utilizada.

A @fig:modelopafloat apresenta o diagrama representativo do modelo do PA implementado em
vírgula flutuante.

#figure(
  image("Figuras/modelopafloat.png", width: 50%),
  caption: [Modelo do PA com MP Original],
  source: [Autor],
) <fig:modelopafloat>

A identificação dos coeficientes do modelo foi realizada por meio de um procedimento de
otimização numérica, utilizando métodos de mínimos quadrados aplicados à formulação do erro
entre o sinal de saída real do PA e o sinal estimado pelo modelo. Após o processo de identificação,
o desempenho do modelo foi avaliado em um conjunto de dados distinto daquele utilizado na etapa
de estimação dos coeficientes, de forma a evitar sobreajuste.

Para a configuração considerada, o modelo MP original alcançou um valor de NMSE igual a
$-26,7$~dB, evidenciando uma boa capacidade de aproximação do comportamento do amplificador
de potência real em regime de banda larga. Esse resultado confirma a adequação do modelo MP
clássico como referência de desempenho e estabelece um ponto de comparação consistente para a
avaliação das estruturas alternativas propostas neste trabalho.

== Evidências experimentais para o truncamento polinomial dependente do atraso

Com o objetivo de sustentar experimentalmente a hipótese de truncamento polinomial dependente
do atraso, foi realizada uma análise específica sobre o conjunto LDMOS com 4.500 amostras de
extração e 4.500 de validação. As evidências foram organizadas em três frentes complementares:
análise da magnitude dos coeficientes por ramo de memória, sensibilidade do NMSE às ordens
$P_0$, $P_1$ e $P_2$, e inspeção do espectro do erro residual.

=== Evidência 1: magnitude dos coeficientes por ramo de memória

Um modelo MP completo com $P_0 = P_1 = P_2 = 5$ foi treinado, atingindo NMSE de
$-38,47$ dB. A energia de cada ramo foi obtida a partir da soma dos módulos quadráticos dos
coeficientes associados a cada atraso.

#table(
  columns: (auto, auto, auto),
  align: center,
  table.header([*Atraso m*], [*Energia $E_m$*], [*Relativa a $m = 0$*]),
  [$m = 0$], [20,5751], [100,0%],
  [$m = 1$], [13,7146], [66,7%],
  [$m = 2$], [4,8489], [23,6%],
)

#figure(
  image("Figuras/ev1_magnitude_coeficientes.png", width: 85%),
  caption: [Magnitude dos coeficientes $|h_(p,m)|$ e energia $E_m$ por ramo de memória. O decaimento de energia ao longo dos atrasos evidencia que a não linearidade dominante está concentrada no instante atual.],
  source: [Autor],
) <fig:ev1-magnitude-coeficientes>

Os resultados mostram um decaimento monotônico da energia com o atraso, indicando que os ramos
mais antigos contribuem progressivamente menos para o comportamento não linear do sistema.
Esse resultado fornece evidência física direta para a adoção de ordens polinomiais decrescentes ao
longo da memória.

=== Evidência 2: sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$

Para isolar a contribuição de cada parâmetro, dois ramos foram mantidos com ordem 1 enquanto o
terceiro variou entre 1 e 5. O ponto de partida comum foi o modelo $(1,1,1)$, com NMSE de
$-28,71$ dB.

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  table.header([*Parâmetro variado*], [*NMSE em $P=1$*], [*NMSE em $P=5$*], [*Δ NMSE*]),
  [$P_0$], [$-28,71$ dB], [$-35,36$ dB], [*6,66 dB*],
  [$P_1$], [$-28,71$ dB], [$-32,14$ dB], [3,43 dB],
  [$P_2$], [$-28,71$ dB], [$-30,20$ dB], [1,49 dB],
)

#figure(
  image("Figuras/ev2_sensibilidade_nmse.png", width: 85%),
  caption: [Sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$. O ganho associado a $P_0$ é significativamente superior aos obtidos para os atrasos mais antigos.],
  source: [Autor],
) <fig:ev2-sensibilidade-nmse>

Observa-se que o ganho obtido ao aumentar $P_0$ é aproximadamente 1,94 vezes maior que o
ganho associado a $P_1$ e 4,47 vezes maior que o associado a $P_2$. Isso demonstra
quantitativamente que a complexidade polinomial deve ser concentrada no ramo correspondente ao
instante atual, enquanto os atrasos mais antigos saturam rapidamente em ordens menores.

=== Evidência 3: espectro do erro residual

O erro residual foi analisado no domínio da frequência para diferentes configurações de modelo,
utilizando PSD com janela de Blackman, FFT de 8192 pontos e média por blocos.

#figure(
  image("Figuras/ev3_espectro_erro.png", width: 85%),
  caption: [PSD do erro residual para variações de $P_0$, $P_1$ e $P_2$. O aumento de $P_0$ produz a maior redução espectral, tanto na banda quanto nas adjacências.],
  source: [Autor],
) <fig:ev3-espectro-erro>

#figure(
  image("Figuras/ev_bonus_psd_completo.png", width: 85%),
  caption: [PSD comparativa entre o sinal de entrada, a saída medida do PA e os erros de modelagem de diferentes configurações. A redução do espalhamento espectral é mais pronunciada quando se aumenta $P_0$.],
  source: [Autor],
) <fig:ev-bonus-psd-completo>

As curvas confirmam, no domínio da frequência, o mesmo comportamento observado nas análises de
coeficientes e NMSE: aumentar a ordem polinomial do instante atual reduz de forma mais efetiva o
erro residual e o _regrowth_ espectral, enquanto aumentos em $P_1$ e $P_2$ produzem ganhos
marginais.

== Avaliação do Modelo MP com Ordem Dependente do Atraso

Nesta seção é apresentada a avaliação do modelo _Memory Polynomial_ (MP) com ordem polinomial
dependente do atraso. Diferentemente do modelo MP tradicional, no qual todos os ramos de
memória utilizam uma mesma ordem polinomial máxima, a abordagem analisada permite que cada
atraso possua um truncamento polinomial próprio. Tal estratégia visa investigar a influência
individual da ordem polinomial associada a cada atraso no desempenho global do modelo.

Para essa análise, foi considerada uma profundidade de memória $M = 2$, sendo avaliadas todas
as combinações possíveis de ordens polinomiais $(P_0, P_1, P_2)$ variando de 1 a 5. Esse
procedimento resultou em um total de 125 modelos distintos, todos treinados em ponto flutuante.
Para cada modelo, foram registrados o valor do NMSE e a quantidade total de coeficientes utilizada.

A @fig:desempenho125modelos apresenta o desempenho dos 125 modelos avaliados,
relacionando o NMSE com o número total de coeficientes. De maneira geral, observa-se que o
aumento da quantidade de coeficientes tende a melhorar a precisão do modelo. Entretanto, nota-se
que esse fator, isoladamente, não é determinante para a obtenção de melhores resultados. Modelos
com complexidade semelhante podem apresentar desempenhos significativamente distintos,
indicando que a distribuição da ordem polinomial entre os atrasos exerce papel fundamental na
acurácia do modelo.

#figure(
  image("Figuras/desempenho125modelos.png", width: 50%),
  caption: [Desempenho dos 125 modelos MP com ordem dependente do atraso],
  source: [Autor],
) <fig:desempenho125modelos>

=== Influência da ordem polinomial nos respectivos atrasos

Nesta etapa, é analisada a influência individual da ordem polinomial associada a cada atraso de
memória sobre o desempenho do modelo. As @fig:influenciap0, @fig:influenciap1 e
@fig:influenciap2 apresentam a relação entre o NMSE e a ordem polinomial correspondente aos
atrasos $m=0$, $m=1$ e $m=2$, respectivamente, considerando todos os modelos avaliados.

#figure(
  image("Figuras/influenciap0.png", width: 50%),
  caption: [Influência da ordem polinomial no instante atual ($P_0$)],
  source: [Autor],
) <fig:influenciap0>

#figure(
  image("Figuras/influenciap1.png", width: 50%),
  caption: [Influência da ordem polinomial no atraso $m=1$ ($P_1$)],
  source: [Autor],
) <fig:influenciap1>

#figure(
  image("Figuras/influenciap2.png", width: 50%),
  caption: [Influência da ordem polinomial no atraso $m=2$ ($P_2$)],
  source: [Autor],
) <fig:influenciap2>

Observa-se que o aumento da ordem polinomial associada ao instante atual ($P_0$) resulta em uma
redução significativa do NMSE, evidenciando que a não linearidade dominante do amplificador está
fortemente concentrada no instante atual. Em contrapartida, os atrasos mais antigos apresentam
menor sensibilidade ao aumento da ordem polinomial, sendo que, para $P_2$, o impacto no
desempenho é bastante limitado.

As @fig:nmsecomplexp0, @fig:nmsecomplexp1 e @fig:nmsecomplexp2 apresentam a relação entre o
NMSE e a complexidade do modelo, destacando separadamente a influência das ordens polinomiais
$P_0$, $P_1$ e $P_2$. Esses gráficos permitem visualizar como a alocação da complexidade entre
os diferentes atrasos afeta o desempenho global do modelo.

#figure(
  image("Figuras/nmsecomplexp0.png", width: 50%),
  caption: [NMSE em função da complexidade, destacando a ordem $P_0$],
  source: [Autor],
) <fig:nmsecomplexp0>

#figure(
  image("Figuras/nmsecomplexp1.png", width: 50%),
  caption: [NMSE em função da complexidade, destacando a ordem $P_1$],
  source: [Autor],
) <fig:nmsecomplexp1>

#figure(
  image("Figuras/nmsecomplexp2.png", width: 50%),
  caption: [NMSE em função da complexidade, destacando a ordem $P_2$],
  source: [Autor],
) <fig:nmsecomplexp2>

A partir dessa análise, conclui-se que a ordem polinomial associada ao instante atual ($P_0$) é o
principal fator responsável pelo ganho de precisão do modelo. A alocação de ordens polinomiais
elevadas em atrasos mais antigos não resulta em ganhos proporcionais de desempenho, o que
indica uma contribuição marginal desses termos para a modelagem das não linearidades do sistema.

Por fim, a @fig:modelosdecrecenteatraso apresenta os modelos que respeitam a relação
$P_0 >= P_1 >= P_2$. Observa-se que grande parte dos modelos com melhor desempenho pertence
a esse conjunto, reforçando a hipótese de que a complexidade do modelo deve ser prioritariamente
alocada no instante atual, com redução progressiva da ordem polinomial para atrasos mais antigos.

#figure(
  image("Figuras/modelosdecrecenteatraso.png", width: 50%),
  caption: [Modelos com ordens polinomiais decrescentes ao longo dos atrasos],
  source: [Autor],
) <fig:modelosdecrecenteatraso>

Esses resultados demonstram que modelos com menor quantidade total de coeficientes podem
apresentar desempenho superior quando a complexidade é adequadamente distribuída entre os
atrasos. Tal comportamento evidencia que não apenas a quantidade de coeficientes, mas
principalmente a forma como estes são organizados estruturalmente no modelo MP, é determinante
para a acurácia obtida.

A análise da fronteira de Pareto, apresentada na @fig:fronteiradepareto, evidencia de forma clara o
compromisso existente entre a complexidade estrutural do modelo e o desempenho obtido. Os
modelos pertencentes à fronteira representam soluções eficientes, uma vez que não é possível
melhorar o NMSE sem um aumento correspondente no número de coeficientes, ou reduzir a
complexidade sem perda de desempenho.

Observa-se que os modelos localizados na fronteira de Pareto apresentam, em sua maioria,
distribuições de ordem polinomial concentradas no instante atual, com redução progressiva das
ordens associadas aos atrasos mais antigos. Tal comportamento reforça os resultados apresentados
anteriormente, indicando que a não linearidade dominante do sistema está majoritariamente
associada ao instante atual, enquanto os efeitos de memória contribuem de forma menos
significativa e saturam com ordens polinomiais reduzidas.

#figure(
  image("Figuras/fronteiradepareto.png", width: 50%),
  caption: [Fronteira de Pareto para os modelos MP com ordem dependente do atraso],
  source: [Autor],
) <fig:fronteiradepareto>

== Generalização em múltiplos conjuntos de dados experimentais

Para avaliar a robustez da metodologia proposta, o mesmo procedimento de identificação e
avaliação foi aplicado a dois conjuntos de dados distintos: um PA GaN HEMT e um PA LDMOS.
Em ambos os conjuntos, foram testadas as 125 combinações possíveis de ordens $(P_0, P_1, P_2)$
com $M = 2$, mantendo o mesmo _pipeline_ de treinamento e validação.

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  table.header(
    [*Métrica*],
    [*Conjunto 1 — GaN*],
    [*Conjunto 2 — LDMOS*],
    [*Diferença (dB)*],
  ),
  [NMSE melhor modelo], [-26,11 dB], [-37,53 dB], [11,42],
  [NMSE pior modelo], [-21,41 dB], [-28,71 dB], [7,30],
  [NMSE médio], [-25,21 dB], [-35,20 dB], [9,99],
  [Modelo P\=[1,1,1] (3 coef.)], [-21,66 dB], [-28,71 dB], [7,05],
  [Modelo P\=[3,3,3] (9 coef.)], [-25,95 dB], [-35,25 dB], [9,30],
  [Modelo P\=[5,5,5] (15 coef.)], [-26,10 dB], [-37,51 dB], [11,41],
)

Os resultados mostram que o conjunto LDMOS apresentou desempenho absoluto superior, com NMSE
médio aproximadamente 10 dB mais negativo do que o conjunto GaN. Ainda assim, os padrões
estruturais se mantiveram consistentes entre as duas tecnologias, indicando que a abordagem
proposta é robusta frente a variações do dispositivo sob teste.

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
  [\[3, 2, 1\]], [6], [-25,53], [-34,75], [9,22],
  [\[3, 3, 2\]], [8], [-25,60], [-35,24], [9,64],
  [\[4, 3, 2\]], [9], [-25,64], [-36,31], [10,67],
  [\[5, 3, 2\]], [10], [-25,49], [-37,00], [11,51],
  [\[5, 4, 3\]], [12], [-26,07], [-37,44], [11,37],
  [\[5, 5, 5\]], [15], [-26,10], [-37,51], [11,41],
)

Em ambos os conjuntos, a ordem $P_0$ permaneceu como principal determinante de desempenho, e
os modelos com distribuição decrescente $P_0 >= P_1 >= P_2$ concentraram as melhores soluções.
Além disso, o ganho marginal obtido ao ultrapassar a faixa de 9 a 10 coeficientes mostrou-se
reduzido nas duas tecnologias, indicando saturação de desempenho em baixas complexidades.

== Implementação em VHDL do modelo MP com ordem dependente do atraso

Após a avaliação em software, foi realizada a implementação em VHDL de duas versões do modelo:
o MP original completo, com ordem uniforme em todos os atrasos, e o MP truncado, com redução
da ordem polinomial nos atrasos mais antigos e reorganização estrutural para eliminar operações
redundantes. O objetivo dessa etapa foi verificar se os ganhos de complexidade observados na
modelagem também se manifestam em uma descrição orientada à síntese em hardware.

=== Validação funcional em Python

#figure(
  image("Figuras/fig_python_amam_ampm.png", width: 75%),
  caption: [Curvas AM-AM e AM-PM obtidas em Python, comparando os dados medidos com os modelos PA e DPD em ponto fixo.],
  source: [Autor],
) <fig:fig_python_amam_ampm>

A @fig:fig_python_amam_ampm apresenta a comparação entre os dados medidos e os modelos
implementados em Python. Observa-se que o modelo DPD é capaz de compensar a não linearidade
do amplificador, aproximando a resposta do comportamento ideal e estabelecendo a referência para
a validação funcional da implementação em VHDL.

=== Validação da implementação em VHDL

#figure(
  image("Figuras/fig_vhdl_vs_python.png", width: 75%),
  caption: [Curva AM-AM comparando o modelo em Python com o resultado da simulação da implementação em VHDL.],
  source: [Autor],
) <fig:fig_vhdl_vs_python>

A @fig:fig_vhdl_vs_python apresenta a comparação entre o modelo DPD calculado em Python e o
resultado obtido a partir da simulação da implementação em VHDL. Observa-se que os pontos
associados à descrição em hardware se sobrepõem aos resultados do modelo em software,
indicando equivalência funcional entre as duas implementações no cenário avaliado.

=== Comparação de complexidade estrutural

#figure(
  table(
    columns: 4,
    align: center,
    stroke: (x, y) => if y == 1 { (bottom: 1pt) },

    [*Métrica*], [*MP Original*], [*MP Truncado*], [*Redução (%)*],

    [Wires], [69 735], [41 022], [41,2],
    [Wire bits], [72 087], [42 703], [40,8],
    [Cells], [70 800], [41 497], [41,4],
    [Flip-flops], [765], [484], [36,7],
  ),
  caption: [Comparação de complexidade entre o modelo MP original e o modelo truncado implementados em VHDL.],
  source: [Autor],
) <fig:complexidade-vhdl>

Os resultados da @fig:complexidade-vhdl evidenciam uma redução consistente de aproximadamente
40% nas principais métricas estruturais da síntese lógica. A diminuição simultânea no número de
`wires`, `wire bits`, células e registradores mostra que a estratégia proposta simplifica
efetivamente a arquitetura implementada em hardware, e não apenas a quantidade nominal de
coeficientes do modelo.

Essa análise confirma que a redução da ordem polinomial nos atrasos mais antigos, quando
acompanhada de reorganização estrutural do circuito, produz ganhos reais de implementação. Dessa
forma, os resultados em VHDL reforçam a viabilidade do modelo MP com ordem dependente do
atraso para aplicações digitais com restrições de área e consumo.

== Avaliação do sistema DPD + PA com arquitetura ILA

Além da modelagem direta do amplificador, foi avaliada a aplicação do modelo MP em um sistema
de pré-distorção digital baseado na arquitetura ILA. Nessa configuração, o DPD foi treinado como
o inverso do PA a partir do conjunto LDMOS, e posteriormente aplicado em cascata com o modelo
do amplificador, formando a estrutura completa DPD + PA.

No ajuste do ganho global de entrada, duas estratégias foram comparadas. Um ganho baseado na
relação entre as amplitudes máximas de entrada e saída do PA resultou em valor aproximado de
0,83, produzindo um sinal estável porém com excursão dinâmica reduzida. Já o uso de ganho fixo
igual a 0,95 proporcionou melhor aproveitamento da faixa dinâmica do modelo e melhor qualidade
visual de linearização.

#figure(
  image("Figuras/AM-AM.png", width: 85%),
  caption: [Características AM-AM do sistema DPD + PA. A cascata final apresenta resposta mais próxima de uma relação linear em comparação ao PA isolado.],
  source: [Autor],
) <fig:am-am-dpd-pa>

#figure(
  image("Figuras/AM-PM.png", width: 85%),
  caption: [Características AM-PM do sistema DPD + PA. Observa-se redução da distorção de fase dependente da amplitude após a aplicação do DPD.],
  source: [Autor],
) <fig:am-pm-dpd-pa>

As curvas AM-AM indicam que o modelo do PA reproduz adequadamente a compressão de ganho do
amplificador real, enquanto o DPD compensa essa não linearidade e torna a resposta da cascata
substancialmente mais linear. Nas curvas AM-PM, observa-se redução da dispersão de fase em
função da amplitude, evidenciando compensação eficaz das distorções não lineares de fase.

Esses resultados mostram que o modelo MP é adequado não apenas para a modelagem direta do PA,
mas também para a identificação de um pré-distorcedor funcional por ILA. Além disso, reforçam
que o ajuste de ganho é um elemento crítico para evitar extrapolação do modelo e preservar a
estabilidade numérica do sistema DPD + PA.

// ═════════════════════════════════════════════════════════════════════════════
= Conclusão
// ═════════════════════════════════════════════════════════════════════════════

A crescente demanda por eficiência espectral e energética nos sistemas de comunicação sem fio
torna essencial o uso de técnicas capazes de mitigar os efeitos das não linearidades introduzidas
por amplificadores de potência, sendo a modelagem comportamental desses dispositivos uma etapa
fundamental nesse contexto.

Este trabalho teve como objetivo estudar e validar a modelagem de um amplificador de potência
por meio do modelo de Polinômio de Memória (MP), estabelecendo uma base consistente para
aplicações futuras em técnicas de pré-distorção digital. Inicialmente, foi realizado um estudo teórico
sobre os princípios do DPD e sobre a formulação matemática do modelo MP, evidenciando suas
vantagens em termos de complexidade e capacidade de representação das não linearidades com
efeitos de memória.

Em seguida, a modelagem do amplificador foi desenvolvida em ambiente de software utilizando
aritmética em vírgula flutuante, com extração dos coeficientes por meio de métodos de otimização
numérica e validação baseada na métrica do Erro Quadrático Médio Normalizado (NMSE), cujos
resultados demonstraram a eficácia do modelo MP clássico na caracterização do comportamento do
PA e estabeleceram uma referência de desempenho para análises posteriores.

A partir dessa base, foi proposta uma extensão do modelo MP na qual a ordem polinomial máxima
passa a ser definida de forma independente para cada atraso de memória, introduzindo maior
flexibilidade na modelagem e abrindo a possibilidade de reduzir a complexidade do modelo sem
comprometer significativamente sua capacidade de representação. A análise de desempenho dos
modelos treinados em software mostrou que a complexidade deve ser concentrada
prioritariamente no instante atual, enquanto atrasos mais antigos podem ser representados com
ordens menores, preservando boa acurácia.

As evidências experimentais adicionais baseadas na análise da magnitude dos coeficientes, na
sensibilidade do NMSE e no espectro do erro residual confirmaram de forma consistente essa
hipótese. Em particular, verificou-se que a energia dos coeficientes decai com o atraso, que o
ganho de desempenho associado a $P_0$ é significativamente superior aos ganhos obtidos com
$P_1$ e $P_2$, e que a redução do erro espectral é mais pronunciada quando a complexidade é
alocada no instante atual.

Os experimentos conduzidos em dois conjuntos de dados experimentais distintos, correspondentes
a amplificadores GaN HEMT e LDMOS, mostraram que esses padrões estruturais se mantêm
consistentes entre tecnologias diferentes. Embora os níveis absolutos de NMSE variem entre os
dispositivos, a predominância de $P_0$, a eficiência dos modelos com ordens decrescentes e a
saturação de desempenho em baixas complexidades foram preservadas, reforçando a capacidade de
generalização da metodologia proposta.

Adicionalmente, a implementação em VHDL das versões original e truncada do modelo confirmou a
equivalência funcional entre o comportamento previsto em Python e a descrição em hardware em
ponto fixo. Os resultados de síntese mostraram reduções próximas de 40% em métricas
estruturais como número de `wires`, células e registradores, evidenciando que a simplificação do
modelo produz ganhos concretos de implementação.

Por fim, a aplicação do modelo MP em um sistema de pré-distorção digital baseado na arquitetura
ILA demonstrou que a mesma estrutura é capaz de atuar tanto na modelagem do amplificador quanto
na identificação de um pré-distorcedor funcional. As curvas AM-AM e AM-PM da cascata DPD + PA
evidenciaram melhora clara de linearização, além de destacar a importância do ajuste de ganho
para preservar estabilidade numérica e bom aproveitamento da faixa dinâmica.

Dessa forma, o trabalho alcançou seu objetivo ao validar a modelagem comportamental do
amplificador de potência em software, ao propor uma estrutura de modelagem mais flexível e ao
demonstrar sua viabilidade em VHDL. Esses resultados constituem uma base sólida para o
desenvolvimento da versão final da dissertação e para estudos futuros na área de modelagem e
linearização de amplificadores de potência com foco em implementação digital eficiente.

// ─────────────────────────────────────────────────────────────────────────────
// REFERÊNCIAS  (usar o mesmo Referencias.bib copiado de Mestrado/Mestrado/)
// ─────────────────────────────────────────────────────────────────────────────

#bibliography("Referencias.bib", style: "ieee")

// ─────────────────────────────────────────────────────────────────────────────
// APÊNDICES
// ─────────────────────────────────────────────────────────────────────────────

#appendix(
  include "assets/apendice_resultados_mp.typ",
  [Resultados completos dos modelos MP]
)
