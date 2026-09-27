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
    Dissertação apresentada ao Programa de Pós-Graduação em Engenharia Elétrica, Área de Concentração em Telecomunicações, Departamento de Engenharia Elétrica, Setor de Tecnologia, Universidade Federal do Paraná, como parte das exigências para obtenção do título de Mestre em Engenharia Elétrica.

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
A evolução dos sistemas de comunicação sem fio possibilitou o surgimento de diversas aplicações móveis e wireless, como desenvolvimento web e Internet das Coisas (IoT). Nesse contexto, a melhoria da eficiência energética é altamente desejável, tanto em dispositivos móveis, que buscam maior autonomia de bateria, quanto em estações rádio-base, que visam reduzir perdas associadas à dissipação de calor. Entretanto, o aumento da eficiência energética geralmente implica a redução da linearidade dos amplificadores de potência (PAs) utilizados nos transmissores de rádio. Essa limitação é particularmente crítica em sistemas modernos de comunicação, nos quais a largura de banda disponível é restrita e o uso de modulações complexas, que exploram variações simultâneas de amplitude e fase, é essencial para alcançar elevadas taxas de transmissão. Modulações sensíveis à amplitude tornam-se especialmente suscetíveis às não linearidades do PA, resultando em degradação do desempenho e aumento dos erros de transmissão.

Uma solução amplamente empregada para conciliar eficiência energética e linearidade é a utilização da pré-distorção digital (Digital Predistortion --- DPD) em cascata com o PA. A eficácia dessa técnica depende diretamente da disponibilidade de modelos matemáticos capazes de representar com precisão o comportamento não linear e com memória do amplificador. Nesta dissertação, inicialmente investiga-se uma variação do modelo Memory Polynomial (MP), na qual a ordem polinomial passa a depender do atraso de memória, permitindo maior flexibilidade na modelagem e redução da complexidade computacional sem prejuízo significativo de desempenho. Além da avaliação em software, investiga-se a implementação desse modelo em VHDL, com validação funcional em vírgula fixa e análise da complexidade estrutural obtida na síntese lógica. Os resultados indicam NMSE de $-26,7$~dB para o MP clássico no conjunto GaN HEMT, $-37,51$~dB para o MP completo no conjunto LDMOS e reduções próximas de 40% em métricas estruturais da implementação VHDL truncada, incluindo `wires`, células e registradores.
]

// ─────────────────────────────────────────────────────────────────────────────
// ABSTRACT
// ─────────────────────────────────────────────────────────────────────────────

#abstract-foreign[
The evolution of wireless communication systems has enabled the emergence of various mobile and wireless applications, such as web development and the Internet of Things (IoT). In this context, improving energy efficiency is highly desirable, both for mobile devices seeking greater battery life and for radio base stations aiming to reduce losses associated with heat dissipation. However, increasing energy efficiency generally implies reducing the linearity of power amplifiers (PAs) used in radio transmitters. This limitation is particularly critical in modern communication systems, where the available bandwidth is restricted and the use of complex modulations, exploiting simultaneous amplitude and phase variations, is essential to achieve high transmission rates. Amplitude-sensitive modulations are especially susceptible to PA nonlinearities, resulting in performance degradation and increased transmission errors.

A widely used solution to reconcile energy efficiency and linearity is the use of digital predistortion (DPD) in cascade with the PA. The effectiveness of this technique depends directly on the availability of mathematical models capable of accurately representing the nonlinear and memory behavior of the amplifier. In this dissertation, a variation of the Memory Polynomial (MP) model is initially investigated, in which the polynomial order depends on the memory delay, allowing greater modeling flexibility and reduced computational complexity without significant performance loss. In addition to the software-based evaluation, the VHDL implementation of this model is investigated, with fixed-point functional validation and analysis of the structural complexity obtained from logic synthesis. The results indicate an NMSE of $-26.7$~dB for the classical MP on the GaN HEMT dataset, $-37.51$~dB for the full MP on the LDMOS dataset, and reductions close to 40% in structural metrics of the truncated VHDL implementation, including wires, cells, and registers.
]

// ═════════════════════════════════════════════════════════════════════════════
= Introdução
// ═════════════════════════════════════════════════════════════════════════════

A evolução dos sistemas de comunicação móveis, impulsionada pela crescente demanda por comunicações mais rápidas e eficientes, tem levado à implementação de uma variedade de serviços, incluindo aplicações multimídia, desenvolvimento web e aplicações IoT @Yu2024. No entanto, essa evolução também trouxe desafios significativos, como a necessidade de melhorar a eficiência energética, tanto para dispositivos móveis, visando aumentar a autonomia da bateria, quanto para estações de rádio base, visando reduzir o consumo de energia devido às perdas de calor. Para atender a essas demandas, estratégias de modulação que alteram tanto a fase quanto a amplitude de ondas portadoras em radiofrequência se tornaram essenciais @Kenington2000. Além disso, a modulação na amplitude requer linearidade na transmissão para evitar erros e interferências na comunicação entre usuários vizinhos @Cripps2006.

Essa complexa tarefa recai sobre o projetista do amplificador de potência de radiofrequência (PA), que enfrenta o desafio de desenvolver um hardware eficiente em termos energéticos e linear ao mesmo tempo, uma vez que esses dois objetivos podem entrar em conflito @Cripps2006. Uma solução para contornar esse desafio é a implementação de um pré-distorcedor digital (DPD) em banda base, que visa compensar a distorção causada pelo PA @Cripps2006. O DPD é conectado em cascata ao PA e requer um modelo de alta precisão e baixa complexidade computacional para representar as características de transferência direta e inversa do amplificador.

O modelo de polinômio com memória (MP) tradicional utiliza uma mesma ordem polinomial máxima em todos os atrasos. Embora essa uniformidade simplifique a formulação, ela pode manter termos de alta ordem associados a amostras antigas, cuja contribuição tende a ser menor, aumentando desnecessariamente o número de coeficientes e operações. Essa limitação motiva a investigação apresentada a seguir. Nesta dissertação, investigam-se ordens polinomiais dependentes do atraso e avalia-se o compromisso entre precisão e complexidade, bem como a viabilidade de implementação em hardware.

== Objetivo Geral

Investigar e validar, em software e hardware, estruturas alternativas do modelo _Memory Polynomial_ (MP) para a modelagem matemática de PAs, com ênfase em ordens polinomiais dependentes do atraso e no compromisso entre precisão do modelo e complexidade de implementação. A validação em hardware compreende a descrição das arquiteturas em VHDL, a comparação funcional com o modelo de referência em Python e a análise da complexidade estrutural após a síntese lógica.

== Objetivos Específicos

Para alcançar o objetivo geral, este trabalho foi desenvolvido com base nos seguintes objetivos específicos:

+ Implementar, em software Python, o modelo _Memory Polynomial_ tradicional para a modelagem comportamental de amplificadores de potência;

+ Desenvolver e implementar uma variação do modelo MP com ordens polinomiais dependentes do atraso, permitindo truncamentos polinomiais distintos para cada ramo de memória;

+ Avaliar o desempenho dos modelos propostos por meio de métricas de erro, com ênfase no _Normalized Mean Square Error_ (NMSE);

+ Analisar a relação entre a complexidade estrutural dos modelos, expressa pelo número de coeficientes, e a precisão obtida, por meio de uma abordagem de otimização multiobjetivo baseada na fronteira de Pareto;

+ Identificar configurações de modelos MP que apresentem melhor compromisso entre desempenho e complexidade, visando futuras implementações eficientes.

+ Implementar em VHDL, com aritmética de vírgula fixa, as arquiteturas do modelo MP clássico e do modelo com ordem dependente do atraso;

+ Validar funcionalmente as saídas da implementação VHDL com GHDL, compará-las com o modelo de referência em Python e avaliar a estrutura sintetizada com Yosys. Realizar, no ModelSim, a simulação temporal da implementação completa destinada à FPGA, analisando a latência, os atrasos de propagação e a taxa de processamento do circuito.

// ═════════════════════════════════════════════════════════════════════════════
= Revisão de Literatura
// ═════════════════════════════════════════════════════════════════════════════

A evolução dos sistemas de comunicações sem fio tem impulsionado o desenvolvimento de diversas aplicações móveis. Nesse contexto, a eficiência energética emerge como uma característica essencial, beneficiando tanto a autonomia de baterias em dispositivos móveis quanto a redução de perdas em estações rádio-base, nas quais parte significativa da energia consumida é dissipada na forma de calor.

Um sistema de comunicação pode ser dividido em três subsistemas principais: transmissor, receptor e meio de propagação @Schuartz2017. Este trabalho concentra-se exclusivamente no subsistema transmissor, ilustrado na @fig:sistemadetrasmissao, que inclui os componentes responsáveis pela geração, conversão, filtragem e amplificação do sinal antes da irradiação pela antena. Dentre esses blocos, o amplificador de potência (PA) destaca-se como um dos elementos de maior consumo energético, pois converte energia em corrente contínua (CC), fornecida pela fonte de alimentação, em energia de radiofrequência (RF) entregue à antena. Assim, a eficiência global do transmissor depende diretamente do desempenho do PA.

#figure(
  image("Figuras/sistematrasmissorpng.png", width: 55%),
  caption: [Sistema de transmissão simplificado],
  source: [#cite(<Schuartz2017>, form: "prose")],
) <fig:sistemadetrasmissao>

== Sistema Transmissor

== Amplificadores de Potência em RF

O componente central do PA é o transistor, responsável pela amplificação da potência do sinal de entrada proveniente de estágios anteriores da cadeia de transmissão. Nesse processo, energia CC das fontes de alimentação é convertida em energia CA/RF. Para maximizar a potência entregue à carga, o PA deve apresentar alta eficiência, definida como a relação entre a potência de saída $P_("out")$ e a potência consumida da fonte CC $P_("cc")$:

$ eta = (P_("out") / P_("cc")) times 100% $ <eq:rendimento>

Devido a imperfeições nos componentes e às condições reais de operação, a eficiência ideal de 100% nunca é alcançada. Além do transistor, o circuito do PA inclui redes de casamento de impedância de entrada e saída, responsáveis por otimizar a transferência de potência, e um circuito de polarização CC, que estabelece as condições adequadas de operação do dispositivo ativo. Esses elementos, compostos por componentes como capacitores e indutores, também introduzem efeitos dinâmicos no amplificador, usualmente chamados de efeitos de memória. A @fig:circuitoparf apresenta um circuito simplificado de PA.

#figure(
  image("Figuras/circuito parf.png", width: 55%),
  caption: [Circuito simplificado de um PA],
  source: [#cite(<Luiza2016>, form: "prose")],
) <fig:circuitoparf>

Tipicamente, a eficiência do PA aumenta com a potência de saída, atingindo valores mais elevados quando o dispositivo opera próximo à saturação. A potência que não é convertida em sinal útil é dissipada como calor, elevando custos de projeto, reduzindo a confiabilidade e exigindo estruturas de dissipação térmica. Assim, maximizar a eficiência do PA é um objetivo central no projeto de redes de telecomunicações.

Outra característica fundamental é a linearidade, normalmente avaliada pela curva de transferência, que relaciona a potência de saída à potência de entrada, em dBm, como exemplificado na @fig:saidaparf. Nessa curva, observa-se uma região aproximadamente linear para baixas potências de entrada, seguida de uma região de compressão de ganho. O ponto de compressão de 1 dB indica a potência para a qual o ganho do amplificador se reduz em 1 dB em relação ao regime de pequeno sinal. Próximo à saturação, o ganho diminui progressivamente, aumentando a distorção do sinal transmitido.

#figure(
  image("Figuras/curvasaidaparf.png", width: 55%),
  caption: [Curva de transferência de um PA],
  source: [#cite(<Chavez2018>, form: "prose")],
) <fig:saidaparf>

