#import "../src/lib.typ": *

#set math.equation(numbering: "(1)")

#show: template.with(
  title: [
    Modelagem Comportamental Híbrida de Amplificadores de Potência Usando Polinômios com Memória e Tabelas de Busca
  ],
  title-foreign: [
    Hybrid Behavioral Modeling of Power Amplifiers Using Memory Polynomials and Look-Up Tables
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

    Orientador: Eduardo Gonçalves de Lima
  ],

  keywords: ([DPD], [Polinômio de memória], [LUTs]),
  keywords-foreign: ([DPD], [Memory polynomial], [LUTs]),

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
    [LUT],   [Look-Up Table],
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
redução da complexidade computacional sem prejuízo significativo de desempenho. A partir dessa
análise, avalia-se uma abordagem híbrida que combina polinômios e tabelas de consulta
(Look-Up Tables --- LUT), priorizando o uso de LUT nos termos associados às amostras atuais, que
concentram maior complexidade, e mantendo a implementação polinomial para os termos de
memória. Por fim, são comparadas as abordagens puramente polinomial, puramente baseada em
LUT e a abordagem híbrida, considerando métricas de precisão e complexidade computacional.
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
and reduced computational complexity without significant performance loss. Based on this analysis,
a hybrid approach combining polynomials and Look-Up Tables (LUTs) is evaluated, prioritizing LUT
use for terms associated with current samples, which concentrate greater complexity, while
maintaining polynomial implementation for memory terms. Finally, purely polynomial, purely
LUT-based, and hybrid approaches are compared using metrics of precision and computational
complexity.
]

// ═════════════════════════════════════════════════════════════════════════════
= Introdução
// ═════════════════════════════════════════════════════════════════════════════

A evolução dos sistemas de comunicação móveis, impulsionada pela crescente demanda por
comunicações mais rápidas e eficientes, tem levado à implementação de uma variedade de
serviços, incluindo aplicações multimídia, desenvolvimento web e aplicações IoT @John2016. No
entanto, essa evolução também trouxe desafios significativos, como a necessidade de melhorar a
eficiência energética, tanto para dispositivos móveis, visando aumentar a autonomia da bateria,
quanto para estações de rádio base, visando reduzir o consumo de energia devido às perdas de
calor. Para atender a essas demandas, estratégias de modulação que alteram tanto a fase quanto a
amplitude de ondas portadoras em radiofrequência se tornaram essenciais @Kenington2000. Além
disso, a modulação na amplitude requer linearidade na transmissão para evitar erros e
interferências na comunicação entre usuários vizinhos @Cripps2006.

Essa complexa tarefa recai sobre o projetista do amplificador de potência de radiofrequência (PA),
que enfrenta o desafio de desenvolver um hardware eficiente em termos energéticos e linear ao
mesmo tempo, uma vez que esses dois objetivos podem entrar em conflito @Chavez2018. Uma
solução para contornar esse desafio é a implementação de um pré-distorcedor digital (DPD) em
banda base, que visa compensar a distorção causada pelo PA @Cripps2006. O DPD é conectado em
cascata ao PA e requer um modelo de alta precisão e baixa complexidade computacional para
representar as características de transferência direta e inversa do amplificador.

Existem diversas abordagens para modelar o PA. Neste projeto, adota-se uma modelagem híbrida,
combinando polinômios e tabelas de consulta (LUT). Especificamente, para amostras atuais ---
em que a ordem polinomial necessária é alta ---, prioriza-se o uso de LUT; para amostras passadas
--- com ordens polinomiais menores ---, mantém-se o emprego de polinômios. Será realizada uma
comparação entre as abordagens puramente polinomial, puramente baseada em LUT e a abordagem
híbrida, avaliando-se complexidade computacional e precisão de modelagem.

== Objetivo Geral