A largura de banda disponível para sistemas de comunicação sem fio é um recurso naturalmente limitado, o que torna essencial sua utilização de maneira eficiente. À medida que cresce a demanda por maiores taxas de transmissão de dados, surge a necessidade de empregar técnicas de modulação capazes de transmitir mais informação dentro da mesma faixa espectral. Nesse contexto, as maiores taxas de transmissão são alcançadas por esquemas de modulação que exploram simultaneamente variações de fase e de amplitude da onda portadora em radiofrequência @Kenington2000.

Entretanto, o uso de modulações que envolvem variações de amplitude impõe requisitos mais rigorosos sobre a linearidade dos sistemas de transmissão. A falta de linearidade pode resultar em distorções do sinal transmitido, ocasionando erros de comunicação e interferências indesejadas em canais adjacentes @Kenington2000. Dessa forma, garantir um comportamento linear ao longo da cadeia de transmissão torna-se um aspecto crítico para a qualidade e a confiabilidade do sistema de comunicação.

Nesse cenário, o projeto do PA assume papel central, uma vez que esse componente fornece a potência necessária ao sinal modulado antes de sua transmissão pela antena. O principal desafio do projetista consiste em conciliar requisitos conflitantes: alta eficiência energética e boa linearidade. Amplificadores de potência tendem a apresentar maior eficiência quando operam próximos à região de saturação; contudo, nessa região de operação, o dispositivo passa a apresentar comportamento fortemente não linear @Cripps2006. Assim, embora a operação próxima à saturação seja desejável do ponto de vista energético, ela compromete a linearidade do amplificador e constitui um dos principais desafios no projeto de sistemas modernos de comunicação sem fio.

=== Comportamento Passa Banda do PA

Nos sistemas modernos de telecomunicações, a transmissão de dados é realizada por meio de sinais em radiofrequência, cujas frequências centrais situam-se tipicamente na ordem dos GHz. Esses sinais são modulados por uma envoltória complexa, responsável por carregar a informação, cuja largura de banda encontra-se usualmente na faixa dos MHz. Como a largura de banda do sinal modulado é significativamente menor do que a frequência da portadora, tais sinais são classificados como sinais passa banda @Luiza2016.

Uma forma conveniente de analisar sinais passa banda consiste em representá-los por meio de sua forma equivalente em banda-base. Essa representação separa a portadora de alta frequência da envoltória complexa, permitindo uma análise mais intuitiva dos efeitos introduzidos pelo sistema de transmissão, especialmente no que se refere às variações de amplitude e fase. Essa abordagem é amplamente utilizada na modelagem comportamental de amplificadores de potência, pois facilita a identificação e a caracterização das distorções causadas pelas não linearidades do circuito do PA.

O amplificador de potência em radiofrequência desempenha papel fundamental na cadeia de transmissão, sendo responsável por fornecer potência suficiente ao sinal antes de sua irradiação pela antena. Entretanto, os dispositivos ativos que compõem o PA apresentam comportamento inerentemente não linear, especialmente quando operam próximos à região de saturação. Como consequência, essas não linearidades afetam diretamente sinais passa banda, que possuem múltiplas componentes espectrais concentradas em torno da frequência central.

A @fig:comportamentopassabanda ilustra, no domínio da frequência, os espectros dos sinais de entrada e saída de um PA passa banda. Enquanto o espectro de entrada está concentrado na banda desejada, o de saída apresenta espalhamento espectral, decorrente dos produtos de intermodulação gerados pelas não linearidades do amplificador.

#figure(
  image("Figuras/comportamento passa banda.png", width: 100%),
  caption: [Exemplo de distorção espectral de um PA],
  source: [#cite(<Pedro2005>, form: "prose")],
) <fig:comportamentopassabanda>

Esse espalhamento espectral é particularmente indesejável em sistemas de comunicação sem fio, pois pode causar interferência em canais adjacentes, degradando o desempenho de usuários vizinhos e violando requisitos regulatórios de emissão espectral. Além disso, a presença de distorções no sinal transmitido compromete a qualidade da comunicação e reduz a eficiência espectral do sistema. Dessa forma, a compreensão do comportamento passa banda do PA é essencial para o desenvolvimento de técnicas de linearização, como a pré-distorção digital, que visam mitigar os efeitos das não linearidades e preservar a integridade do sinal transmitido @Luiza2016.

== Linearização de Amplificadores de Potência

Conforme discutido na seção anterior, as não linearidades inerentes aos PAs causam distorções significativas em sinais passa banda, resultando em espalhamento espectral e interferência em canais adjacentes. Esse efeito torna-se especialmente crítico nos sistemas modernos de comunicação sem fio, nos quais a largura de banda disponível é limitada e há uma demanda crescente por maiores taxas de transmissão de dados. Para atender a esses requisitos, são amplamente empregadas modulações digitais complexas que variam simultaneamente a amplitude e a fase do sinal, como QAM e OFDM @Kenington2000.

Entretanto, tais esquemas de modulação impõem elevados requisitos de linearidade ao sistema de transmissão, uma vez que qualquer não linearidade introduzida pelo PA afeta diretamente a envoltória do sinal, comprometendo sua integridade e degradando a qualidade da comunicação. Por outro lado, a operação do amplificador em regiões estritamente lineares geralmente ocorre longe da saturação, o que implica baixa eficiência energética. Esse comportamento evidencia o compromisso fundamental entre eficiência e linearidade nos PAs @Cripps2006. A baixa eficiência resulta em maior dissipação térmica, reduzindo a autonomia de dispositivos móveis alimentados por bateria e elevando os custos operacionais em estações rádio-base.

Diante desse cenário, diversas técnicas de linearização têm sido desenvolvidas com o objetivo de mitigar os efeitos das não linearidades do PA, permitindo sua operação em regiões mais eficientes sem comprometer a qualidade do sinal transmitido. Dentre essas técnicas, a pré-distorção digital (_Digital Predistortion_ --- DPD) destaca-se pelo compromisso favorável entre desempenho e custo de implementação @Kenington2000. A técnica de DPD consiste em aplicar, em banda-base, uma distorção controlada ao sinal de entrada, de forma que sua característica de transferência seja aproximadamente inversa à do PA.

Quando o sinal pré-distorcido é aplicado ao amplificador, as não linearidades do PA compensam a distorção introduzida pelo DPD, resultando em um comportamento global aproximadamente linear do sistema em cascata. Esse conceito é ilustrado na @fig:cascatadpd, que apresenta o esquema de um pré-distorcedor digital operando em conjunto com o PA para o qual foi projetado. Para que essa compensação seja eficaz, torna-se necessário que o DPD seja capaz de representar com precisão não apenas o comportamento não linear estático do amplificador, mas também seus efeitos de memória.

#figure(
  image("Figuras/DPDcascata.png", width: 55%),
  caption: [Esquema de pré-distorcedor digital em cascata com PA],
  source: [#cite(<Chavez2018>, form: "prose")],
) <fig:cascatadpd>

Nesse contexto, a modelagem comportamental constitui uma etapa fundamental no desenvolvimento de técnicas de pré-distorção digital. O diagrama de blocos apresentado na @fig:diagramamodelagem exemplifica essa abordagem, na qual um modelo matemático é submetido ao mesmo sinal de entrada aplicado ao amplificador de potência, representado por $x(t)$. A saída simulada do modelo, $y_("sim")(t)$, é então comparada com a saída real do PA, $y_("real")(t)$.

Os coeficientes do modelo são ajustados a partir do erro entre $y_("real")(t)$ e $y_("sim")(t)$, por meio de algoritmos de otimização cujo objetivo é minimizar esse erro. Quando o erro mínimo é alcançado, o modelo é considerado otimizado e capaz de reproduzir adequadamente o comportamento do amplificador de potência. Nessa condição, o modelo pode ser empregado na implementação do pré-distorcedor digital, possibilitando a linearização do PA e a mitigação do espalhamento espectral @Luiza2016.

#figure(
  image("Figuras/diagrama simulação.png", width: 55%),
  caption: [Diagrama de modelagem comportamental],
  source: [#cite(<Luiza2016>, form: "prose")],
) <fig:diagramamodelagem>

== Modelos Comportamentais

Conforme discutido na seção anterior, a técnica de DPD depende diretamente da capacidade de representar com precisão o comportamento não linear do PA. Para que a linearização seja eficaz, o pré-distorcedor deve reproduzir, de forma inversa, as características do amplificador, compensando tanto as não linearidades estáticas quanto os efeitos dinâmicos associados à memória do dispositivo. Dessa forma, torna-se indispensável o uso de modelos matemáticos capazes de descrever adequadamente o comportamento do PA sob diferentes condições de operação.

Nos sistemas modernos de comunicação sem fio, a limitação de largura de banda disponível leva à adoção de esquemas de modulação com elevada variação de envoltória, caracterizados por altos valores de _Peak-to-Average Power Ratio_ (PAPR). Esses sinais impõem requisitos rigorosos ao PA, que deve operar de forma eficiente do ponto de vista energético sem comprometer a linearidade. Para atender a essas exigências, as técnicas de linearização demandam modelos computacionais precisos do comportamento do amplificador @John2016.

De maneira geral, as abordagens de modelagem de amplificadores de potência podem ser classificadas em duas categorias principais: modelagem física e modelagem comportamental. A modelagem física baseia-se no conhecimento detalhado da topologia do circuito, dos dispositivos semicondutores e dos componentes passivos que constituem o amplificador. Embora essa abordagem possa oferecer elevada precisão, sua aplicação é limitada pela alta complexidade computacional e pela dificuldade de obtenção de todos os parâmetros físicos necessários. Em contrapartida, a modelagem comportamental, também conhecida como empírica, fundamenta-se exclusivamente na observação da relação entre os sinais de entrada e saída do sistema, sem a necessidade de informações detalhadas sobre a estrutura interna do circuito. Essa característica torna os modelos comportamentais particularmente atrativos para aplicações de simulação e linearização, devido à sua menor complexidade computacional.

Aplicações recentes reforçam essa relevância prática em cenários de elevada largura de banda e restrições de implementação. Estruturas abertas para modelagem de PA e aprendizagem de DPD têm sido propostas para padronizar a comparação entre modelos e acelerar a validação com sinais OFDM de centenas de MHz @Wu2024OpenDPD. Além disso, abordagens de DPD com precisão mista e parâmetros quantizados mostram que a redução de complexidade e de consumo computacional continua sendo uma exigência central para a aplicação de modelos comportamentais em transmissores modernos @Wu2024MPDPD.

No contexto da pré-distorção digital, a modelagem comportamental é amplamente preferida, uma vez que o objetivo principal é reproduzir o comportamento inverso observável do PA. Além das não linearidades estáticas, os efeitos de memória --- isto é, a dependência da saída atual em relação a amostras passadas do sinal de entrada --- desempenham um papel relevante no comportamento do amplificador. Dessa forma, os sistemas podem ser classificados como sem memória ou com memória, sendo esta última categoria a mais representativa para amplificadores operando com sinais de larga banda.

Dentre os diversos modelos comportamentais propostos na literatura, destacam-se os modelos polinomiais com memória e as redes neurais artificiais. Embora as redes neurais apresentem elevada capacidade de aproximação, sua implementação pode acarretar maior complexidade computacional. Neste trabalho, opta-se por modelos baseados em simplificações da série de Volterra, priorizando estruturas polinomiais devido ao seu compromisso favorável entre capacidade de modelagem e custo computacional, como observado em extensões do polinômio com memória generalizado @Morgan2006 e em formulações polinomiais aplicadas a cenários de identificação não linear mais amplos @Li2021.

=== Séries de Volterra

A série de Volterra constitui uma extensão da série de Taylor para a representação de sistemas não lineares dinâmicos com memória, sendo amplamente utilizada na modelagem de amplificadores de potência @Schetzen1980. Por meio dessa abordagem, a saída do sistema é expressa como uma combinação de integrais múltiplas envolvendo o sinal de entrada e núcleos que caracterizam o comportamento do sistema em diferentes ordens de não linearidade.

Matematicamente, a saída $y(t)$ de um sistema descrito pela série de Volterra pode ser expressa como:

$ y(t) = h_0 + sum_(n=1)^(infinity) integral_(-infinity)^(infinity) dots.c integral_(-infinity)^(infinity) h_n (tau_1, dots.c, tau_n) product_(i=1)^(n) x(t - tau_i) , d tau_i $ <eq:Volterra>

em que $h_n (tau_1, dots.c, tau_n)$ representa o núcleo de Volterra de ordem $n$, responsável por descrever os efeitos não lineares e de memória do sistema. Embora a série de Volterra forneça uma descrição bastante geral e precisa do comportamento de sistemas não lineares com memória, sua aplicação prática é limitada pela elevada complexidade computacional. Por esse motivo, na maioria das aplicações, a série é truncada para ordens finitas, restringindo o número de termos considerados.

=== Polinômio com Memória

O modelo de polinômio com memória (_Memory Polynomial_ --- MP) surge como uma simplificação da série de Volterra, obtida pela consideração apenas dos termos diagonais, isto é, daqueles que compartilham o mesmo atraso temporal @Kim2001. Essa simplificação reduz significativamente a complexidade do modelo, ao mesmo tempo em que preserva a capacidade de representar não linearidades e efeitos de memória de forma satisfatória para uma ampla classe de amplificadores de potência.

O modelo MP pode ser descrito matematicamente por:

$ y(n) = sum_(p=1)^(P) sum_(m=0)^(M) h_(p,m) , x(n - m) |x(n - m)|^(p-1) $ <eq:mp>

em que $P$ representa a ordem de não linearidade do modelo, $M$ corresponde à profundidade de memória considerada, e $h_(p,m)$ são os coeficientes do modelo. Uma das principais vantagens do modelo de polinômio com memória é sua linearidade nos parâmetros, o que facilita a estimativa dos coeficientes por meio de técnicas de otimização convencionais. Além disso, esse modelo apresenta boa eficácia na representação de amplificadores de potência com efeitos de memória moderados, sendo amplamente empregado em aplicações de pré-distorção digital.

Para o modelo MP original adotado como referência neste trabalho, considera-se ordem polinomial $P = 5$ e profundidade de memória $M = 2$, resultando em 15 coeficientes complexos. Nessa configuração, a @eq:mp pode ser organizada em três blocos de memória:

$ y(n) =
  bold(h)_0^T bold(phi)_0(n) + bold(h)_1^T bold(phi)_1(n - 1) + bold(h)_2^T bold(phi)_2(n - 2) $ <eq:mp-original-p5-m2>

em que cada bloco contém cinco coeficientes e cinco termos polinomiais:

$ bold(h)_m^T = mat(h_(1,m), h_(2,m), h_(3,m), h_(4,m), h_(5,m)) $ <eq:coeficientes-bloco-mp>

$ bold(phi)_m(n - m) = mat(
  x(n - m);
  x(n - m)|x(n - m)|;
  x(n - m)|x(n - m)|^2;
  x(n - m)|x(n - m)|^3;
  x(n - m)|x(n - m)|^4
) $ <eq:termos-bloco-mp>

Assim, para $m in {0, 1, 2}$, a estrutura total do MP original é composta por três vetores de coeficientes, cada um com cinco elementos, totalizando 15 coeficientes.

Observa-se que, na formulação tradicional do modelo MP, a ordem polinomial máxima $P$ é adotada de forma uniforme para todos os termos de memória, independentemente do atraso considerado. Essa restrição, embora simplifique a estrutura do modelo, pode resultar em um aumento desnecessário da complexidade computacional, especialmente para termos associados a atrasos mais elevados, cujos efeitos não lineares tendem a ser menos pronunciados. Dessa forma, a adoção de ordens polinomiais diferenciadas em função do atraso de memória surge como uma alternativa potencial para reduzir a complexidade do modelo, mantendo sua capacidade de representação.

Do ponto de vista de implementação em hardware, especialmente em sistemas que operam com altas taxas de amostragem, torna-se fundamental explorar arquiteturas eficientes que permitam a paralelização das operações aritméticas. Nesse contexto, a implementação em VHDL do modelo MP com truncamento polinomial dependente do atraso permite avaliar de forma direta se a redução de complexidade observada em software se traduz em menor utilização de recursos em hardware digital, preservando a equivalência funcional do modelo. Trabalhos voltados à análise de compromissos de hardware em séries de Volterra podadas @Talemwa2025 reforçam a importância de tratar desempenho de modelagem e custo estrutural de forma conjunta.

== Descrição de Hardware em VHDL e Arquiteturas Digitais para DPD

A implementação prática de modelos comportamentais para pré-distorção digital depende não apenas da formulação matemática adotada, mas também da forma como essa formulação é traduzida para uma arquitetura de hardware. Em sistemas de transmissão de alta taxa, o processamento deve acompanhar o fluxo contínuo de amostras em banda-base, o que torna a organização temporal das operações tão importante quanto o número total de coeficientes do modelo.

Nesse contexto, linguagens de descrição de hardware, como VHDL, são utilizadas para especificar circuitos digitais em diferentes níveis de abstração. Diferentemente de linguagens de programação sequenciais, o VHDL descreve comportamento concorrente, sinais, registradores, processos sincronizados por relógio e estruturas combinacionais que podem ser sintetizadas em hardware físico @Ashenden2008. A padronização da linguagem pelo IEEE também favorece portabilidade, simulação e síntese em diferentes ferramentas, desde que o código seja escrito de acordo com subconjuntos sintetizáveis da linguagem @IEEE10762008.

Para aplicações de DPD, o uso de VHDL permite representar explicitamente elementos essenciais da arquitetura digital, como linhas de atraso, multiplicadores, somadores, registradores de _pipeline_, tratamento de sinais complexos e aritmética de vírgula fixa. Essa proximidade com a estrutura do circuito é relevante porque modelos matematicamente equivalentes podem produzir custos de hardware distintos, dependendo da ordem das operações, do compartilhamento de recursos e da quantidade de registradores necessária para cumprir requisitos de temporização.

=== Representação em Vírgula Fixa

Embora a identificação inicial dos coeficientes seja frequentemente realizada em vírgula flutuante, implementações em FPGA e ASIC tendem a empregar aritmética de vírgula fixa para reduzir área, consumo e latência. A conversão do modelo para vírgula fixa exige definir largura de palavra, número de bits fracionários, estratégia de arredondamento e tratamento de saturação ou truncamento. Essas escolhas afetam diretamente a precisão numérica e a estabilidade da implementação, especialmente em modelos polinomiais, nos quais potências da amplitude podem ampliar erros de quantização.

Em arquiteturas para MP, cada termo $x(n-m)|x(n-m)|^(p-1)$ combina uma amostra complexa atrasada com potências de sua magnitude. Assim, a largura dos sinais internos tende a crescer ao longo das multiplicações. Uma arquitetura sintetizável precisa controlar esse crescimento por meio de redimensionamentos intermediários, preservando precisão suficiente para que a saída em hardware permaneça equivalente à referência em software. Por esse motivo, a validação funcional entre Python e VHDL constitui uma etapa indispensável antes da análise de recursos de síntese.

=== Estratégias Arquiteturais para Modelos Polinomiais

As arquiteturas digitais para modelos de DPD podem ser organizadas de diferentes formas. Uma primeira abordagem consiste na implementação direta da soma de produtos, na qual cada termo do modelo possui seu próprio caminho aritmético e os resultados parciais são acumulados ao final. Essa alternativa favorece paralelismo e alta vazão, pois vários termos podem ser calculados simultaneamente, mas tende a aumentar o número de multiplicadores e somadores necessários.

Outra possibilidade é o compartilhamento temporal de recursos, no qual uma quantidade menor de operadores aritméticos é reutilizada em ciclos sucessivos. Essa estratégia reduz área, porém aumenta latência e pode limitar a taxa máxima de processamento. Em aplicações de comunicação sem fio, essa escolha depende da taxa de amostragem, da frequência máxima do circuito e da disponibilidade de recursos digitais no dispositivo alvo.

Também são comuns arquiteturas baseadas em tabelas de busca (_look-up tables_ --- LUTs), nas quais parte da relação não linear é armazenada em memória e acessada conforme a amplitude do sinal. Embora essa abordagem possa substituir operações aritméticas custosas por acessos à memória, seu desempenho depende do número de entradas, da resolução de quantização e do método empregado para calcular ou interpolar os endereços.

=== Arquiteturas Baseadas em LUT e Compartilhamento de Recursos

Gilabert et al. apresentam uma implementação adaptativa em FPGA baseada em múltiplas LUTs e em um modelo não linear autorregressivo de média móvel (NARMA). A estrutura organiza a compensação dos efeitos de memória em células básicas de pré-distorção e explora a realimentação do modelo para limitar a quantidade de tabelas necessária. A arquitetura também separa a execução contínua do pré-distorcedor do processo de atualização dos coeficientes, permitindo que a adaptação seja realizada em uma taxa inferior à taxa de amostragem do sinal @Gilabert2008. Essa solução reduz o custo da representação não linear, mas a natureza recursiva introduz dependências temporais que precisam ser consideradas no controle e na análise de estabilidade.

Guan e Zhu propõem uma arquitetura de baixo custo derivada da série de Volterra que combina indexação de ganho assistida por LUT e multiplexação por divisão de tempo. A LUT é empregada para evitar o cálculo direto de parte das funções não lineares, enquanto os multiplicadores são compartilhados entre diferentes termos do modelo ao longo de ciclos sucessivos @Guan2010. A redução do número de operadores diminui a ocupação do FPGA, porém exige frequência de relógio interna suficiente para executar todas as operações associadas a uma amostra antes da chegada da amostra seguinte.

Para o MP, Kwan et al. adotam múltiplas LUTs e aritmética de vírgula fixa em uma implementação destinada a sinais LTE com largura de banda de 60 MHz. Os coeficientes são identificados por meio de mínimos quadrados recursivos baseados em decomposição QR, enquanto a arquitetura em FPGA realiza a aplicação do pré-distorcedor. Os autores reportam redução de latência em relação à implementação em vírgula flutuante e melhoria de até 20 dB no nível de emissão do canal adjacente @Kwan2012. Nesse caso, a economia em operadores aritméticos é acompanhada por maior demanda de memória e pela necessidade de definir cuidadosamente a resolução das tabelas.

Li et al. generalizam essa estratégia por meio de uma arquitetura escalável formada por células básicas de pré-distorção e descrita com síntese de alto nível. A proposta pode representar diferentes modelos com memória cujas funções de base sejam decompostas nessas células, permitindo variar o tamanho das LUTs e observar seus efeitos sobre utilização de recursos, vazão e consumo de potência @Li2021HLS. Em comparação com uma descrição RTL específica, a síntese de alto nível facilita a exploração arquitetural, embora a qualidade do circuito dependa das diretivas de síntese e da capacidade da ferramenta de inferir paralelismo e memória.

Em arquiteturas bidimensionais para transmissão em duas bandas, Zhang et al. combinam um modelo MP segmentado com multiplexação temporal híbrida. A seleção vetorial divide o espaço de amplitudes em regiões, cada uma associada a um submodelo de menor ordem, enquanto LUTs de modulação cruzada e multiplicadores complexos são compartilhados entre os ramos. Os resultados apresentados pelos autores indicam economia aproximada de 30% de memória RAM e 80% de recursos DSP, acompanhada de melhorias de 18,74 dB em ACPR e 13,23 dB em NMSE @Zhang2024HTDM. Apesar de tratar um cenário de duas bandas, o trabalho demonstra como segmentação do modelo e compartilhamento temporal podem ser combinados para reduzir recursos.