Investigar, em software Python, estruturas alternativas do modelo _Memory Polynomial_ (MP) para
a modelagem matemática de amplificadores de potência (PA), com ênfase em abordagens que
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
  source: [#cite(<Luiza2016>, form: "prose")],
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
de potência @GonalvesdeLima2009. Por meio dessa abordagem, a saída do sistema é expressa
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
compartilham o mesmo atraso temporal @Schuartz2017. Essa simplificação reduz
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
paralelização das operações aritméticas. Nesse contexto, avalia-se a substituição de operações de
multiplicação por tabelas de consulta (_Look-Up Tables_ --- LUTs), visando reduzir a complexidade
computacional e viabilizar a implementação prática do modelo em sistemas embarcados e
plataformas digitais.

== Uso de Look-Up Tables em Pré-Distorção Digital

A implementação prática de técnicas de pré-distorção digital (DPD) em sistemas de comunicação
sem fio de alta taxa impõe restrições significativas de complexidade computacional, especialmente
quando se considera a operação em tempo real e com sinais de larga banda. Nesse contexto,
estratégias que reduzam o custo computacional da linearização, sem comprometer de forma
significativa o desempenho, têm sido amplamente investigadas na literatura. Dentre essas
estratégias, destaca-se o uso de tabelas de consulta (LUTs) como alternativa eficiente para a
implementação de pré-distorcedores digitais.

As LUTs consistem em estruturas de memória que armazenam previamente valores calculados de
uma determinada função, permitindo que operações matemáticas complexas sejam substituídas por
simples acessos à memória. Em aplicações de DPD, as LUTs podem ser utilizadas para mapear
diretamente a envoltória do sinal de entrada para valores de correção de amplitude e fase,
implementando, de forma discreta, a função inversa do PARF @Kwan2012. Essa abordagem elimina
a necessidade de operações aritméticas intensivas, como multiplicações e potências, reduzindo
significativamente a latência e o consumo de recursos computacionais.

O trabalho apresentado por @Kwan2012 demonstra a viabilidade da implementação de um
pré-distorcedor digital baseado em LUTs em plataformas do tipo _Field Programmable Gate Array_
(FPGA), utilizando sinais Long Term Evolution (LTE) com largura de banda de até 60 MHz. Uma das
principais vantagens do uso de LUTs em DPD é a adequação natural desse tipo de estrutura a
arquiteturas paralelas, como as encontradas em FPGAs. O acesso à memória pode ser realizado de
forma altamente paralelizável e determinística, favorecendo a implementação em tempo real mesmo
em cenários de elevada taxa de amostragem.

Entretanto, o uso de LUTs também apresenta desafios, como a necessidade de um processo
eficiente de preenchimento e atualização da tabela, bem como a escolha adequada do número de
entradas para evitar quantização excessiva da função de pré-distorção. Técnicas de interpolação e
estratégias de endereçamento podem ser empregadas para mitigar esses efeitos e melhorar a
precisão do modelo sem aumento significativo da complexidade @Kwan2012.

Diante desse panorama, o uso de LUTs surge como uma alternativa promissora para a
implementação de pré-distorção digital em amplificadores de potência, especialmente em
aplicações que demandam elevada largura de banda e operação em tempo real.

// ═════════════════════════════════════════════════════════════════════════════
= Material e Métodos
// ═════════════════════════════════════════════════════════════════════════════

== Modelo MP original <sec:mp-original>

Conforme detalhado no Capítulo~2, amplificadores de potência RF são dispositivos inerentemente
não lineares e sujeitos a efeitos de memória, decorrentes tanto da natureza dos sinais de banda
larga aplicados quanto das não linearidades impostas pelos circuitos internos do amplificador.
Sistemas desse tipo podem ser representados matematicamente por meio da série de Volterra.

Uma característica importante da série de Volterra, conforme destacado em @GonalvesdeLima2009,
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
  source: [#cite(<Luiza2016>, form: "prose")],
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

Além da redução de complexidade computacional, essa estrutura oferece maior flexibilidade para a
implementação em hardware. Em particular, a concentração de ordens polinomiais mais elevadas
nos termos associados à amostra atual cria condições favoráveis para a adoção de arquiteturas
híbridas, nas quais operações de maior complexidade podem ser substituídas por tabelas de
consulta (LUTs), enquanto termos de menor ordem permanecem implementados de forma
polinomial. Essa característica é explorada e avaliada nos capítulos seguintes por meio de
simulações e análises comparativas de desempenho e complexidade.

== Uso de tabelas de consulta no modelo MP <sec:lut>

A implementação prática de modelos comportamentais para amplificadores de potência em sistemas
digitais de alta taxa de amostragem impõe restrições severas em termos de complexidade
computacional, consumo de recursos e latência. Em particular, mesmo após a adoção do modelo
_Memory Polynomial_ (MP), cuja complexidade é significativamente inferior à da série completa de
Volterra, a implementação direta em hardware ainda demanda um número elevado de operações
aritméticas, sobretudo multiplicações e cálculos de potências associados a ordens polinomiais
elevadas.

Conforme discutido na seção anterior, neste trabalho adota-se uma variação do modelo MP na qual
a ordem polinomial máxima é definida de forma independente para cada atraso de memória. Essa
abordagem permite concentrar as ordens polinomiais mais elevadas nos termos associados às
amostras mais recentes, enquanto ordens menores são atribuídas aos termos de memória mais
antigos. Como consequência, a complexidade computacional deixa de ser uniformemente distribuída
entre todos os atrasos, passando a ser dominada pelos termos de menor atraso, em especial pelo
termo correspondente à amostra atual.

Nesse contexto, o uso de tabelas de consulta (_Look-Up Tables_ --- LUTs) surge como uma
estratégia complementar para reduzir a complexidade computacional associada especificamente
aos termos de maior ordem polinomial, conforme discutido em @Kwan2012. As LUTs permitem
substituir operações aritméticas complexas por simples operações de indexação e leitura de
memória, reduzindo significativamente o custo computacional e viabilizando implementações em
tempo real.

No contexto do modelo MP, a saída do amplificador pode ser expressa como uma soma ponderada
de termos da forma

$ tilde(x)(n-m) |tilde(x)(n-m)|^(p-1) , $

em que $p$ representa a ordem do polinômio e $m$ o atraso associado ao termo de memória.
Observa-se que a não linearidade do modelo está diretamente relacionada à envoltória do sinal de
entrada, enquanto a informação de fase é preservada pelo fator complexo $tilde(x)(n-m)$. Essa
separação natural entre envoltória e fase torna o modelo particularmente adequado à utilização de
LUTs, uma vez que os termos não lineares dependem apenas do módulo da envoltória do sinal.

Dessa forma, é possível implementar os termos não lineares do modelo MP por meio de LUTs
unidimensionais (1D), indexadas pelo valor quantizado da magnitude da envoltória
$|tilde(x)(n-m)|$. Para cada atraso de memória $m$, define-se uma função polinomial
unidimensional $f^sans("pol")_m (dot.c)$, que pode ser armazenada em uma LUT.

#figure(
  abnt-table(
    columns: (1fr, 1fr),
    table.header(
      [*Entrada da LUT*],
      [*Saída da LUT*],
    ),
    $|tilde(x)(n-m)|_1$, $f^sans("pol")_m (|tilde(x)(n-m)|_1)$,
    $|tilde(x)(n-m)|_2$, $f^sans("pol")_m (|tilde(x)(n-m)|_2)$,
    $dots.v$,            $dots.v$,
    $|tilde(x)(n-m)|_K$, $f^sans("pol")_m (|tilde(x)(n-m)|_K)$,
  ),
  caption: [Representação da função polinomial unidimensional do modelo MP por meio de LUTs],
  source: [Adaptado de #cite(<Luiza2016>, form: "prose")],
) <tab:tabela_lut>

O valor obtido na saída da LUT é então multiplicado apenas pelo termo complexo $tilde(x)(n-m)$,
reduzindo substancialmente o número total de operações aritméticas, conforme também observado
em @Kwan2012. A @fig:diagramamplut ilustra o diagrama de blocos da implementação do modelo
MP com o uso de LUTs.

#figure(
  image("Figuras/MP_lut.png", width: 75%),
  caption: [Implementação do modelo MP com LUTs],
  source: [#cite(<Luiza2016>, form: "prose")],
) <fig:diagramamplut>

Outro aspecto relevante é que o uso de LUTs permite desacoplar parcialmente a complexidade
computacional da ordem polinomial adotada. Uma vez construída a tabela, o aumento da ordem do
polinômio não implica, necessariamente, em um aumento proporcional do número de operações
durante a execução, mas apenas em um possível incremento no uso de memória. Esse compromisso
entre consumo de memória e redução de operações aritméticas é particularmente favorável em
plataformas modernas, como FPGAs e ASICs, nas quais recursos de memória são abundantes e
operações de multiplicação são relativamente custosas @Kwan2012.

Além da redução de complexidade, as LUTs também podem contribuir para o aumento da precisão
do modelo MP. Como os valores armazenados na tabela podem ser obtidos a partir de dados
experimentais ou de cálculos realizados em alta precisão, erros numéricos associados à
quantização e ao arredondamento durante a execução em tempo real são mitigados. Técnicas de
interpolação entre entradas adjacentes da LUT podem ser empregadas para melhorar ainda mais a
fidelidade do modelo, sem impacto significativo na complexidade computacional @Kwan2012.

Portanto, o uso de tabelas de consulta no modelo MP configura uma estratégia eficiente e
complementar para reduzir a complexidade computacional e viabilizar implementações em sistemas
digitais de alta taxa de amostragem.

// ═════════════════════════════════════════════════════════════════════════════
= Resultados e Discussão
// ═════════════════════════════════════════════════════════════════════════════

Este capítulo apresenta os resultados obtidos a partir da validação inicial das estruturas de
modelagem propostas na @sec:mp-original, com foco na caracterização do desempenho do modelo
_Memory Polynomial_ (MP) clássico aplicado à modelagem comportamental de um amplificador de
potência real. Adicionalmente, são discutidas as alterações conceituais introduzidas pela abordagem
proposta neste trabalho, bem como as etapas subsequentes previstas para sua validação completa.

Nesta versão preliminar da dissertação, os resultados concentram-se exclusivamente na modelagem
do PA utilizando o modelo MP tradicional em aritmética de ponto flutuante. As análises relacionadas
ao modelo MP com truncamento polinomial dependente do atraso, bem como às arquiteturas híbridas
baseadas em tabelas de consulta (LUTs), ainda se encontram em fase de implementação e serão
objeto de estudo aprofundado na versão final deste trabalho.

A validação dos resultados apresentados é realizada por meio da análise do erro entre o sinal de
saída medido do amplificador de potência (PA) real e o sinal de saída estimado pelo modelo
comportamental. Quanto menor o valor desse erro, maior é a precisão do modelo considerado.

Para a análise do desempenho dos modelos implementados, realiza-se a avaliação do sinal de erro
por meio do _Normalized Mean Square Error_ (NMSE) --- Erro Quadrático Médio Normalizado
@Bonfim2016. Matematicamente, o NMSE é definido por:

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
vetorial de sinais (VSA) da Rohde & Schwarz, com taxa de amostragem de 61,44~MHz, conforme
disponibilizado em @Bonfim2016.

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

== Resultados da etapa de implementação das LUTs

Nesta etapa do trabalho, os resultados concentram-se na análise conceitual e estrutural da
implementação do modelo _Memory Polynomial_ (MP) por meio de tabelas de consulta
(_lookup tables_ --- LUTs), conforme discutido na @sec:lut e fundamentado em @Kwan2012. O
objetivo principal desta fase foi avaliar a viabilidade arquitetural da substituição das operações
aritméticas não lineares do modelo MP por operações de acesso à memória, visando à redução da
complexidade computacional e à melhoria da eficiência de implementação em sistemas digitais.

É importante ressaltar que, nesta versão preliminar da dissertação, a implementação prática das
LUTs ainda não foi realizada. Assim, os resultados apresentados nesta seção limitam-se à definição
da arquitetura proposta, à identificação dos blocos funcionais necessários e à análise qualitativa dos
impactos esperados do uso de LUTs no desempenho e na complexidade do modelo.

As análises quantitativas de desempenho, incluindo métricas como NMSE, consumo de recursos e
comparação direta entre as implementações polinomial, híbrida e baseada exclusivamente em LUTs,
serão conduzidas em etapas futuras do trabalho. Essas análises considerarão, adicionalmente, a
aplicação das LUTs de forma seletiva nos termos de maior ordem polinomial, conforme a abordagem
de truncamento polinomial dependente do atraso proposta na @sec:lut.

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
comprometer significativamente sua capacidade de representação, cuja validação quantitativa será
realizada em etapas futuras deste trabalho.

Adicionalmente, foram analisadas estratégias para redução da complexidade computacional do
modelo, com destaque para o uso de tabelas de consulta (LUTs), explorando a separação entre
envoltória e fase inerente ao modelo MP, embora essa abordagem tenha sido tratada apenas em
nível conceitual nesta etapa do estudo.

Dessa forma, o trabalho alcançou seu objetivo ao validar a modelagem comportamental do
amplificador de potência em software e ao propor uma estrutura de modelagem mais flexível, além
de delinear diretrizes claras para a utilização de LUTs como ferramenta para redução de
complexidade, constituindo um passo inicial sólido para o desenvolvimento da versão final da
dissertação e para estudos futuros na área de modelagem e linearização de amplificadores de
potência.

// ─────────────────────────────────────────────────────────────────────────────
// REFERÊNCIAS  (usar o mesmo Referencias.bib copiado de Mestrado/Mestrado/)
// ─────────────────────────────────────────────────────────────────────────────

#bibliography("Referencias.bib")

// ─────────────────────────────────────────────────────────────────────────────
// APÊNDICES
// ─────────────────────────────────────────────────────────────────────────────

#appendix(
  include "assets/apendice_resultados_mp.typ",
  [Resultados completos dos modelos MP]
)