=== Arquiteturas Paralelas e Otimização Numérica

Uma alternativa ao compartilhamento temporal consiste em manter os ramos polinomiais em paralelo e inserir registradores entre os estágios aritméticos. Rahmanian et al. desenvolvem uma arquitetura paralela de MP em vírgula fixa e avaliam o impacto dos comprimentos de palavra sobre o erro de modulação e a potência no canal adjacente. Além da quantização, os autores reorganizam caminhos aritméticos e acrescentam estágios de _pipeline_ para reduzir o caminho crítico e elevar a frequência máxima de operação @Rahmanian2020. Essa abordagem privilegia vazão e previsibilidade temporal, ao custo de maior quantidade de multiplicadores, somadores e registradores.

Li, Montoro e Gilabert implementam um DPD baseado em GMP tanto em FPGA quanto em GPU e comparam precisão, utilização de recursos, vazão e desempenho de linearização. O estudo mostra que ambas as plataformas podem atender ao processamento de sinais 5G NR de banda larga, mas evidencia compromissos distintos: a FPGA permite uma arquitetura especializada e determinística, enquanto a GPU oferece maior flexibilidade de programação @Li2024GPUFPGA. Para esta tese, a implementação em FPGA constitui a referência mais próxima, pois permite relacionar diretamente a estrutura do modelo com operadores, registradores e memória física.

Para modelos derivados da série de Volterra, a complexidade estrutural cresce rapidamente com a ordem não linear e com a profundidade de memória. Morgan et al. mostram que o GMP amplia a capacidade de modelagem ao incluir termos cruzados entre diferentes atrasos, mas essa maior generalidade também implica aumento do número de operações @Morgan2006. Talemwa et al. analisam uma série de Volterra podada e exploram diferentes graus de paralelismo em unidades de multiplicação e acumulação, tratando conjuntamente desempenho de linearização e consumo do circuito @Talemwa2025. Esses resultados reforçam que a redução do número de funções de base somente se converte em benefício prático quando a arquitetura também elimina ou compartilha os operadores correspondentes.

=== Síntese Comparativa das Abordagens

Os trabalhos analisados podem ser agrupados segundo quatro mecanismos principais de redução de custo: substituição de operações não lineares por LUTs @Gilabert2008 @Kwan2012 @Li2021HLS; compartilhamento temporal de multiplicadores @Guan2010 @Zhang2024HTDM; poda ou segmentação das funções de base @Talemwa2025 @Zhang2024HTDM; e otimização da representação numérica e do _pipeline_ @Rahmanian2020. As estratégias não são excludentes e podem ser combinadas, mas afetam de formas distintas a área, a memória, a latência e a vazão.

Uma comparação quantitativa direta entre os resultados publicados requer cautela, pois os trabalhos utilizam dispositivos FPGA, larguras de palavra, taxas de amostragem, sinais de teste, amplificadores e ordens de modelo diferentes. Assim, valores absolutos de LUTs lógicas, blocos DSP ou frequência máxima não devem ser interpretados isoladamente. Para a comparação experimental desta tese, serão priorizadas métricas normalizadas pela configuração do modelo, como número de termos implementados, operadores por amostra, latência em ciclos e variação percentual dos recursos em relação ao MP original.

=== Relação com o Modelo MP de Ordem Dependente do Atraso

O modelo MP com ordem polinomial dependente do atraso pode ser interpretado como uma estratégia intermediária entre a implementação completa e a poda estrutural de termos. Em vez de eliminar termos de forma arbitrária, a proposta reduz a ordem máxima de cada ramo de memória de acordo com a relevância observada dos atrasos. Dessa forma, a arquitetura resultante preserva a organização regular do MP, mas remove multiplicações, coeficientes e somas associados aos termos polinomiais de menor contribuição.

Do ponto de vista de hardware, essa característica é especialmente útil porque a redução de coeficientes se traduz diretamente em menor quantidade de produtos complexos e menor profundidade da árvore de soma. Além disso, ao manter maior ordem apenas no atraso atual e em atrasos próximos, a arquitetura concentra recursos nos ramos que mais contribuem para a precisão do modelo, estabelecendo um compromisso explícito entre acurácia, área e complexidade estrutural.

// ═════════════════════════════════════════════════════════════════════════════
= Material e Métodos
// ═════════════════════════════════════════════════════════════════════════════

== Modelo MP original <sec:mp-original>

Conforme detalhado no Capítulo~2, amplificadores de potência RF são dispositivos inerentemente não lineares e sujeitos a efeitos de memória, decorrentes tanto da natureza dos sinais de banda larga aplicados quanto das não linearidades impostas pelos circuitos internos do amplificador. Sistemas desse tipo podem ser representados matematicamente por meio da série de Volterra.

Uma característica importante da série de Volterra, conforme discutido por @Schetzen1980, é sua linearidade em relação aos parâmetros, o que permite estimar seus coeficientes por meio de técnicas de identificação linear, como o método dos mínimos quadrados. No entanto, o número de parâmetros cresce rapidamente com a ordem não linear e a profundidade de memória, resultando em modelos de elevada complexidade computacional.

Para viabilizar o uso da série de Volterra em aplicações práticas, mesmo com polinômios de ordem elevada e múltiplos termos de memória, diversos modelos comportamentais propostos na literatura aplicam simplificações dessa representação matemática. Um exemplo é o modelo comportamental apresentado em @Kim2001, conhecido como modelo MP.

O modelo MP pode ser interpretado como uma extensão do modelo polinomial estático, incorporando efeitos de memória por meio de uma forma reduzida da série de Volterra. Nessa abordagem, apenas produtos de amostras correspondentes ao mesmo instante de tempo são considerados. Matematicamente, o modelo MP é descrito pela @eq:mp, na qual todos os polinômios que compõem o modelo possuem a mesma ordem @Kim2001. A configuração original utilizada como referência empírica neste trabalho é dada pela @eq:mp-original-p5-m2.

Entre as principais características do modelo MP, destaca-se o fato de que ele é baseado em multiplicações de sinais avaliados no mesmo instante de tempo, como $tilde(x)(n)|tilde(x)(n)|$ e $tilde(x)(n-1)|tilde(x)(n-1)|$. Além disso, como o modelo depende de informações passadas da fase da envoltória do sinal de entrada, ele é capaz de representar fenômenos associados às variações de fase da envoltória, incluindo as conversões PM--AM (_phase modulation to amplitude modulation_) e PM--PM (_phase modulation to phase modulation_). A @fig:mp_padrao apresenta o diagrama de blocos do modelo MP.

#figure(
  image("Figuras/mp_padrao.png", width: 75%),
  caption: [Diagrama de blocos do modelo MP],
  source: [#cite(<Kim2001>, form: "prose")],
) <fig:mp_padrao>

=== Polinômio com Memória com Truncamento Polinomial Dependente do Atraso

Conforme discutido na Seção~2.3.2, o modelo de Polinômio com Memória (MP) tradicional adota uma ordem polinomial máxima uniforme para todos os termos de memória. Embora essa abordagem simplifique a estrutura do modelo, ela pode resultar em um aumento desnecessário da complexidade computacional, uma vez que os efeitos não lineares associados a amostras mais antigas tendem a ser menos significativos do que aqueles relacionados à amostra atual.

Com o objetivo de explorar essa característica, propõe-se neste trabalho uma variação do modelo MP na qual a ordem polinomial máxima passa a ser definida de forma independente para cada atraso de memória. Dessa forma, o modelo deixa de utilizar um único parâmetro de ordem polinomial $P$ e passa a empregar um conjunto de ordens $\{P_0, P_1, dots.c, P_M\}$, em que $P_m$ representa a ordem polinomial máxima associada ao termo de atraso $m$.

Matematicamente, o modelo proposto pode ser expresso como:

$ y(n) = sum_(m=0)^(M) sum_(p=1)^(P_m) h_(p,m) , x(n - m) |x(n - m)|^(p-1) $ <eq:mp_truncado>

em que $M$ corresponde à profundidade de memória do modelo, $P_m$ define a ordem polinomial máxima associada ao atraso $m$, e $h_(p,m)$ são os coeficientes complexos a serem estimados. Observa-se que o modelo MP tradicional constitui um caso particular da @eq:mp_truncado, obtido quando se impõe $P_0 = P_1 = dots.c = P_M = P$.

A principal motivação dessa abordagem reside na possibilidade de reduzir o número total de coeficientes do modelo sem comprometer significativamente sua capacidade de representação. Em particular, espera-se que a escolha de ordens polinomiais não crescentes com o aumento do atraso, isto é, $P_0 >= P_1 >= dots.c >= P_M$, seja suficiente para capturar os efeitos não lineares dominantes do amplificador de potência, concentrados majoritariamente na amostra atual e nos atrasos mais próximos.

Do ponto de vista de identificação, o modelo proposto preserva a linearidade nos parâmetros, permitindo a estimação dos coeficientes por meio de técnicas de mínimos quadrados convencionais, de forma análoga ao MP clássico. A diferença reside na construção da matriz de regressão, que passa a incorporar apenas os termos polinomiais correspondentes a cada ordem $P_m$, resultando em uma matriz de menor dimensão.

Além da redução de complexidade computacional, essa estrutura oferece vantagens diretas para a implementação em hardware. Como o número de termos polinomiais deixa de ser uniforme entre os atrasos, a descrição em VHDL pode ser reorganizada para eliminar explicitamente operações aritméticas desnecessárias, reduzindo o número de blocos funcionais do circuito sem alterar a formulação matemática do modelo.

== Arquitetura de hardware proposta <sec:arquitetura-hardware-proposta>

A arquitetura proposta implementa em VHDL um predistorcedor digital baseado em MP, com processamento complexo em vírgula fixa, paralelismo entre os produtos e organização em _pipeline_. A estrutura foi concebida para receber uma nova amostra a cada ciclo de relógio após o preenchimento inicial do _pipeline_, mantendo separados os caminhos real e imaginário ao longo do processamento.

=== Formulação generalizada e configuração implementada

Na implementação em hardware são utilizadas somente funções de base de ordem ímpar. Para evitar ambiguidade com a formulação geral da @eq:mp_truncado, o índice $q$ representa, nesta seção, a posição da função de base dentro de cada ramo. Considerando profundidade de memória $M$, são implementados os atrasos $m in {0, dots.c, M}$, totalizando $M+1$ ramos. A quantidade de funções de base de cada ramo é definida pelo vetor

$ bold(P) = mat(P_0, P_1, dots.c, P_M), $ <eq:vetor-ordens-hardware>

no qual $P_m$ indica quantos termos de ordem ímpar são preservados no atraso $m$. Dessa forma, o modelo implementável é descrito genericamente por

$ y(n) = sum_(m=0)^M sum_(q=0)^(P_m - 1) c_(m,q) x(n-m) |x(n-m)|^(2q), $ <eq:mp-hardware>

em que $c_(m,q)$ é o coeficiente complexo associado ao termo $q$ do ramo $m$. O número total de termos complexos, e consequentemente de coeficientes, é

$ N_"termos" = sum_(m=0)^M P_m. $ <eq:numero-termos-hardware>

Seguindo a representação vetorial adotada na @eq:mp-original-p5-m2, a expressão anterior pode ser reescrita como uma soma de produtos internos:

$ y(n) = sum_(m=0)^M bold(c)_m^T bold(phi)_m(n-m), $ <eq:mp-hardware-expandido>

para a qual os vetores associados a cada atraso são definidos por

$ bold(c)_m^T = mat(c_(m,0), c_(m,1), dots.c, c_(m,P_m - 1)) $ <eq:coeficientes-mp-hardware>

e

$ bold(phi)_m(n-m) = mat(
  x(n-m);
  x(n-m)|x(n-m)|^2;
  dots.v;
  x(n-m)|x(n-m)|^(2(P_m - 1))
). $ <eq:termos-mp-hardware>

A arquitetura desenvolvida neste trabalho corresponde à instanciação $M=2$ e $bold(P)=(5,3,1)$. Portanto, o ramo da amostra atual contém as ordens polinomiais 1, 3, 5, 7 e 9; o ramo do primeiro atraso contém as ordens 1, 3 e 5; e o ramo do segundo atraso contém apenas o termo linear. Essa configuração totaliza nove termos complexos. Em comparação com uma implementação uniforme com cinco funções de base em cada um dos três ramos, o número de termos é reduzido de 15 para 9, correspondendo a uma redução estrutural de 40% antes de serem consideradas as particularidades de síntese dos operadores.

A @fig:pipeline-dpd-clock apresenta a organização funcional e a sequência temporal implementadas no código VHDL para a configuração $bold(P)=(5,3,1)$. O banco de atrasos fornece as amostras $x(n-m)$ aos ramos de processamento, nos quais o módulo quadrático $r_m(n)=|x(n-m)|^2$ é reutilizado na geração recursiva das funções de base. Depois do alinhamento temporal, as funções selecionadas são ponderadas pelos respectivos coeficientes complexos e combinadas por uma árvore balanceada de soma. A figura acompanha uma mesma amostra complexa pelas fronteiras de registro e identifica os sinais associados a cada processo. Como os processos síncronos são acionados pela mesma borda de subida, cada estágio utiliza os valores registrados no ciclo anterior, enquanto a lógica combinacional prepara os valores que serão capturados na borda seguinte.

#figure(
  image("Figuras/pipeline_dpd_por_clock.svg", width: 100%),
  caption: [Diagrama temporal da arquitetura VHDL do DPD. As operações são apresentadas segundo as bordas sucessivas do relógio, desde a captura da entrada até o registro da saída. A geração recursiva e o alinhamento temporal operam de forma sobreposta no _pipeline_.],
  source: [Autor.],
) <fig:pipeline-dpd-clock>

No ciclo $C_1$, o processo `delay_process` converte `UR` e `UI` para a representação inteira interna, insere a nova amostra em `delay_line(0)` e desloca as amostras anteriores. Em $C_2$, a lógica `gen_prep_power` calcula, em paralelo para todos os atrasos, as componentes de base e o módulo quadrático $|x(n-m)|^2$; os resultados são armazenados por `prep_power_process` em `base_vec` e `msq_vec`.

Entre $C_3$ e $C_7$, `terms_pipe_process` registra sucessivamente os termos $T_(m,q)=x(n-m)|x(n-m)|^(2q)$. O termo linear é registrado em `term_pipe(0)` no ciclo $C_3$, e cada estágio posterior multiplica o termo anterior pelo módulo quadrático. Ao mesmo tempo, `align_process` desloca em `align_pipe` os termos produzidos mais cedo. O termo linear recebe quatro atrasos adicionais, enquanto os termos seguintes recebem, respectivamente, três, dois, um e nenhum atraso adicional. Dessa forma, todas as cinco ordens relativas à mesma janela de entrada ficam temporalmente alinhadas em $C_8$.

No ciclo $C_9$, `pack_xx_process` seleciona, segundo $bold(P)=(5,3,1)$, os nove termos válidos e os registra no vetor `XX`. Em $C_10$, `mult_process` registra os nove produtos complexos calculados em paralelo por `gen_mult`. Entre as bordas $C_10$ e $C_11$, os quatro níveis combinacionais de `sum_tree` reduzem esses produtos a uma única soma complexa. Finalmente, em $C_11$, `sum_process` satura as componentes real e imaginária e as registra em `UR_out` e `UI_out`.

A sequência de $C_1$ a $C_11$ representa a latência de uma amostra específica através da arquitetura. Essa latência não corresponde ao intervalo entre saídas consecutivas: como os estágios operam simultaneamente sobre amostras diferentes, após o preenchimento inicial do _pipeline_ o circuito aceita uma nova amostra complexa e produz uma nova saída a cada ciclo de relógio. Assim, a vazão teórica em regime permanente é de uma amostra complexa por ciclo, limitada pela frequência máxima validada na simulação temporal realizada no ModelSim.

#figure(
  align(center,
    block(width: 86%)[
      #text(size: 8pt, table(
        columns: (12%, 18%, 70%),
        align: (center, center, left),
        inset: (x: 5pt, y: 4pt),
        table.header([*Ramo*], [*Índices em `XX`*], [*Funções de base*]),
        [$m=0$], [0--4], [
          $x(n)$, $x(n)|x(n)|^2$, $x(n)|x(n)|^4$,
          $x(n)|x(n)|^6$ e $x(n)|x(n)|^8$
        ],
        [$m=1$], [5--7], [
          $x(n-1)$, $x(n-1)|x(n-1)|^2$ e $x(n-1)|x(n-1)|^4$
        ],
        [$m=2$], [8], [$x(n-2)$],
      ))
    ],
  ),
  caption: [Organização compacta dos nove termos no vetor `XX` para $bold(P)=(5,3,1)$.],
  source: [Autor.],
) <tab:termos-xx>

=== Entrada complexa e linha de atrasos

A entrada é formada pelos sinais `UR` e `UI`, correspondentes às componentes real e imaginária de $x(n)$. Cada componente possui 11 bits e é interpretada como um inteiro com sinal. Após a conversão para a representação numérica interna, a amostra é inserida em uma linha de atrasos que disponibiliza simultaneamente $x(n)$, $x(n-1)$ e $x(n-2)$. Essa estrutura fornece as três posições temporais necessárias à @eq:mp-hardware.

Para cada posição da linha de atrasos, o circuito calcula o módulo quadrático da amostra complexa segundo

$ |x(n-m)|^2 = Re{x(n-m)}^2 + Im{x(n-m)}^2. $ <eq:modulo-quadratico-hardware>

São necessárias duas multiplicações reais para elevar as componentes ao quadrado e uma soma para produzir o módulo quadrático. Como essas operações aumentam a largura da palavra, o resultado passa por um ajuste de escala antes de ser utilizado nos estágios seguintes. A amostra complexa e o módulo quadrático ajustado são então armazenados nos registradores `base_vec` e `msq_vec`. Esse primeiro estágio de _pipeline_ separa o cálculo da potência da geração das funções de base e reduz o caminho combinacional.

=== Geração recursiva e alinhamento dos termos

As funções de base são geradas recursivamente. Para cada atraso $m$, o termo inicial é

$ T_(m,0) = x(n-m), $

e os termos seguintes são calculados por

$ T_(m,q) = T_(m,q-1) |x(n-m)|^2. $ <eq:recorrencia-termos-hardware>

Consequentemente, $T_(m,q) = x(n-m)|x(n-m)|^(2q)$. Essa recorrência reutiliza o resultado do estágio anterior, evitando o cálculo independente das potências da magnitude. As multiplicações são distribuídas em estágios sucessivos de _pipeline_, o que permite limitar a lógica combinacional entre registradores.

Os termos de diferentes ordens não ficam naturalmente disponíveis no mesmo ciclo: o termo linear é obtido antes dos termos que atravessam uma ou mais multiplicações recursivas. A rede de registradores `align_pipe` compensa essas diferenças de latência, atrasando os resultados produzidos mais cedo. Dessa forma, todos os termos associados à mesma janela de entrada chegam simultaneamente à etapa de ponderação pelos coeficientes. Após o alinhamento, os nove termos válidos são selecionados conforme a @tab:termos-xx e empacotados no vetor `XX`.

=== Multiplicação pelos coeficientes

O banco de coeficientes contém nove valores complexos quantizados, um para cada elemento de `XX`. Os nove produtos complexos são calculados em paralelo. Considerando $c_k = c_(k,R) + j c_(k,I)$ e $X_k = X_(k,R) + j X_(k,I)$, cada produto é decomposto em

$ Re{c_k X_k} = c_(k,R) X_(k,R) - c_(k,I) X_(k,I), $

$ Im{c_k X_k} = c_(k,R) X_(k,I) + c_(k,I) X_(k,R). $

Essa forma direta utiliza quatro multiplicações reais, uma soma e uma subtração por produto complexo. Os resultados passam pelas operações de redimensionamento previstas na implementação em vírgula fixa e são registrados antes da acumulação. O paralelismo dessa etapa aumenta o uso instantâneo de operadores, mas permite sustentar o processamento contínuo de amostras sem reutilização temporal dos multiplicadores.

=== Árvore de soma e saída

Os nove produtos ponderados são acumulados por uma árvore binária de soma. Em cada nível, os valores são agrupados em pares; quando o número de elementos é ímpar, o elemento restante é propagado ao nível seguinte. Para nove entradas, a redução requer quatro níveis, pois $ceil(log_2 9) = 4$. Em comparação com uma cadeia de oito somadores, essa organização reduz a profundidade do caminho combinacional e facilita o atendimento às restrições de temporização.

Ao final da árvore, as componentes real e imaginária são limitadas à faixa representável pelas saídas de 11 bits. A saturação impede o retorno modular em situações de _overflow_, comportamento que ocorreria caso os bits mais significativos fossem simplesmente descartados. O resultado saturado é convertido para `STD_LOGIC_VECTOR` e armazenado nos registradores `UR_out` e `UI_out`.

O fluxo completo da arquitetura é, portanto, composto por seis etapas: armazenamento das amostras na linha de atrasos; cálculo de $|x|^2$; geração recursiva das funções de base; alinhamento temporal e formação de `XX`; multiplicação paralela pelos coeficientes; e acumulação seguida de saturação. A combinação de paralelismo, _pipeline_ e alinhamento explícito torna a arquitetura adequada ao processamento contínuo em FPGA, enquanto a distribuição $bold(Q) = (5, 3, 1)$ elimina funções de base dos atrasos em que foram consideradas menos relevantes.

== Metodologia de validação da proposta <sec:metodologia-validacao>

A validação da proposta foi organizada de forma integrada, contemplando a implementação em software, a implementação em hardware e a aplicação do modelo tanto à modelagem direta quanto à linearização do PA. Em software, os coeficientes dos modelos MP foram estimados em Python a partir de dados medidos de entrada e saída, e a precisão foi avaliada em conjuntos independentes de validação. Em hardware, as estruturas foram descritas em VHDL com aritmética de vírgula fixa, permitindo comparar sua equivalência funcional com o modelo em Python e analisar os recursos estruturais após a síntese lógica.

O erro de modelagem foi quantificado pelo _Normalized Mean Square Error_ (NMSE) --- erro quadrático médio normalizado @Muha1999, definido por:

$ "NMSE" = 10 log_(10) lr(( frac(
  sum_(n=1)^(N) |e(n)|^2,
  sum_(n=1)^(N) |y_"real" (n)|^2
) )) $ <eq:nmse>

em que $y_"real" (n)$ é a amostra medida na saída do PA, $e(n) = y_"real" (n) - y_"model" (n)$ é o erro entre a saída medida e a estimada, e $N$ é o número de amostras consideradas. Valores de NMSE mais negativos indicam menor erro normalizado.

Foram considerados dois conjuntos de dados empíricos. O primeiro corresponde a medições de um amplificador de potência classe AB, do tipo GaN HEMT, excitado por uma portadora de 900~MHz modulada por um sinal WCDMA 3GPP com largura de banda aproximada de 3,84~MHz e amostrado a 61,44~MHz. O segundo corresponde a medições de um amplificador LDMOS, organizadas em 4.500 amostras complexas para extração dos coeficientes e 4.500 amostras complexas para validação. Em ambos os casos, os dados disponíveis são pares complexos de entrada e saída do PA, adequados para identificação, validação e comparação entre estruturas de modelo.

=== Implementação em VHDL do modelo MP truncado

A validação em hardware foi realizada por meio da implementação em VHDL de duas arquiteturas: a versão original do modelo MP, com ordem polinomial uniforme em todos os atrasos, e a versão truncada com ordem dependente do atraso. Ambas foram descritas em vírgula fixa e organizadas em uma estrutura baseada em soma de produtos complexos, preservando os ramos de memória e o cálculo explícito dos termos polinomiais.

Na versão truncada, a redução da ordem polinomial nos atrasos mais antigos foi acompanhada por uma reorganização da arquitetura para remover diretamente as operações redundantes. Dessa forma, a comparação entre as duas implementações permite avaliar não apenas a equivalência funcional em relação ao modelo de referência em Python, mas também os ganhos efetivos de complexidade estrutural obtidos após a síntese lógica.

Para a verificação funcional e estrutural, foram empregadas ferramentas open source e da Xilinx. A análise inicial do código VHDL e a simulação funcional em nível RTL foram realizadas com GHDL, enquanto o GTKWave foi utilizado para a inspeção das formas de onda. A síntese lógica e o levantamento da estrutura inferida foram realizados com Yosys. Nessa etapa, as saídas em vírgula fixa obtidas em Python e em VHDL, juntamente com as curvas AM-AM e AM-PM, foram comparadas para verificar a equivalência funcional entre as implementações.

Após a verificação funcional, a implementação completa destinada à FPGA foi submetida à simulação temporal no ModelSim. Essa simulação considerou os atrasos associados ao circuito implementado e permitiu observar o intervalo entre a aplicação das amostras de entrada e a disponibilização das saídas válidas. A análise das formas de onda foi utilizada para determinar a latência do _pipeline_, verificar o atendimento à temporização e avaliar a taxa de processamento sustentada pelo circuito. Como a arquitetura é totalmente segmentada, após o preenchimento inicial do _pipeline_ ela pode aceitar uma nova amostra complexa a cada ciclo de relógio; consequentemente, sua taxa de processamento é determinada pela frequência de operação validada na simulação temporal.

=== Evidências empíricas para o truncamento polinomial

Com o objetivo de fundamentar empiricamente a hipótese de que a não linearidade dominante do amplificador está concentrada no instante atual, foi realizada uma análise específica sobre o conjunto LDMOS descrito anteriormente. Nessa etapa, foram consideradas profundidade de memória $M = 2$ e ordens polinomiais variando de 1 a 5, utilizando três análises complementares: magnitude dos coeficientes por ramo de memória, sensibilidade do NMSE a cada parâmetro $P_m$ e espectro do erro residual.

Na análise dos coeficientes, foi treinado um modelo MP completo com $P_0 = P_1 = P_2 = 5$, obtendo-se NMSE de $-38,47$ dB. A energia dos ramos de memória foi então calculada por

$ E_m = sum_(p=1)^(P_"max") |h_(p,m)|^2, $

permitindo quantificar a contribuição relativa de cada atraso à não linearidade total do sistema. Adicionalmente, para avaliar a sensibilidade do modelo a cada ordem polinomial, dois parâmetros foram mantidos fixos em 1 enquanto o terceiro variou entre 1 e 5, medindo-se o ganho de NMSE produzido pelo aumento de complexidade em cada ramo. Por fim, o sinal de erro residual foi analisado no domínio da frequência com janela de Blackman, FFT de 8192 pontos e média por blocos, permitindo verificar como a variação de $P_0$, $P_1$ e $P_2$ afeta o _regrowth_ espectral.

=== Avaliação em múltiplos conjuntos de dados

Para verificar a capacidade de generalização da metodologia, o _pipeline_ completo de identificação e avaliação dos modelos MP com ordem dependente do atraso foi aplicado aos dois conjuntos empíricos descritos anteriormente. Em ambos os casos, foram avaliadas exaustivamente todas as 125 combinações possíveis de ordens $(P_0, P_1, P_2)$ com $P_m in {1, 2, 3, 4, 5}$ e profundidade de memória $M = 2$.

Os coeficientes complexos de cada modelo foram estimados em Python com `scipy.optimize.least_squares`, utilizando os conjuntos de extração, e o desempenho foi avaliado nos conjuntos de validação por meio do NMSE. Essa etapa permitiu comparar não apenas o nível absoluto de desempenho entre tecnologias distintas de amplificadores, mas também a estabilidade dos padrões estruturais observados anteriormente, como a predominância de $P_0$ e a eficiência dos modelos com distribuição não crescente de ordens.

=== Identificação do sistema DPD + PA

Além da modelagem direta do amplificador, foi avaliado um sistema completo de pré-distorção digital baseado no modelo MP. Nessa etapa, utilizou-se o conjunto de medições do PA LDMOS para identificar inicialmente o modelo do PA com profundidade de memória $M = 2$ e ordem polinomial $P = 5$, totalizando 15 coeficientes complexos. Em seguida, foi adotada a arquitetura _Indirect Learning Architecture_ (ILA), na qual o DPD é treinado como o inverso do PA a partir do mapeamento entre a saída medida do amplificador e o sinal de entrada original.

A cascata final considerada foi composta por $x(n) -> "DPD"(x(n)) -> "PA"("DPD"(x(n)))$. Para evitar extrapolação do modelo polinomial, foi aplicado um fator global de ganho na entrada do sistema. Foram avaliadas duas estratégias: uma baseada na razão entre amplitudes máximas de entrada e saída do PA, resultando em valor aproximado de 0,83, e outra com ganho fixo de 0,95, que apresentou melhor aproveitamento da faixa dinâmica e melhor qualidade de linearização nas curvas AM-AM e AM-PM. A @fig:cascata-dpd-pa ilustra o encadeamento dos blocos do sistema.

#figure(
  image("Figuras/DPDcascata.png", width: 70%),
  caption: [Diagrama em cascata do pré-distorcedor digital e do PA.],
  source: [#cite(<Chavez2018>, form: "prose")],
) <fig:cascata-dpd-pa>

// ═════════════════════════════════════════════════════════════════════════════
= Resultados e Discussão
// ═════════════════════════════════════════════════════════════════════════════

Este capítulo apresenta os resultados obtidos a partir da validação inicial das estruturas de modelagem propostas na @sec:mp-original, com foco na caracterização do desempenho do modelo _Memory Polynomial_ (MP) clássico aplicado à modelagem comportamental de um amplificador de potência real. Além da validação em vírgula flutuante, são apresentados os resultados do modelo MP com truncamento polinomial dependente do atraso e sua implementação em VHDL, com ênfase na equivalência funcional em vírgula fixa e na redução de complexidade estrutural obtida em síntese.

Os conjuntos de dados, a métrica NMSE e os procedimentos de validação estão descritos na @sec:metodologia-validacao. Neste capítulo, são apresentados os resultados da modelagem do PA, da avaliação dos truncamentos e da implementação em VHDL. Valores mais negativos de NMSE correspondem a menor erro normalizado e, portanto, a melhor aproximação dos dados medidos.

== Modelagem do PA com MP original

Nesta seção são apresentados os resultados da modelagem comportamental do amplificador de potência (PA) utilizando o modelo _Memory Polynomial_ (MP) original, conforme descrito no Capítulo~3. Esta etapa tem como principal objetivo estabelecer uma referência de desempenho (_baseline_) que servirá de comparação para as abordagens alternativas propostas neste trabalho, em especial o modelo MP com truncamento polinomial dependente do atraso.

A implementação do modelo foi realizada em ambiente Python, empregando aritmética em vírgula flutuante, com o intuito de avaliar o desempenho do MP em um cenário de alta precisão numérica, sem restrições impostas por quantização ou limitações de hardware. Essa escolha permite isolar os efeitos da estrutura do modelo, garantindo que eventuais limitações observadas estejam associadas predominantemente à capacidade de representação do modelo MP, e não a aspectos relacionados à implementação ou à aritmética utilizada.

A @fig:modelopafloat apresenta o diagrama representativo do modelo do PA implementado em vírgula flutuante.

#figure(
  image("Figuras/modelopafloat.png", width: 50%),
  caption: [Modelo do PA com MP Original],
  source: [Autor],
) <fig:modelopafloat>

A identificação dos coeficientes do modelo foi realizada por meio de um procedimento de otimização numérica, utilizando métodos de mínimos quadrados aplicados à formulação do erro entre o sinal de saída real do PA e o sinal estimado pelo modelo. Após o processo de identificação, o desempenho do modelo foi avaliado em um conjunto de dados distinto daquele utilizado na etapa de estimação dos coeficientes, de forma a evitar sobreajuste.

Para a configuração considerada, o modelo MP original alcançou um valor de NMSE igual a $-26,7$~dB, evidenciando uma boa capacidade de aproximação do comportamento do amplificador de potência real em regime de banda larga. Esse resultado confirma a adequação do modelo MP clássico como referência de desempenho e estabelece um ponto de comparação consistente para a avaliação das estruturas alternativas propostas neste trabalho.

== Evidências empíricas para o truncamento polinomial dependente do atraso

Com o objetivo de sustentar empiricamente a hipótese de truncamento polinomial dependente do atraso, foi realizada uma análise específica sobre o conjunto LDMOS descrito na @sec:metodologia-validacao. As evidências foram organizadas em três frentes complementares: análise da magnitude dos coeficientes por ramo de memória, sensibilidade do NMSE às ordens $P_0$, $P_1$ e $P_2$, e inspeção do espectro do erro residual.

=== Evidência 1: magnitude dos coeficientes por ramo de memória

Um modelo MP completo com $P_0 = P_1 = P_2 = 5$ foi treinado, atingindo NMSE de $-38,47$ dB. A energia de cada ramo foi obtida a partir da soma dos módulos quadráticos dos coeficientes associados a cada atraso.

#figure(
  kind: table,
  caption: [Energia dos coeficientes por ramo de memória para o modelo MP completo.],
  source: [Autor],
  table(
    columns: (auto, auto, auto),
    align: center,
    table.header([*Atraso m*], [*Energia $E_m$*], [*Relativa a $m = 0$*]),
    [$m = 0$], [20,5751], [100,0%],
    [$m = 1$], [13,7146], [66,7%],
    [$m = 2$], [4,8489], [23,6%],
  ),
) <tab:energia-ramos-memoria>

#figure(
  image("Figuras/ev1_magnitude_coeficientes.png", width: 85%),
  caption: [Magnitude dos coeficientes $|h_(p,m)|$ e energia $E_m$ por ramo de memória. O decaimento de energia ao longo dos atrasos evidencia que a não linearidade dominante está concentrada no instante atual.],
  source: [Autor],
) <fig:ev1-magnitude-coeficientes>

A @tab:energia-ramos-memoria mostra um decaimento monotônico da energia com o atraso, indicando que os ramos mais antigos contribuem progressivamente menos para o comportamento não linear do sistema. Esse resultado fornece evidência empírica para a adoção de ordens polinomiais não crescentes ao longo da memória.

A @fig:ev1-magnitude-coeficientes complementa essa análise ao mostrar a magnitude dos coeficientes em cada ramo: os coeficientes de maior magnitude concentram-se no atraso atual, enquanto os ramos mais antigos apresentam menor energia agregada.

=== Evidência 2: sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$

Para isolar a contribuição de cada parâmetro, dois ramos foram mantidos com ordem 1 enquanto o terceiro variou entre 1 e 5. O ponto de partida comum foi o modelo $(1,1,1)$, com NMSE de $-28,71$ dB.

#figure(
  kind: table,
  caption: [Sensibilidade do NMSE à variação individual das ordens polinomiais.],
  source: [Autor],
  table(
    columns: (auto, auto, auto, auto),
    align: center,
    table.header([*Parâmetro variado*], [*NMSE em $P=1$*], [*NMSE em $P=5$*], [*Δ NMSE*]),
    [$P_0$], [$-28,71$ dB], [$-35,36$ dB], [*6,66 dB*],
    [$P_1$], [$-28,71$ dB], [$-32,14$ dB], [3,43 dB],
    [$P_2$], [$-28,71$ dB], [$-30,20$ dB], [1,49 dB],
  ),
) <tab:sensibilidade-nmse-ordens>

#figure(
  image("Figuras/ev2_sensibilidade_nmse.png", width: 85%),
  caption: [Sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$. O ganho associado a $P_0$ é significativamente superior aos obtidos para os atrasos mais antigos.],
  source: [Autor],
) <fig:ev2-sensibilidade-nmse>

A @tab:sensibilidade-nmse-ordens quantifica a melhora de NMSE para cada ramo, e a @fig:ev2-sensibilidade-nmse apresenta visualmente essas três tendências. O incremento associado a $P_0$ (6,66 dB) supera o de $P_1$ (3,43 dB) em 3,23 dB e o de $P_2$ (1,49 dB) em 5,17 dB. Como esses valores estão em escala logarítmica, a comparação é expressa por diferenças em dB. Os resultados mostram que a complexidade polinomial deve ser concentrada no ramo do instante atual, enquanto os atrasos mais antigos apresentam ganhos marginais.

=== Evidência 3: espectro do erro residual

O erro residual foi analisado no domínio da frequência para diferentes configurações de modelo, utilizando PSD com janela de Blackman, FFT de 8192 pontos e média por blocos.

#figure(
  image("Figuras/ev3_espectro_erro.png", width: 100%),
  caption: [PSD do erro residual para variações de $P_0$, $P_1$ e $P_2$.],
  source: [Autor],
) <fig:ev3-espectro-erro>

Na @fig:ev3-espectro-erro, os três painéis isolam a influência de cada ramo: o primeiro varia $P_0$, mantendo $P_1 = P_2 = 1$; o segundo varia $P_1$, com $P_0 = P_2 = 1$; e o terceiro varia $P_2$, com $P_0 = P_1 = 1$. A curva pontilhada representa a saída medida do PA, a referência cinza corresponde ao modelo $(1,1,1)$ e as demais curvas mostram o erro residual das ordens testadas. Ao aumentar $P_0$, o NMSE melhora de $-28,7$ dB para $-33,9$ dB e $-35,4$ dB. Para $P_1$, a melhora é de $-28,7$ dB para $-31,8$ dB e depois apenas para $-32,1$ dB; para $P_2$, chega a aproximadamente $-30,2$ dB e praticamente satura entre as ordens 3 e 5.

#figure(
  image("Figuras/ev_bonus_psd_completo.png", width: 85%),
  caption: [PSD comparativa entre o sinal de entrada, a saída medida do PA e os erros de modelagem de diferentes configurações. A redução do espalhamento espectral é mais pronunciada quando se aumenta $P_0$.],
  source: [Autor],
) <fig:ev-bonus-psd-completo>

Na @fig:ev-bonus-psd-completo, a comparação entre entrada, saída medida e erros de modelagem mostra que o espalhamento espectral residual diminui mais quando a ordem do instante atual aumenta. Em conjunto, as @fig:ev3-espectro-erro e @fig:ev-bonus-psd-completo confirmam, no domínio da frequência, o padrão observado nas análises de coeficientes e NMSE: aumentar $P_0$ reduz mais efetivamente o erro residual e o _regrowth_ espectral, enquanto aumentos em $P_1$ e $P_2$ produzem ganhos menores.

== Avaliação do Modelo MP com Ordem Dependente do Atraso

Nesta seção é apresentada a avaliação do modelo _Memory Polynomial_ (MP) com ordem polinomial dependente do atraso. Diferentemente do modelo MP tradicional, no qual todos os ramos de memória utilizam uma mesma ordem polinomial máxima, a abordagem analisada permite que cada atraso possua um truncamento polinomial próprio. Tal estratégia visa investigar a influência individual da ordem polinomial associada a cada atraso no desempenho global do modelo.

Para essa análise, foi considerada uma profundidade de memória $M = 2$, sendo avaliadas todas as combinações possíveis de ordens polinomiais $(P_0, P_1, P_2)$ variando de 1 a 5. Esse procedimento resultou em um total de 125 modelos distintos, todos treinados em vírgula flutuante. Para cada modelo, foram registrados o valor do NMSE e a quantidade total de coeficientes utilizada.

A @fig:desempenho125modelos apresenta o desempenho dos 125 modelos avaliados, relacionando o NMSE com o número total de coeficientes. De maneira geral, observa-se que o aumento da quantidade de coeficientes tende a melhorar a precisão do modelo. Entretanto, nota-se que esse fator, isoladamente, não é determinante para a obtenção de melhores resultados. Modelos com complexidade semelhante podem apresentar desempenhos significativamente distintos, indicando que a distribuição da ordem polinomial entre os atrasos exerce papel fundamental na acurácia do modelo.

#figure(
  image("Figuras/desempenho125modelos.png", width: 75%),
  caption: [Desempenho dos 125 modelos MP com ordem dependente do atraso],
  source: [Autor],
) <fig:desempenho125modelos>

=== Influência da ordem polinomial nos respectivos atrasos

Nesta etapa, é analisada a influência individual da ordem polinomial associada a cada atraso de memória sobre o desempenho do modelo. Os gráficos da @fig:influenciap0, da @fig:influenciap1 e da @fig:influenciap2 mostram a relação entre o NMSE e a ordem polinomial correspondente aos atrasos $m=0$, $m=1$ e $m=2$, respectivamente, considerando todos os modelos avaliados.

#figure(
  image("Figuras/influenciap0.png", width: 75%),
  caption: [Influência da ordem polinomial no instante atual ($P_0$)],
  source: [Autor],
) <fig:influenciap0>

#figure(
  image("Figuras/influenciap1.png", width: 75%),
  caption: [Influência da ordem polinomial no atraso $m=1$ ($P_1$)],
  source: [Autor],
) <fig:influenciap1>

#figure(
  image("Figuras/influenciap2.png", width: 75%),
  caption: [Influência da ordem polinomial no atraso $m=2$ ($P_2$)],
  source: [Autor],
) <fig:influenciap2>

Na @fig:influenciap0, a distribuição dos NMSEs se desloca de forma mais acentuada para valores negativos menores quando $P_0$ aumenta, indicando que elevar a ordem no instante atual melhora substancialmente a representação da não linearidade dominante. A @fig:influenciap1 também mostra melhora com o aumento de $P_1$, mas o deslocamento é menos pronunciado e parte da dispersão permanece, pois os demais ramos variam entre os modelos. Já na @fig:influenciap2, a mudança entre ordens é menor: os pontos se concentram em faixas de NMSE próximas, sugerindo que termos de alta ordem no atraso mais antigo acrescentam pouco desempenho. Em conjunto, as figuras mostram uma sensibilidade decrescente de $P_0$ para $P_1$ e $P_2$.

Os gráficos da @fig:nmsecomplexp0, da @fig:nmsecomplexp1 e da @fig:nmsecomplexp2 relacionam o NMSE à complexidade do modelo e destacam separadamente a influência das ordens polinomiais $P_0$, $P_1$ e $P_2$. Eles permitem visualizar como a alocação da complexidade entre os atrasos afeta o desempenho global.

#figure(
  image("Figuras/nmsecomplexp0.png", width: 75%),
  caption: [NMSE em função da complexidade, destacando a ordem $P_0$],
  source: [Autor],
) <fig:nmsecomplexp0>

#figure(
  image("Figuras/nmsecomplexp1.png", width: 75%),
  caption: [NMSE em função da complexidade, destacando a ordem $P_1$],
  source: [Autor],
) <fig:nmsecomplexp1>

#figure(
  image("Figuras/nmsecomplexp2.png", width: 75%),
  caption: [NMSE em função da complexidade, destacando a ordem $P_2$],
  source: [Autor],
) <fig:nmsecomplexp2>

Na @fig:nmsecomplexp0, os pontos coloridos por $P_0$ mostram que configurações com maior ordem no instante atual tendem a alcançar NMSE mais negativo, mesmo com número moderado de coeficientes. Na @fig:nmsecomplexp1, as cores se sobrepõem mais para uma mesma complexidade: elevar $P_1$ isoladamente não garante melhora, pois o resultado também depende da ordem atribuída ao instante atual. A @fig:nmsecomplexp2 apresenta sobreposição ainda mais forte entre as ordens de $P_2$, sem uma tendência sistemática de redução do NMSE conforme esse parâmetro cresce.

Portanto, a comparação entre a @fig:nmsecomplexp0, a @fig:nmsecomplexp1 e a @fig:nmsecomplexp2 indica que a complexidade adicional é mais bem aproveitada quando direcionada a $P_0$. O aumento de $P_1$ pode contribuir em conjunto com $P_0$, enquanto elevar $P_2$ tende a aumentar o número de coeficientes sem ganhos equivalentes de precisão. Essa leitura complementa a análise de sensibilidade e explica por que a quantidade de termos, por si só, não determina o desempenho.

Por fim, a @fig:modelosdecrecenteatraso apresenta os modelos que respeitam a relação $P_0 >= P_1 >= P_2$. Observa-se que grande parte dos modelos com melhor desempenho pertence a esse conjunto, reforçando a hipótese de que a complexidade do modelo deve ser prioritariamente alocada no instante atual, com redução progressiva da ordem polinomial para atrasos mais antigos.

#figure(
  image("Figuras/modelosdecrecenteatraso.png", width: 75%),
  caption: [Modelos com ordens polinomiais não crescentes ao longo dos atrasos],
  source: [Autor],
) <fig:modelosdecrecenteatraso>

Esses resultados demonstram que modelos com menor quantidade total de coeficientes podem apresentar desempenho superior quando a complexidade é adequadamente distribuída entre os atrasos. Tal comportamento evidencia que não apenas a quantidade de coeficientes, mas principalmente a forma como estes são organizados estruturalmente no modelo MP, é determinante para a acurácia obtida.

A análise da fronteira de Pareto, apresentada na @fig:fronteiradepareto, evidencia de forma clara o compromisso existente entre a complexidade estrutural do modelo e o desempenho obtido. Os modelos pertencentes à fronteira representam soluções eficientes, uma vez que não é possível melhorar o NMSE sem um aumento correspondente no número de coeficientes, ou reduzir a complexidade sem perda de desempenho.

Observa-se que os modelos localizados na fronteira de Pareto apresentam, em sua maioria, distribuições de ordem polinomial concentradas no instante atual, com redução progressiva das ordens associadas aos atrasos mais antigos. Tal comportamento reforça os resultados apresentados anteriormente, indicando que a não linearidade dominante do sistema está majoritariamente associada ao instante atual, enquanto os efeitos de memória contribuem de forma menos significativa e saturam com ordens polinomiais reduzidas.

#figure(
  image("Figuras/fronteiradepareto.png", width: 75%),
  caption: [Fronteira de Pareto para os modelos MP com ordem dependente do atraso],
  source: [Autor],
) <fig:fronteiradepareto>

== Generalização em múltiplos conjuntos de dados empíricos

Para avaliar a robustez da metodologia proposta, o mesmo procedimento de identificação e avaliação foi aplicado aos dois conjuntos de dados descritos na @sec:metodologia-validacao, correspondentes aos PAs GaN HEMT e LDMOS. Em ambos, foram testadas as 125 combinações possíveis de ordens $(P_0, P_1, P_2)$ com $M = 2$, mantendo o mesmo _pipeline_ de treinamento e validação.

#figure(
  kind: table,
  caption: [Comparação estatística do desempenho dos modelos MP nos conjuntos GaN e LDMOS.],
  source: [Autor],
  table(
    columns: (auto, auto, auto),
    align: center,
    table.header(
      [*Métrica*],
      [*Conjunto 1 — GaN*],
      [*Conjunto 2 — LDMOS*],
    ),
    [NMSE melhor modelo], [-26,11 dB], [-37,53 dB],
    [NMSE pior modelo], [-21,41 dB], [-28,71 dB],
    [NMSE médio], [-25,21 dB], [-35,20 dB],
    [Modelo P\=[1,1,1] (3 coef.)], [-21,66 dB], [-28,71 dB],
    [Modelo P\=[3,3,3] (9 coef.)], [-25,95 dB], [-35,25 dB],
    [Modelo P\=[5,5,5] (15 coef.)], [-26,10 dB], [-37,51 dB],
  ),
) <tab:generalizacao-estatisticas>

A @tab:generalizacao-estatisticas mostra que o conjunto LDMOS apresentou desempenho absoluto superior, com NMSE médio aproximadamente 10 dB mais negativo do que o conjunto GaN. Ainda assim, os padrões estruturais se mantiveram consistentes entre as duas tecnologias, indicando que a abordagem proposta é robusta frente a variações do dispositivo sob teste.

#figure(
  kind: table,
  caption: [Desempenho de configurações representativas de ordens polinomiais nos conjuntos GaN e LDMOS.],
  source: [Autor],
  table(
    columns: (auto, auto, auto, auto),
    align: center,
    table.header(
      [*Ordens $(P_0, P_1, P_2)$*],
      [*Nº coef.*],
      [*NMSE GaN (dB)*],
      [*NMSE LDMOS (dB)*],
    ),
    [\[3, 2, 1\]], [6], [-25,53], [-34,75],
    [\[3, 3, 2\]], [8], [-25,60], [-35,24],
    [\[4, 3, 2\]], [9], [-25,64], [-36,31],
    [\[5, 3, 2\]], [10], [-25,49], [-37,00],
    [\[5, 4, 3\]], [12], [-26,07], [-37,44],
    [\[5, 5, 5\]], [15], [-26,10], [-37,51],
  ),
) <tab:generalizacao-configuracoes>

Como detalhado na @tab:generalizacao-configuracoes, em ambos os conjuntos a ordem $P_0$ permaneceu como principal determinante de desempenho, e os modelos com distribuição não crescente $P_0 >= P_1 >= P_2$ concentraram as melhores soluções. Além disso, o ganho marginal obtido ao ultrapassar a faixa de 9 a 10 coeficientes mostrou-se reduzido nas duas tecnologias, indicando saturação de desempenho em baixas complexidades.

== Implementação em VHDL do modelo MP com ordem dependente do atraso

Após a avaliação em software, foi realizada a implementação em VHDL de duas versões do modelo: o MP original completo, com ordem uniforme em todos os atrasos, e o MP truncado, com redução da ordem polinomial nos atrasos mais antigos e reorganização estrutural para eliminar operações redundantes. O objetivo dessa etapa foi verificar se os ganhos de complexidade observados na modelagem também se manifestam em uma descrição orientada à síntese em hardware.

=== Validação funcional em Python

#figure(
  image("Figuras/fig_python_amam_ampm.png", width: 75%),
  caption: [Curvas AM-AM e AM-PM obtidas em Python, comparando os dados medidos com os modelos PA e DPD em vírgula fixa.],
  source: [Autor],
) <fig:fig_python_amam_ampm>

A @fig:fig_python_amam_ampm apresenta a comparação entre os dados medidos e os modelos implementados em Python. Observa-se que o modelo DPD é capaz de compensar a não linearidade do amplificador, aproximando a resposta do comportamento ideal e estabelecendo a referência para a validação funcional da implementação em VHDL.

=== Validação da implementação em VHDL

#figure(
  image("Figuras/fig_vhdl_vs_python.png", width: 75%),
  caption: [Curva AM-AM comparando o modelo em Python com o resultado da simulação da implementação em VHDL.],
  source: [Autor],
) <fig:fig_vhdl_vs_python>

A @fig:fig_vhdl_vs_python apresenta a comparação entre o modelo DPD calculado em Python e o resultado obtido a partir da simulação da implementação em VHDL. Observa-se que os pontos associados à descrição em hardware se sobrepõem aos resultados do modelo em software, indicando equivalência funcional entre as duas implementações no cenário avaliado.

A simulação final da implementação completa destinada à FPGA foi realizada no ModelSim, incluindo as informações temporais do circuito. Além de confirmar a propagação correta das amostras através dos estágios do _pipeline_, essa etapa permitiu analisar os atrasos entre entrada e saída e a taxa de processamento. As formas de onda mostraram que a latência inicial corresponde ao preenchimento dos estágios internos, enquanto, em regime permanente, o circuito produz uma saída válida por ciclo de relógio. Assim, a latência determina o tempo necessário para obter o primeiro resultado, mas não reduz a vazão após o preenchimento do _pipeline_.

=== Comparação de complexidade estrutural

#figure(
  kind: table,
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
) <tab:complexidade-vhdl>

Os resultados da @tab:complexidade-vhdl evidenciam uma redução consistente de aproximadamente 40% nas principais métricas estruturais da síntese lógica. A diminuição simultânea no número de `wires`, `wire bits`, células e registradores mostra que a estratégia proposta simplifica efetivamente a arquitetura implementada em hardware, e não apenas a quantidade nominal de coeficientes do modelo.

Essa análise confirma que a redução da ordem polinomial nos atrasos mais antigos, quando acompanhada de reorganização estrutural do circuito, produz ganhos reais de implementação. Dessa forma, os resultados em VHDL reforçam a viabilidade do modelo MP com ordem dependente do atraso para aplicações digitais com restrições de área e consumo.

== Avaliação do sistema DPD + PA com arquitetura ILA

Além da modelagem direta do amplificador, foi avaliada a aplicação do modelo MP em um sistema de pré-distorção digital baseado na arquitetura ILA. Nessa configuração, o DPD foi treinado como o inverso do PA a partir do conjunto LDMOS, e posteriormente aplicado em cascata com o modelo do amplificador, formando a estrutura completa DPD + PA.

No ajuste do ganho global de entrada, duas estratégias foram comparadas. Um ganho baseado na relação entre as amplitudes máximas de entrada e saída do PA resultou em valor aproximado de 0,83, produzindo um sinal estável porém com excursão dinâmica reduzida. Já o uso de ganho fixo igual a 0,95 proporcionou melhor aproveitamento da faixa dinâmica do modelo e melhor qualidade visual de linearização.

#figure(
  image("Figuras/AM-AM.png", width: 75%),
  caption: [Características AM-AM do sistema DPD + PA. A cascata final apresenta resposta mais próxima de uma relação linear em comparação ao PA isolado.],
  source: [Autor],
) <fig:am-am-dpd-pa>

#figure(
  image("Figuras/AM-PM.png", width: 75%),
  caption: [Características AM-PM do sistema DPD + PA. Observa-se redução da distorção de fase dependente da amplitude após a aplicação do DPD.],
  source: [Autor],
) <fig:am-pm-dpd-pa>

Na @fig:am-am-dpd-pa, observa-se que o modelo do PA reproduz a compressão de ganho do amplificador, enquanto o DPD compensa essa não linearidade e torna a resposta da cascata mais próxima de uma relação linear. A @fig:am-pm-dpd-pa mostra a resposta de fase: após a aplicação do DPD, a dispersão da fase em função da amplitude diminui, indicando compensação das distorções AM-PM.

Esses resultados mostram que o modelo MP é adequado não apenas para a modelagem direta do PA, mas também para a identificação de um pré-distorcedor funcional por ILA. Além disso, reforçam que o ajuste de ganho é um elemento crítico para evitar extrapolação do modelo e preservar a estabilidade numérica do sistema DPD + PA.

// ═════════════════════════════════════════════════════════════════════════════
= Conclusão
// ═════════════════════════════════════════════════════════════════════════════

A crescente demanda por eficiência espectral e energética nos sistemas de comunicação sem fio torna essencial o uso de técnicas capazes de mitigar os efeitos das não linearidades introduzidas por amplificadores de potência, sendo a modelagem comportamental desses dispositivos uma etapa fundamental nesse contexto.

Este trabalho teve como objetivo estudar e validar a modelagem de um amplificador de potência por meio do modelo de Polinômio de Memória (MP), estabelecendo uma base consistente para aplicações futuras em técnicas de pré-distorção digital. Inicialmente, foi realizado um estudo teórico sobre os princípios do DPD e sobre a formulação matemática do modelo MP, evidenciando suas vantagens em termos de complexidade e capacidade de representação das não linearidades com efeitos de memória.

Em seguida, a modelagem do amplificador foi desenvolvida em ambiente de software utilizando aritmética em vírgula flutuante, com extração dos coeficientes por meio de métodos de otimização numérica e validação baseada na métrica do Erro Quadrático Médio Normalizado (NMSE), cujos resultados demonstraram a eficácia do modelo MP clássico na caracterização do comportamento do PA e estabeleceram uma referência de desempenho para análises posteriores.

A partir dessa base, foi proposta uma extensão do modelo MP na qual a ordem polinomial máxima passa a ser definida de forma independente para cada atraso de memória, introduzindo maior flexibilidade na modelagem e abrindo a possibilidade de reduzir a complexidade do modelo sem comprometer significativamente sua capacidade de representação. A análise de desempenho dos modelos treinados em software mostrou que a complexidade deve ser concentrada prioritariamente no instante atual, enquanto atrasos mais antigos podem ser representados com ordens menores, preservando boa acurácia.

As evidências empíricas adicionais baseadas na análise da magnitude dos coeficientes, na sensibilidade do NMSE e no espectro do erro residual confirmaram de forma consistente essa hipótese. Em particular, verificou-se que a energia dos coeficientes decai com o atraso, que o ganho de desempenho associado a $P_0$ é significativamente superior aos ganhos obtidos com $P_1$ e $P_2$, e que a redução do erro espectral é mais pronunciada quando a complexidade é alocada no instante atual.

As avaliações conduzidas em dois conjuntos de dados empíricos distintos, correspondentes a amplificadores GaN HEMT e LDMOS, mostraram que esses padrões estruturais se mantêm consistentes entre tecnologias diferentes. Embora os níveis absolutos de NMSE variem entre os dispositivos, a predominância de $P_0$, a eficiência dos modelos com ordens não crescentes e a saturação de desempenho em baixas complexidades foram preservadas, reforçando a capacidade de generalização da metodologia proposta.

Adicionalmente, a implementação em VHDL das versões original e truncada do modelo confirmou a equivalência funcional entre o comportamento previsto em Python e a descrição em hardware em vírgula fixa. A simulação temporal da implementação completa no ModelSim permitiu verificar os atrasos do circuito, a latência do _pipeline_ e a taxa de processamento em regime permanente. Os resultados de síntese mostraram reduções próximas de 40% em métricas estruturais como número de `wires`, células e registradores, evidenciando que a simplificação do modelo produz ganhos concretos de implementação.

Por fim, a aplicação do modelo MP em um sistema de pré-distorção digital baseado na arquitetura ILA demonstrou que a mesma estrutura é capaz de atuar tanto na modelagem do amplificador quanto na identificação de um pré-distorcedor funcional. As curvas AM-AM e AM-PM da cascata DPD + PA evidenciaram melhora clara de linearização, além de destacar a importância do ajuste de ganho para preservar estabilidade numérica e bom aproveitamento da faixa dinâmica.

Dessa forma, o trabalho alcançou seu objetivo ao validar a modelagem comportamental do PA em software, propor uma estrutura mais flexível e demonstrar sua viabilidade em VHDL. Como trabalhos futuros, recomenda-se aplicar a mesma metodologia a outros modelos comportamentais, como o polinômio generalizado com memória (GMP) e a série completa de Volterra, comparando precisão, complexidade e recursos de hardware. Também se recomenda ampliar a validação em plataformas FPGA e investigar o impacto de diferentes precisões numéricas e arquiteturas de _pipeline_.

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

#appendix(
  include "assets/apendice_codigo_fonte.typ",
  [Código-fonte do trabalho]
)
