#import "../src/lib.typ": *

#set math.equation(numbering: "(1)")

#show: template.with(
  title: [
    Modelagem Comportamental de Amplificadores de Potência Usando Polinômios com Memória e Ordens Dependentes do Atraso
  ],
  title-foreign: [
    Behavioral Modeling of Power Amplifiers Using Memory Polynomials with Delay-Dependent Orders
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
    [MP],    [Memory Polynomial (Polinômio com Memória)],
    [GaN],   [Nitreto de Gálio],
    [LDMOS], [Laterally Diffused Metal-Oxide-Semiconductor],
    [RTL],   [Register-Transfer Level (Nível de Transferência entre Registradores)],
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
    [HEMT],  [High Electron Mobility Transistor (Transistor de Alta Mobilidade Eletrônica)],
    [VSA],   [Vector Signal Analyzer (Analisador de Sinal Vetorial)],
    [NMSE],  [Normalized Mean Squared Error (Erro Médio Quadrado Normalizado)],
  ),
)

// ─────────────────────────────────────────────────────────────────────────────
// RESUMO
// ─────────────────────────────────────────────────────────────────────────────

#abstract[
A evolução dos sistemas de comunicação sem fio possibilitou o surgimento de diversas aplicações móveis e sem fio, como desenvolvimento web e Internet das Coisas (IoT). Nesse contexto, a melhoria da eficiência energética é altamente desejável, tanto em dispositivos móveis, que buscam maior autonomia de bateria, quanto em estações rádio-base, que visam reduzir perdas associadas à dissipação de calor. Entretanto, o aumento da eficiência energética geralmente implica a redução da linearidade dos amplificadores de potência (PAs) utilizados nos transmissores de rádio. Essa limitação é particularmente crítica em sistemas modernos de comunicação, nos quais a largura de banda disponível é restrita e o uso de modulações complexas, que exploram variações simultâneas de amplitude e fase, é essencial para alcançar elevadas taxas de transmissão. Modulações sensíveis à amplitude tornam-se especialmente suscetíveis às não linearidades do PA, resultando em degradação do desempenho e aumento dos erros de transmissão. Uma solução amplamente empregada para conciliar eficiência energética e linearidade é a utilização da pré-distorção digital (Digital Predistortion --- DPD) em cascata com o PA. A eficácia dessa técnica depende diretamente da disponibilidade de modelos matemáticos capazes de representar com precisão o comportamento não linear e com memória do amplificador. Nesta dissertação, inicialmente investiga-se uma variação do modelo de polinômio com memória (_Memory Polynomial_ --- MP), na qual a ordem polinomial passa a depender do atraso de memória, permitindo maior flexibilidade na modelagem e redução da complexidade computacional com avaliação do compromisso entre precisão e complexidade. Além da avaliação em software, investiga-se a implementação desse modelo na linguagem VHDL (_VHSIC Hardware Description Language_, sendo VHSIC a sigla de _Very High-Speed Integrated Circuit_), com validação funcional em vírgula fixa e análise da complexidade estrutural obtida na síntese lógica. Os resultados indicam erro quadrático médio normalizado (_Normalized Mean Squared Error_ --- NMSE) de $-26,7$~dB para o MP clássico no conjunto de nitreto de gálio (GaN) com transistor de alta mobilidade eletrônica (_High Electron Mobility Transistor_ --- HEMT), $-37,51$~dB para o MP completo no conjunto LDMOS (_Laterally Diffused Metal-Oxide-Semiconductor_) e reduções próximas de 40% em métricas estruturais da implementação em VHDL do modelo MP com truncamento polinomial dependente do atraso, incluindo fios (_wires_), células e registradores.
]

// ─────────────────────────────────────────────────────────────────────────────
// ABSTRACT
// ─────────────────────────────────────────────────────────────────────────────

#abstract-foreign[
The evolution of wireless communication systems has enabled the emergence of various mobile and wireless applications, such as web development and the Internet of Things (IoT). In this context, improving energy efficiency is highly desirable, both for mobile devices seeking greater battery life and for radio base stations aiming to reduce losses associated with heat dissipation. However, increasing energy efficiency generally implies reducing the linearity of power amplifiers (PAs) used in radio transmitters. This limitation is particularly critical in modern communication systems, where the available bandwidth is restricted and the use of complex modulations, exploiting simultaneous amplitude and phase variations, is essential to achieve high transmission rates. Amplitude-sensitive modulations are especially susceptible to PA nonlinearities, resulting in performance degradation and increased transmission errors. A widely used solution to reconcile energy efficiency and linearity is the use of digital predistortion (DPD) in cascade with the PA. The effectiveness of this technique depends directly on the availability of mathematical models capable of accurately representing the nonlinear and memory behavior of the amplifier. In this dissertation, a variation of the Memory Polynomial (MP) model is initially investigated, in which the polynomial order depends on the memory delay, allowing greater modeling flexibility and reduced computational complexity while assessing the trade-off between accuracy and complexity. In addition to the software-based evaluation, the implementation of this model in VHDL (VHSIC Hardware Description Language, where VHSIC stands for Very High-Speed Integrated Circuit) is investigated, with fixed-point functional validation and analysis of the structural complexity obtained from logic synthesis. The results indicate a normalized mean squared error (NMSE) of $-26.7$~dB for the classical MP on the gallium nitride (GaN) high electron mobility transistor (HEMT) dataset, $-37.51$~dB for the full MP on the laterally diffused metal-oxide-semiconductor (LDMOS) dataset, and reductions close to 40% in structural metrics of the VHDL implementation of the MP model with delay-dependent polynomial truncation, including wires, cells, and registers.
]

// ═════════════════════════════════════════════════════════════════════════════
= Introdução
// ═════════════════════════════════════════════════════════════════════════════

A evolução dos sistemas de comunicação móveis, impulsionada pela crescente demanda por comunicações mais rápidas e eficientes, tem levado à implementação de uma variedade de serviços, incluindo aplicações multimídia, desenvolvimento web e aplicações IoT @Yu2024. No entanto, essa evolução também trouxe desafios significativos, como a necessidade de melhorar a eficiência energética, tanto para dispositivos móveis, visando aumentar a autonomia da bateria, quanto para estações de rádio base, visando reduzir a parcela da energia elétrica dissipada na forma de calor. Para atender a essas demandas, estratégias de modulação que alteram tanto a fase quanto a amplitude de ondas portadoras em radiofrequência se tornaram essenciais @Kenington2000. Além disso, a modulação na amplitude requer linearidade na transmissão para evitar erros e interferências na comunicação entre usuários vizinhos @Cripps2006.

Essa complexa tarefa recai sobre o projetista do amplificador de potência de radiofrequência (PA), que enfrenta o desafio de desenvolver um hardware eficiente em termos energéticos e linear ao mesmo tempo, uma vez que esses dois objetivos podem entrar em conflito @Cripps2006. Uma solução para contornar esse desafio é a implementação de um pré-distorcedor digital (DPD) em banda base, que visa compensar a distorção causada pelo PA @Cripps2006. O DPD é conectado em cascata ao PA e requer um modelo de alta precisão e baixa complexidade computacional para representar as características de transferência direta e inversa do amplificador.

O modelo de polinômio com memória (MP) tradicional utiliza uma mesma ordem polinomial máxima em todos os atrasos. Embora essa uniformidade simplifique a formulação, ela pode manter termos de alta ordem associados a amostras antigas, cuja contribuição tende a ser menor, aumentando desnecessariamente o número de coeficientes e operações. Essa limitação motiva a investigação apresentada a seguir. Nesta dissertação, investigam-se ordens polinomiais dependentes do atraso e avalia-se o compromisso entre precisão e complexidade, bem como a viabilidade de implementação em hardware.

== Delimitação do Tema

A pesquisa concentra-se na modelagem comportamental em banda-base de amplificadores de potência e na avaliação de estruturas MP com truncamento dependente do atraso. São reutilizados dois conjuntos de medições de entrada e saída, identificados como GaN HEMT e LDMOS, com partições de extração e validação. As características documentadas desses conjuntos são apresentadas na @sec:metodologia-validacao; os resultados de modelagem e da cascata DPD + PA são obtidos computacionalmente a partir desses dados, sem novas medições de linearização em bancada.

A identificação é realizada em Python. A implementação digital utiliza VHDL (_VHSIC Hardware Description Language_, sendo VHSIC a sigla de _Very High-Speed Integrated Circuit_), aritmética de vírgula fixa, paralelismo e registradores de _pipeline_. A verificação em nível de transferência entre registradores (_Register-Transfer Level_ --- RTL) emprega GHDL, a síntese genérica utiliza GHDL/Yosys e a implementação em matriz de portas programáveis em campo (_Field-Programmable Gate Array_ --- FPGA) considera a Xilinx Artix-7 XC7A100T-CSG324-2 com ISE 14.7. Os registros de simulação temporal pós-roteamento foram produzidos em Questa. Essas etapas não constituem medições em placa nem análises de potência elétrica.

As análises empregam duas convenções de funções de base, em execuções distintas: a formulação com potências consecutivas do módulo e a formulação restrita às ordens ímpares. A segunda permite gerar os termos por multiplicações sucessivas pelo módulo quadrático, simplificando sua implementação em vírgula fixa. A contagem de funções de base e a ordem polinomial máxima são distinguidas na @sec:arquitetura-hardware-proposta. A comparação entre resultados considera também as diferenças entre os procedimentos de identificação, as representações numéricas e as versões dos circuitos documentados.

== Objetivo Geral

Investigar e validar, em software e hardware, estruturas alternativas do modelo _Memory Polynomial_ (MP) para a modelagem matemática de PAs, com ênfase em ordens polinomiais dependentes do atraso e no compromisso entre precisão do modelo e complexidade de implementação. A validação em hardware compreende a descrição das arquiteturas em VHDL, a comparação funcional com o modelo de referência em Python e a análise da complexidade estrutural após a síntese lógica.

== Objetivos Específicos

Para alcançar o objetivo geral, este trabalho foi desenvolvido com base nos seguintes objetivos específicos:

+ Implementar, utilizando a linguagem Python, o modelo _Memory Polynomial_ (MP) tradicional para a modelagem comportamental de amplificadores de potência;

+ Desenvolver e implementar uma variação do modelo MP com ordens polinomiais dependentes do atraso, permitindo truncamentos polinomiais distintos para cada ramo de memória;

+ Avaliar o desempenho dos modelos propostos por meio de métricas de erro, com ênfase no _Normalized Mean Squared Error_ (NMSE);

+ Analisar a relação entre a complexidade estrutural dos modelos, expressa pelo número de coeficientes, e a precisão obtida, por meio de uma abordagem de otimização multiobjetivo baseada na fronteira de Pareto;

+ Identificar configurações de modelos MP que apresentem melhor compromisso entre desempenho e complexidade, visando futuras implementações eficientes;

+ Implementar em VHDL, com aritmética de vírgula fixa, as arquiteturas do modelo MP clássico e do modelo com ordem dependente do atraso;

+ Validar funcionalmente a arquitetura VHDL em nível RTL com GHDL, compará-la com a referência em Python e avaliar sua complexidade estrutural por síntese lógica com GHDL/Yosys;

+ Validar os modelos padrão e reduzido por simulação temporal pós-roteamento em Questa, com anotação SDF dos atrasos da tecnologia, distinguindo essa etapa da simulação RTL;

+ Implementar as arquiteturas em FPGA com Xilinx ISE e analisar a ocupação de recursos e o atendimento à restrição de período de 10~ns, correspondente à frequência-alvo de 100~MHz.

// ═════════════════════════════════════════════════════════════════════════════
= Revisão de Literatura
// ═════════════════════════════════════════════════════════════════════════════

A evolução dos sistemas de comunicações sem fio tem impulsionado o desenvolvimento de diversas aplicações móveis. Nesse contexto, a eficiência energética emerge como uma característica essencial, beneficiando tanto a autonomia de baterias em dispositivos móveis quanto a redução de perdas em estações rádio-base, nas quais parte significativa da energia consumida é dissipada na forma de calor.

== Sistema Transmissor

Um sistema de comunicação pode ser dividido em três subsistemas principais: transmissor, receptor e meio de propagação @HaykinMoher2011. Este trabalho concentra-se exclusivamente no subsistema transmissor, ilustrado na @fig:sistemadetrasmissao, que inclui os componentes responsáveis pela geração, conversão, filtragem e amplificação do sinal antes da irradiação pela antena. Dentre esses blocos, o amplificador de potência (PA) destaca-se como um dos elementos de maior consumo energético, pois utiliza a energia elétrica fornecida pela fonte de corrente contínua (CC) para entregar potência de radiofrequência (RF) à carga, neste caso a antena. Assim, a eficiência global do transmissor depende diretamente do desempenho do PA.

#figure(
  image("Figuras/sistematrasmissorpng.png", width: 55%),
  caption: [Sistema de transmissão simplificado],
  source: [#cite(<Schuartz2017>, form: "prose")],
) <fig:sistemadetrasmissao>

== Amplificadores de Potência em RF

O componente central do PA é o transistor, responsável pela amplificação da potência do sinal de entrada proveniente de estágios anteriores da cadeia de transmissão. Nesse processo, parte da potência elétrica fornecida pela fonte CC é convertida em potência de RF entregue à carga. Para maximizar a potência entregue à carga, o PA deve apresentar alta eficiência, definida como a relação entre a potência de saída $P_("out")$ e a potência consumida da fonte CC $P_("cc")$:

$ eta = (P_("out") / P_("cc")) times 100% $ <eq:rendimento>

Devido a imperfeições nos componentes e às condições reais de operação, a eficiência ideal de 100% nunca é alcançada. Além do transistor, o circuito do PA inclui redes de casamento de impedância de entrada e saída, responsáveis por otimizar a transferência de potência, e um circuito de polarização CC, que estabelece as condições adequadas de operação do dispositivo ativo. Esses elementos, compostos por componentes como capacitores e indutores, também introduzem efeitos dinâmicos no amplificador, usualmente chamados de efeitos de memória. A @fig:circuitoparf apresenta um circuito simplificado de PA.

#figure(
  image("Figuras/circuito_pa.svg", width: 85%),
  caption: [Circuito simplificado de um PA],
  source: [#cite(<Luiza2016>, form: "prose")],
) <fig:circuitoparf>

Tipicamente, a eficiência do PA aumenta com a potência de saída, atingindo valores mais elevados quando o dispositivo opera próximo à saturação. A potência que não é convertida em sinal útil é dissipada como calor, elevando custos de projeto, reduzindo a confiabilidade e exigindo estruturas de dissipação térmica. Assim, maximizar a eficiência do PA é um objetivo central no projeto de redes de telecomunicações.

Outra característica fundamental é a linearidade, normalmente avaliada pela curva de transferência, que relaciona a potência de saída à potência de entrada, em dBm, como exemplificado na @fig:saidaparf. Nessa curva, observa-se uma região aproximadamente linear para baixas potências de entrada, seguida de uma região de compressão de ganho. O ponto de compressão de 1 dB indica a potência para a qual o ganho do amplificador se reduz em 1 dB em relação ao regime de pequeno sinal. Próximo à saturação, o ganho diminui progressivamente, aumentando a distorção do sinal transmitido.

#figure(
  image("Figuras/curva_transferencia_pa.svg", width: 85%),
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
  image("Figuras/distorcao_espectral_pa.svg", width: 100%),
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
  image("Figuras/modelagem_comportamental.svg", width: 95%),
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

#par(first-line-indent: 0pt)[em que $x(t)$ e $y(t)$ são, respectivamente, os sinais de entrada e saída, $t$ é o tempo contínuo, $h_0$ é o termo constante e $h_n (tau_1, dots.c, tau_n)$ representa o núcleo de Volterra de ordem $n$. O índice $n$ enumera as ordens da série, $i$ enumera os fatores do produto e $tau_i$ é a variável de atraso da integração correspondente. Os núcleos descrevem os efeitos não lineares e de memória do sistema. Embora a série de Volterra forneça uma descrição bastante geral e precisa do comportamento de sistemas não lineares com memória, sua aplicação prática é limitada pela elevada complexidade computacional. Por esse motivo, na maioria das aplicações, a série é truncada para ordens finitas, restringindo o número de termos considerados.]

=== Polinômio com Memória <sec:polinomio-memoria>

O modelo de polinômio com memória (_Memory Polynomial_ --- MP) surge como uma simplificação da série de Volterra, obtida pela consideração apenas dos termos diagonais, isto é, daqueles que compartilham o mesmo atraso temporal @Kim2001. Essa simplificação reduz significativamente a complexidade do modelo, ao mesmo tempo em que preserva a capacidade de representar não linearidades e efeitos de memória de forma satisfatória para uma ampla classe de amplificadores de potência.

O modelo MP pode ser descrito matematicamente por:

$ y(n) = sum_(p=1)^(P) sum_(m=0)^(M) h_(p,m) , x(n - m) |x(n - m)|^(p-1) $ <eq:mp>

#par(first-line-indent: 0pt)[em que $x(n)$ e $y(n)$ são as envoltórias complexas de entrada e saída no instante discreto $n$, $p$ enumera os termos de 1 a $P$, $m$ enumera os atrasos de 0 a $M$, e $h_(p,m)$ são os coeficientes complexos. Nesta formulação, $P$ é a ordem máxima e também a quantidade de funções de base por ramo; $M$ é o maior atraso em amostras, de modo que existem $M+1$ ramos. O símbolo $|x|$ indica o módulo da amostra complexa. Uma das principais vantagens do modelo de polinômio com memória é sua linearidade nos parâmetros, o que facilita a estimativa dos coeficientes por meio de técnicas de otimização convencionais. Além disso, esse modelo apresenta boa eficácia na representação de amplificadores de potência com efeitos de memória moderados, sendo amplamente empregado em aplicações de pré-distorção digital.]

Para explicitar a organização do modelo MP geral da @eq:mp, considera-se ordem polinomial $P = 5$ e profundidade de memória $M = 2$, resultando em 15 coeficientes complexos. Nessa configuração, a @eq:mp pode ser organizada em três blocos de memória:

$ y(n) =
  bold(h)_0^T bold(phi)_0(n) + bold(h)_1^T bold(phi)_1(n - 1) + bold(h)_2^T bold(phi)_2(n - 2) $ <eq:mp-original-p5-m2>

#par(first-line-indent: 0pt)[em que cada bloco contém cinco coeficientes e cinco termos polinomiais:]

$ bold(h)_m^T = mat(h_(1,m), h_(2,m), h_(3,m), h_(4,m), h_(5,m)) $ <eq:coeficientes-bloco-mp>

$ bold(phi)_m(n - m) = mat(
  x(n - m);
  x(n - m)|x(n - m)|;
  x(n - m)|x(n - m)|^2;
  x(n - m)|x(n - m)|^3;
  x(n - m)|x(n - m)|^4
) $ <eq:termos-bloco-mp>

#par(first-line-indent: 0pt)[Assim, para $m in {0, 1, 2}$, a estrutura total é composta por três vetores de coeficientes, cada um com cinco elementos, totalizando 15 coeficientes. O símbolo $T$ indica transposição, sem conjugação. Essa expansão emprega potências consecutivas do módulo; na versão de ordens ímpares, detalhada na @sec:arquitetura-hardware-proposta, cinco funções de base correspondem às ordens 1, 3, 5, 7 e 9. A igualdade no número de coeficientes não torna as duas bases equivalentes.]

Observa-se que, na formulação tradicional do modelo MP, a ordem polinomial máxima $P$ é adotada de forma uniforme para todos os termos de memória, independentemente do atraso considerado. Essa restrição, embora simplifique a estrutura do modelo, pode resultar em um aumento desnecessário da complexidade computacional, especialmente para termos associados a atrasos mais elevados, cujos efeitos não lineares tendem a ser menos pronunciados. Dessa forma, a adoção de ordens polinomiais diferenciadas em função do atraso de memória surge como uma alternativa potencial para reduzir a complexidade do modelo, mantendo sua capacidade de representação.

Do ponto de vista de implementação em hardware, especialmente em sistemas que operam com altas taxas de amostragem, torna-se fundamental explorar arquiteturas eficientes que permitam a paralelização das operações aritméticas. Nesse contexto, a implementação em VHDL do modelo MP com truncamento polinomial dependente do atraso permite avaliar de forma direta se a redução de complexidade observada em software se traduz em menor utilização de recursos em hardware digital, preservando a equivalência funcional do modelo. Trabalhos voltados à análise de compromissos de hardware em séries de Volterra podadas @Talemwa2025 reforçam a importância de tratar desempenho de modelagem e custo estrutural de forma conjunta.

== Descrição de Hardware em VHDL e Arquiteturas Digitais para DPD

A implementação prática de modelos comportamentais para pré-distorção digital depende não apenas da formulação matemática adotada, mas também da forma como essa formulação é traduzida para uma arquitetura de hardware. Em sistemas de transmissão de alta taxa, o processamento deve acompanhar o fluxo contínuo de amostras em banda-base, o que torna a organização temporal das operações tão importante quanto o número total de coeficientes do modelo.

Neste texto, vazão (_throughput_) designa a quantidade de amostras complexas processadas por unidade de tempo. Para um intervalo de iniciação de $I$ ciclos e frequência de relógio $f_"clk"$, a vazão é $1/I$ amostras por ciclo ou $f_"clk"/I$ amostras por segundo. Uma taxa de $B f_"clk"/I$ bits por segundo descreve o fluxo de uma interface que transporta $B$ bits por amostra complexa, sem incluir sobrecargas; ela não corresponde diretamente à taxa de informação do sinal modulado. A latência indica o tempo entre a entrada de uma amostra e sua saída e deve ser informada separadamente.

Nesse contexto, linguagens de descrição de hardware, como VHDL, são utilizadas para especificar circuitos digitais em diferentes níveis de abstração. Diferentemente de linguagens de programação sequenciais, o VHDL descreve comportamento concorrente, sinais, registradores, processos sincronizados por relógio e estruturas combinacionais que podem ser sintetizadas em hardware físico @Ashenden2008. A padronização da linguagem pelo IEEE também favorece portabilidade, simulação e síntese em diferentes ferramentas, desde que o código seja escrito de acordo com subconjuntos sintetizáveis da linguagem @IEEE10762008.

Para aplicações de DPD, o uso de VHDL permite representar explicitamente elementos essenciais da arquitetura digital, como linhas de atraso, multiplicadores, somadores, registradores de _pipeline_, tratamento de sinais complexos e aritmética de vírgula fixa. Essa proximidade com a estrutura do circuito é relevante porque modelos matematicamente equivalentes podem produzir custos de hardware distintos, dependendo da ordem das operações, do compartilhamento de recursos e da quantidade de registradores necessária para cumprir requisitos de temporização.

=== Representação em Vírgula Fixa

Embora a identificação inicial dos coeficientes seja frequentemente realizada em vírgula flutuante, implementações em FPGA e ASIC tendem a empregar aritmética de vírgula fixa para reduzir área, consumo e latência. A conversão do modelo para vírgula fixa exige definir largura de palavra, número de bits fracionários, estratégia de arredondamento e tratamento de saturação ou truncamento. Essas escolhas afetam diretamente a precisão numérica e a estabilidade da implementação, especialmente em modelos polinomiais, nos quais potências da amplitude podem ampliar erros de quantização.

Em arquiteturas para MP, cada termo $x(n-m)|x(n-m)|^(p-1)$ combina uma amostra complexa atrasada com potências de sua magnitude. Assim, a largura dos sinais internos tende a crescer ao longo das multiplicações. Uma arquitetura sintetizável precisa controlar esse crescimento por meio de redimensionamentos intermediários, preservando precisão suficiente para que a saída em hardware permaneça equivalente à referência em software. Por esse motivo, a validação funcional entre Python e VHDL constitui uma etapa indispensável antes da análise de recursos de síntese.

=== Estratégias Arquiteturais para Modelos Polinomiais

As arquiteturas digitais para modelos de DPD podem ser organizadas de diferentes formas. Uma primeira abordagem consiste na implementação direta da soma de produtos, na qual cada termo do modelo possui seu próprio caminho aritmético e os resultados parciais são acumulados ao final. Essa alternativa favorece paralelismo e alta vazão, pois vários termos podem ser calculados simultaneamente, mas tende a aumentar o número de multiplicadores e somadores necessários @Rahmanian2020.

Outra possibilidade é o compartilhamento temporal de recursos, no qual uma quantidade menor de operadores aritméticos é reutilizada em ciclos sucessivos. Essa estratégia reduz área, porém aumenta latência e pode limitar a taxa máxima de processamento. Em aplicações de comunicação sem fio, essa escolha depende da taxa de amostragem, da frequência máxima do circuito e da disponibilidade de recursos digitais no dispositivo alvo @Guan2010.

Também são comuns arquiteturas baseadas em tabelas de busca (_look-up tables_ --- LUTs), nas quais parte da relação não linear é armazenada em memória e acessada conforme a amplitude do sinal @Gilabert2008. Embora essa abordagem possa substituir operações aritméticas custosas por acessos à memória, seu desempenho depende do número de entradas, da resolução de quantização e do método empregado para endereçar as tabelas e interpolar os valores armazenados @Gilabert2008 @Rahmanian2020 @Molina2017.

=== Arquiteturas Baseadas em LUT e Compartilhamento de Recursos

Gilabert et al. @Gilabert2008 apresentam uma implementação adaptativa em FPGA baseada em múltiplas LUTs e em um modelo não linear autorregressivo de média móvel (NARMA). A estrutura organiza a compensação dos efeitos de memória em células básicas de pré-distorção e explora a realimentação do modelo para limitar a quantidade de tabelas necessária. A arquitetura também separa a execução contínua do pré-distorcedor do processo de atualização dos coeficientes, permitindo que a adaptação seja realizada em uma taxa inferior à taxa de amostragem do sinal @Gilabert2008. Essa solução reduz o custo da representação não linear, mas a natureza recursiva introduz dependências temporais que precisam ser consideradas no controle e na análise de estabilidade.

Guan e Zhu @Guan2010 propõem uma arquitetura de baixo custo derivada da série de Volterra que combina indexação de ganho assistida por LUT e multiplexação por divisão de tempo. A LUT é empregada para evitar o cálculo direto de parte das funções não lineares, enquanto os multiplicadores são compartilhados entre diferentes termos do modelo ao longo de ciclos sucessivos @Guan2010. A redução do número de operadores diminui a ocupação do FPGA, porém exige frequência de relógio interna suficiente para executar todas as operações associadas a uma amostra antes da chegada da amostra seguinte.

Para o MP, Kwan et al. @Kwan2012 adotam múltiplas LUTs e aritmética de vírgula fixa em uma implementação destinada a sinais LTE com largura de banda de 60 MHz. Os coeficientes são identificados por meio de mínimos quadrados recursivos baseados em decomposição QR, enquanto a arquitetura em FPGA realiza a aplicação do pré-distorcedor. Os autores reportam redução de latência em relação à implementação em vírgula flutuante e melhoria de até 20 dB no nível de emissão do canal adjacente @Kwan2012. Nesse caso, a economia em operadores aritméticos é acompanhada por maior demanda de memória e pela necessidade de definir cuidadosamente a resolução das tabelas.

Li et al. @Li2021HLS generalizam essa estratégia por meio de uma arquitetura escalável formada por células básicas de pré-distorção e descrita com síntese de alto nível. A proposta pode representar diferentes modelos com memória cujas funções de base sejam decompostas nessas células, permitindo variar o tamanho das LUTs e observar seus efeitos sobre utilização de recursos, vazão e consumo de potência @Li2021HLS. Em comparação com uma descrição RTL específica, a síntese de alto nível facilita a exploração arquitetural, embora a qualidade do circuito dependa das diretivas de síntese e da capacidade da ferramenta de inferir paralelismo e memória.

Em arquiteturas bidimensionais para transmissão em duas bandas, Zhang et al. @Zhang2024HTDM combinam um modelo MP segmentado com multiplexação temporal híbrida. A seleção vetorial divide o espaço de amplitudes em regiões, cada uma associada a um submodelo de menor ordem, enquanto LUTs de modulação cruzada e multiplicadores complexos são compartilhados entre os ramos. Os resultados apresentados pelos autores indicam economia aproximada de 30% de memória RAM e 80% de recursos DSP, acompanhada de melhorias de 18,74 dB em ACPR e 13,23 dB em NMSE @Zhang2024HTDM. Apesar de tratar um cenário de duas bandas, o trabalho demonstra como segmentação do modelo e compartilhamento temporal podem ser combinados para reduzir recursos.

=== Arquiteturas Paralelas e Otimização Numérica

Uma alternativa ao compartilhamento temporal consiste em manter os ramos polinomiais em paralelo e inserir registradores entre os estágios aritméticos. Rahmanian et al. @Rahmanian2020 desenvolvem uma arquitetura paralela de MP em vírgula fixa e avaliam o impacto dos comprimentos de palavra sobre o erro de modulação e a potência no canal adjacente. Além da quantização, os autores reorganizam caminhos aritméticos e acrescentam estágios de _pipeline_ para reduzir o caminho crítico e elevar a frequência máxima de operação @Rahmanian2020. Essa abordagem privilegia vazão e previsibilidade temporal, ao custo de maior quantidade de multiplicadores, somadores e registradores.

Li, Montoro e Gilabert @Li2024GPUFPGA implementam um DPD baseado em GMP tanto em FPGA quanto em GPU e comparam precisão, utilização de recursos, vazão e desempenho de linearização. O estudo mostra que ambas as plataformas podem atender ao processamento de sinais 5G NR de banda larga, mas evidencia compromissos distintos: a FPGA permite uma arquitetura especializada e determinística, enquanto a GPU oferece maior flexibilidade de programação @Li2024GPUFPGA. Para esta dissertação, a implementação em FPGA constitui a referência mais próxima, pois permite relacionar diretamente a estrutura do modelo com operadores, registradores e memória física.

Para modelos derivados da série de Volterra, a complexidade estrutural cresce rapidamente com a ordem não linear e com a profundidade de memória. Morgan et al. @Morgan2006 mostram que o GMP amplia a capacidade de modelagem ao incluir termos cruzados entre diferentes atrasos, mas essa maior generalidade também implica aumento do número de operações @Morgan2006. Talemwa et al. @Talemwa2025 analisam uma série de Volterra podada e exploram diferentes graus de paralelismo em unidades de multiplicação e acumulação, tratando conjuntamente desempenho de linearização e consumo do circuito @Talemwa2025. Esses resultados reforçam que a redução do número de funções de base somente se converte em benefício prático quando a arquitetura também elimina ou compartilha os operadores correspondentes.

=== Síntese Comparativa das Abordagens

As abordagens anteriores atuam sobre a representação das não linearidades, o escalonamento das operações ou a seleção das funções de base. Sua combinação deve ser avaliada segundo os requisitos de área, memória, latência e vazão, pois a economia de operadores pode exigir mais memória ou mais ciclos por amostra.

Uma comparação quantitativa direta entre os resultados publicados requer cautela, pois os trabalhos utilizam dispositivos FPGA, larguras de palavra, taxas de amostragem, sinais de teste, amplificadores e ordens de modelo diferentes. Assim, valores absolutos de LUTs lógicas, blocos DSP ou frequência máxima não devem ser interpretados isoladamente. Na comparação realizada nesta dissertação, são considerados o número de termos, a latência em ciclos e a variação percentual dos recursos em relação à configuração uniforme. A @tab:literatura-arquiteturas reúne informações verificadas de três abordagens representativas. As contagens físicas referem-se exclusivamente às condições de cada publicação; os campos sem contagens verificadas não foram preenchidos por estimativa.

#figure(
  kind: table,
  caption: [Comparação de arquiteturas digitais para DPD descritas na literatura.],
  source: [Guan e Zhu @Guan2010; Rahmanian et al. @Rahmanian2020; Li et al. @Li2021HLS.],
  text(size: 9pt, table(
    columns: (20%, 25%, 27%, 28%),
    align: (left, left, left, left),
    inset: 4pt,
    table.header([*Autores e ano*], [*Arquitetura*], [*Recursos*], [*Desempenho e condições*]),
    [Guan e Zhu (2010) @Guan2010],
    [Volterra; LUTs e compartilhamento temporal de multiplicadores (S3).],
    [16 DSP48, 1.220 _flip-flops_ e 1.418 LUTs de quatro entradas; configuração $P=7$, $M=4$ dos autores.],
    [ACPR inferior a $-60$ dBc nos dois canais adjacentes avaliados; NRMSE de 1,8% no ensaio de linearização.],
    [Rahmanian et al. (2020) @Rahmanian2020],
    [MP paralelo com _pipeline_ completo; $K=5$, $Q=5$ (atrasos de 0 a 5). Vírgula fixa: sinais de 14 bits e coeficientes de 10 bits; Xilinx System Generator.],
    [Zynq XC7Z045 FFG900-3: 731 Slice LUTs lógicas, 803 Slice Registers, 53 DSP48s, 0 BRAMs e 258 slices. Recursos reportados na Tabela 3.],
    [Frequência máxima reportada: 182,8 MHz (Tabela 3), sem atribuição de frequência efetivamente utilizada. Melhoria experimental de aproximadamente 11 dB em ACPR com 128-QAM e banda de cerca de 10 MHz.],
    [Li et al. (2021) @Li2021HLS],
    [LUTs escaláveis e células básicas de pré-distorção, com síntese de alto nível.],
    [Uso de recursos e potência da lógica programável avaliados; contagens não disponíveis no resumo consultado.],
    [Vazão avaliada; ensaio com dois sinais LTE de 20 MHz em banda instantânea total de 60 MHz.],
  )),
) <tab:literatura-arquiteturas>

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

O modelo MP pode ser interpretado como uma extensão do modelo polinomial estático, incorporando efeitos de memória por meio de uma forma reduzida da série de Volterra. Nessa abordagem, apenas produtos de amostras correspondentes ao mesmo instante de tempo são considerados. Matematicamente, o modelo MP é descrito pela @eq:mp, na qual todos os polinômios que compõem o modelo possuem a mesma ordem @Kim2001. A @eq:mp-original-p5-m2 retoma a decomposição em três ramos, com os vetores de coeficientes e funções de base definidos nas @eq:coeficientes-bloco-mp e @eq:termos-bloco-mp. A formulação de ordem dependente do atraso é dada adiante pela @eq:mp_truncado.

Entre as principais características do modelo MP, destaca-se o fato de que ele é baseado em multiplicações de sinais avaliados no mesmo instante de tempo, como $tilde(x)(n)|tilde(x)(n)|$ e $tilde(x)(n-1)|tilde(x)(n-1)|$. Além disso, como o modelo depende de informações passadas da fase da envoltória do sinal de entrada, ele é capaz de representar fenômenos associados às variações de fase da envoltória, incluindo as conversões PM--AM (_phase modulation to amplitude modulation_) e PM--PM (_phase modulation to phase modulation_). A @fig:mp_padrao apresenta o diagrama de blocos do modelo MP. A entrada complexa $x(n)$ alimenta uma linha de atrasos unitários, indicada pelos blocos $z^(-1)$, que disponibiliza $x(n-m)$. Em cada ramo, a função $g_m(r)=sum_(p=1)^P h_(p,m) r^(p-1)$ recebe o módulo $r=|x(n-m)|$ e combina suas potências com os coeficientes complexos do ramo. O multiplicador aplica $g_m$ à amostra complexa atrasada, preservando sua informação de fase, e o somatório reúne as contribuições para produzir $y(n)$. Na formulação geral ilustrada, todos os ramos compartilham $P$; na versão truncada, o limite de cada soma passa a ser $P_m$.

#figure(
  image("Figuras/mp_padrao.svg", width: 100%),
  caption: [Diagrama de blocos do modelo MP],
  source: [#cite(<Kim2001>, form: "prose")],
) <fig:mp_padrao>

=== Polinômio com Memória com Truncamento Polinomial Dependente do Atraso

Conforme discutido na @sec:polinomio-memoria, o modelo de Polinômio com Memória (MP) tradicional adota uma ordem polinomial máxima uniforme para todos os termos de memória. Embora essa abordagem simplifique a estrutura do modelo, ela pode resultar em um aumento desnecessário da complexidade computacional, uma vez que os efeitos não lineares associados a amostras mais antigas tendem a ser menos significativos do que aqueles relacionados à amostra atual.

Com o objetivo de explorar essa característica, propõe-se neste trabalho uma variação do modelo MP na qual a ordem polinomial máxima passa a ser definida de forma independente para cada atraso de memória. Dessa forma, o modelo deixa de utilizar um único parâmetro de ordem polinomial $P$ e passa a empregar um conjunto de ordens $\{P_0, P_1, dots.c, P_M\}$, em que $P_m$ representa a ordem polinomial máxima associada ao termo de atraso $m$.

Matematicamente, o modelo proposto pode ser expresso como:

$ y(n) = sum_(m=0)^(M) sum_(p=1)^(P_m) h_(p,m) , x(n - m) |x(n - m)|^(p-1) $ <eq:mp_truncado>

#par(first-line-indent: 0pt)[em que $M$ corresponde à profundidade de memória do modelo, $P_m$ define a ordem polinomial máxima associada ao atraso $m$, e $h_(p,m)$ são os coeficientes complexos a serem estimados. Observa-se que o modelo MP tradicional constitui um caso particular da @eq:mp_truncado, obtido quando se impõe $P_0 = P_1 = dots.c = P_M = P$.]

A principal motivação dessa abordagem reside na possibilidade de reduzir o número total de coeficientes do modelo sem comprometer significativamente sua capacidade de representação. Em particular, espera-se que a escolha de ordens polinomiais não crescentes com o aumento do atraso, isto é, $P_0 >= P_1 >= dots.c >= P_M$, seja suficiente para capturar os efeitos não lineares dominantes do amplificador de potência, concentrados majoritariamente na amostra atual e nos atrasos mais próximos.

Do ponto de vista de identificação, o modelo proposto preserva a linearidade nos parâmetros, permitindo a estimação dos coeficientes por meio de técnicas de mínimos quadrados convencionais, de forma análoga ao MP clássico. A diferença reside na construção da matriz de regressão, que passa a incorporar apenas os termos polinomiais correspondentes a cada ordem $P_m$, resultando em uma matriz de menor dimensão.

Além da redução de complexidade computacional, essa estrutura oferece vantagens diretas para a implementação em hardware. Como o número de termos polinomiais deixa de ser uniforme entre os atrasos, a descrição em VHDL pode ser reorganizada para eliminar explicitamente operações aritméticas desnecessárias, reduzindo o número de blocos funcionais do circuito sem alterar a formulação matemática do modelo.

== Arquitetura de hardware proposta <sec:arquitetura-hardware-proposta>

A arquitetura do modelo proposto, descrito em VHDL, consiste em uma linha de atrasos para as componentes real e imaginária do sinal de entrada em vírgula fixa, seguida pelo cálculo do módulo quadrático, pela geração recursiva e pelo alinhamento dos termos polinomiais. Os termos selecionados são multiplicados em paralelo pelos coeficientes complexos e acumulados por uma árvore de soma combinacional, com saturação e registro da saída. Registradores intermediários organizam o processamento em _pipeline_.

=== Formulação generalizada e configuração implementada

Na implementação em hardware são utilizadas somente funções de base de ordem ímpar. Para evitar ambiguidade com a formulação geral da @eq:mp_truncado, o índice $q$ representa, nesta seção, a posição da função de base dentro de cada ramo. Considerando profundidade de memória $M$, são implementados os atrasos $m in {0, dots.c, M}$, totalizando $M+1$ ramos. A quantidade de funções de base de cada ramo é definida pelo vetor

$ bold(P) = mat(P_0, P_1, dots.c, P_M), $ <eq:vetor-ordens-hardware>

#par(first-line-indent: 0pt)[no qual $P_m$ indica quantos termos de ordem ímpar são preservados no atraso $m$, e não a maior ordem polinomial desse ramo. A seleção das ordens ímpares corresponde a escrever a ordem da função de base como $p=2q+1$, com $q in {0, dots.c, P_m-1}$. Assim, o expoente $p-1$ da @eq:mp_truncado torna-se $2q$. Dessa forma, o modelo implementável é descrito genericamente por]

$ y(n) = sum_(m=0)^M sum_(q=0)^(P_m - 1) c_(m,q) x(n-m) |x(n-m)|^(2q), $ <eq:mp-hardware>

#par(first-line-indent: 0pt)[em que $c_(m,q)$ é o coeficiente complexo associado ao termo $q$ do ramo $m$. Como $x|x|^(2q)=x(x x^*)^q$, em que $x^*$ é o conjugado complexo, cada função possui ordem total $2q+1$. A maior ordem do ramo é, portanto, $2P_m-1$. O cálculo utiliza $|x|^2=Re{x}^2+Im{x}^2$ e multiplicações recursivas, dispensando a extração de raiz quadrada para obter $|x|$; essa organização motivou a escolha das potências pares do módulo para simplificar a implementação em vírgula fixa. O número total de termos complexos, e consequentemente de coeficientes, é]

$ N_"termos" = sum_(m=0)^M P_m. $ <eq:numero-termos-hardware>

Seguindo a representação vetorial adotada na @eq:mp-original-p5-m2, a expressão anterior pode ser reescrita como uma soma de produtos internos:

$ y(n) = sum_(m=0)^M bold(c)_m^T bold(phi)_m(n-m), $ <eq:mp-hardware-expandido>

#par(first-line-indent: 0pt)[para a qual os vetores associados a cada atraso são definidos por]

$ bold(c)_m^T = mat(c_(m,0), c_(m,1), dots.c, c_(m,P_m - 1)) $ <eq:coeficientes-mp-hardware>

#par(first-line-indent: 0pt)[e]

$ bold(phi)_m(n-m) = mat(
  x(n-m);
  x(n-m)|x(n-m)|^2;
  dots.v;
  x(n-m)|x(n-m)|^(2(P_m - 1))
). $ <eq:termos-mp-hardware>

A arquitetura desenvolvida neste trabalho corresponde à instanciação $M=2$ e $bold(P)=(5,3,1)$. Portanto, o ramo da amostra atual contém as ordens polinomiais 1, 3, 5, 7 e 9; o ramo do primeiro atraso contém as ordens 1, 3 e 5; e o ramo do segundo atraso contém apenas o termo linear. Essa configuração totaliza nove termos complexos. Em comparação com uma implementação uniforme com cinco funções de base em cada um dos três ramos, o número de termos é reduzido de 15 para 9, correspondendo a uma redução estrutural de 40% antes de serem consideradas as particularidades de síntese dos operadores.

A @fig:pipeline-dpd-clock apresenta a organização funcional e a sequência temporal implementadas no código VHDL para a configuração $bold(P)=(5,3,1)$. O banco de atrasos fornece as amostras $x(n-m)$ aos ramos de processamento, nos quais o módulo quadrático $r_m(n)=|x(n-m)|^2$ é reutilizado na geração recursiva das funções de base. Depois do alinhamento temporal, as funções selecionadas são ponderadas pelos respectivos coeficientes complexos e combinadas por uma árvore balanceada de soma. A figura acompanha três janelas consecutivas de entrada, identificadas pela amostra mais recente de cada janela, e mostra os resultados disponíveis em cada fronteira de registro. Como os processos síncronos são acionados pela mesma borda de subida, cada estágio utiliza os valores registrados no ciclo anterior, enquanto a lógica combinacional prepara os valores que serão capturados na borda seguinte.

#figure(
  image("Figuras/pipeline_dpd_por_clock.svg", width: 100%),
  caption: [Cronograma do _pipeline_ VHDL para três janelas consecutivas de entrada. Cada coluna identifica a borda em que o resultado é registrado; a lógica combinacional atua entre bordas. Os registros de alinhamento são detalhados na @tab:alinhamento-pipeline.],
  source: [Autor.],
) <fig:pipeline-dpd-clock>


A @tab:alinhamento-pipeline detalha o alinhamento dos termos da janela A, com $r = |x(n-m)|^2$. Cada termo atravessa um registro inicial e $4-q$ deslocamentos adicionais, de modo que todos ficam disponíveis em $C_8$.

#figure(
  kind: table,
  caption: [Geração e alinhamento dos termos polinomiais da janela A no _pipeline_.],
  source: [Autor.],
  table(
    columns: (22%, 16%, 24%, 21%, 17%),
    align: center,
    inset: 5pt,
    table.header([*Termo*], [*Geração*], [*Entrada em* `align(0)`], [*Deslocamentos*], [*Disponível*]),
    [$T_0 = x$], [$C_3$], [$C_4$], [4], [$C_8$],
    [$T_1 = x r$], [$C_4$], [$C_5$], [3], [$C_8$],
    [$T_2 = x r^2$], [$C_5$], [$C_6$], [2], [$C_8$],
    [$T_3 = x r^3$], [$C_6$], [$C_7$], [1], [$C_8$],
    [$T_4 = x r^4$], [$C_7$], [$C_8$], [0], [$C_8$],
  ),
) <tab:alinhamento-pipeline>

No ciclo $C_1$, o processo `delay_process` converte `UR` e `UI` para a representação inteira interna, insere a nova amostra em `delay_line(0)` e desloca as amostras anteriores. Em $C_2$, a lógica `gen_prep_power` calcula, em paralelo para todos os atrasos, as componentes de base e o módulo quadrático $|x(n-m)|^2$; os resultados são armazenados por `prep_power_process` em `base_vec` e `msq_vec`.

Entre $C_3$ e $C_7$, `terms_pipe_process` registra sucessivamente os termos $T_(m,q)=x(n-m)|x(n-m)|^(2q)$. O termo linear é registrado em `term_pipe(0)` no ciclo $C_3$, e cada estágio posterior multiplica o termo anterior pelo módulo quadrático. Ao mesmo tempo, `align_process` desloca em `align_pipe` os termos produzidos mais cedo. Cada termo passa inicialmente por `align_pipe(0)` na borda seguinte à sua geração. A seleção `dsel = max_poly_degree - 1 - q` acrescenta quatro, três, dois, um e zero deslocamentos a esse registro inicial para $q=0,1,2,3,4$, respectivamente. Portanto, os termos atravessam cinco, quatro, três, dois e um registros de alinhamento, ficando disponíveis simultaneamente em $C_8$. O módulo quadrático também acompanha a amostra por `msq_pipe`, preservando sua correspondência com cada multiplicação recursiva.

No ciclo $C_9$, `pack_xx_process` seleciona, segundo $bold(P)=(5,3,1)$, os nove termos válidos e os registra no vetor `XX`. Em $C_10$, `mult_process` registra os nove produtos complexos calculados em paralelo por `gen_mult`. Entre as bordas $C_10$ e $C_11$, os quatro níveis combinacionais de `sum_tree` reduzem esses produtos a uma única soma complexa. Finalmente, em $C_11$, `sum_process` satura as componentes real e imaginária e as registra em `UR_out` e `UI_out`.

A amostra capturada em $C_1$ tem sua saída registrada em $C_11$, após dez períodos de relógio. A latência entre essas bordas é, portanto, $10 T_"clk"$. Já o intervalo de iniciação do RTL é de um ciclo: as janelas identificadas por $x[n+1]$ e $x[n+2]$, capturadas em $C_2$ e $C_3$, produzem suas saídas em $C_12$ e $C_13$. Após o preenchimento, a vazão lógica é de uma amostra complexa por ciclo, ou $f_"clk"$ amostras por segundo, desde que as restrições de temporização sejam atendidas. Essa relação não estabelece a frequência máxima de operação. A validação temporal dos modelos padrão e reduzido foi realizada com netlists pós-roteamento e anotação SDF dos atrasos da tecnologia, conforme descrito na @sec:metodologia-validacao. A latência em ciclos aqui apresentada é derivada do escalonamento do RTL; os atrasos de propagação são considerados na simulação temporal.

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

Na @tab:termos-xx, os índices de `XX` iniciam em zero e os termos são agrupados por atraso: primeiro os cinco do ramo $m=0$, depois os três do ramo $m=1$ e, por último, o termo linear de $m=2$. Dentro de cada grupo, $q$ cresce de zero até $P_m-1$. O índice global é a soma de $q$ com as quantidades de termos dos ramos anteriores: $k=q+sum_(j=0)^(m-1) P_j$, adotando-se soma nula para $m=0$. Assim, `XX(5)` corresponde a $m=1$, $q=0$, enquanto `XX(8)` corresponde a $m=2$, $q=0$. O banco de coeficientes acompanha exatamente essa ordenação; cada elemento pondera uma única função de base da mesma janela temporal.

=== Entrada complexa e linha de atrasos

A entrada é formada pelos sinais `UR` e `UI`, correspondentes às componentes real e imaginária de $x(n)$. Cada componente possui 11 bits e é interpretada como um inteiro com sinal. Após a conversão para a representação numérica interna, a amostra é inserida em uma linha de atrasos que disponibiliza simultaneamente $x(n)$, $x(n-1)$ e $x(n-2)$. Essa estrutura fornece as três posições temporais necessárias à @eq:mp-hardware.

Para cada posição da linha de atrasos, o circuito calcula o módulo quadrático da amostra complexa segundo

$ |x(n-m)|^2 = Re{x(n-m)}^2 + Im{x(n-m)}^2. $ <eq:modulo-quadratico-hardware>

#par(first-line-indent: 0pt)[São necessárias duas multiplicações reais para elevar as componentes ao quadrado e uma soma para produzir o módulo quadrático. Como essas operações aumentam a largura da palavra, o resultado passa por um ajuste de escala antes de ser utilizado nos estágios seguintes. A amostra complexa e o módulo quadrático ajustado são então armazenados nos registradores `base_vec` e `msq_vec`. Esse primeiro estágio de _pipeline_ separa o cálculo da potência da geração das funções de base e reduz o caminho combinacional.]

=== Geração recursiva e alinhamento dos termos

As funções de base são geradas recursivamente. Para cada atraso $m$, o termo inicial é

$ T_(m,0) = x(n-m), $

#par(first-line-indent: 0pt)[e os termos seguintes são calculados por]

$ T_(m,q) = T_(m,q-1) |x(n-m)|^2. $ <eq:recorrencia-termos-hardware>

#par(first-line-indent: 0pt)[Consequentemente, $T_(m,q) = x(n-m)|x(n-m)|^(2q)$. Essa recorrência reutiliza o resultado do estágio anterior, evitando o cálculo independente das potências da magnitude. As multiplicações são distribuídas em estágios sucessivos de _pipeline_, o que permite limitar a lógica combinacional entre registradores.]

Os termos de diferentes ordens não ficam naturalmente disponíveis no mesmo ciclo: o termo linear é obtido antes dos termos que atravessam uma ou mais multiplicações recursivas. A rede de registradores `align_pipe` compensa essas diferenças de latência, atrasando os resultados produzidos mais cedo. Dessa forma, todos os termos associados à mesma janela de entrada chegam simultaneamente à etapa de ponderação pelos coeficientes. Após o alinhamento, os nove termos válidos são selecionados conforme a @tab:termos-xx e empacotados no vetor `XX`.

=== Multiplicação pelos coeficientes

O banco de coeficientes contém nove valores complexos quantizados, um para cada elemento de `XX`. Os nove produtos complexos são calculados em paralelo. Considerando $c_k = c_(k,R) + j c_(k,I)$ e $X_k = X_(k,R) + j X_(k,I)$, cada produto é decomposto em

$ Re{c_k X_k} = c_(k,R) X_(k,R) - c_(k,I) X_(k,I), $

$ Im{c_k X_k} = c_(k,R) X_(k,I) + c_(k,I) X_(k,R). $

#par(first-line-indent: 0pt)[Essa forma direta utiliza quatro multiplicações reais, uma soma e uma subtração por produto complexo. Os resultados passam pelas operações de redimensionamento previstas na implementação em vírgula fixa e são registrados antes da acumulação. O paralelismo dessa etapa aumenta o uso instantâneo de operadores, mas permite sustentar o processamento contínuo de amostras sem reutilização temporal dos multiplicadores.]

=== Árvore de soma e saída

Os nove produtos ponderados são acumulados por uma árvore binária de soma. Em cada nível, os valores são agrupados em pares; quando o número de elementos é ímpar, o elemento restante é propagado ao nível seguinte. Para nove entradas, a redução requer quatro níveis, pois $ceil(log_2 9) = 4$. Em comparação com uma cadeia de oito somadores, essa organização reduz a profundidade do caminho combinacional e facilita o atendimento às restrições de temporização.

Ao final da árvore, as componentes real e imaginária são limitadas à faixa representável pelas saídas de 11 bits. A saturação impede o retorno modular em situações de _overflow_, comportamento que ocorreria caso os bits mais significativos fossem simplesmente descartados. O resultado saturado é convertido para `STD_LOGIC_VECTOR` e armazenado nos registradores `UR_out` e `UI_out`.

O fluxo completo da arquitetura é, portanto, composto por seis etapas: armazenamento das amostras na linha de atrasos; cálculo de $|x|^2$; geração recursiva das funções de base; alinhamento temporal e formação de `XX`; multiplicação paralela pelos coeficientes; e acumulação seguida de saturação. A combinação de paralelismo, _pipeline_ e alinhamento explícito torna a arquitetura adequada ao processamento contínuo em FPGA, enquanto a distribuição $bold(P) = (5, 3, 1)$ elimina funções de base dos atrasos em que foram consideradas menos relevantes.

== Metodologia de validação da proposta <sec:metodologia-validacao>

A validação da proposta foi organizada de forma integrada, contemplando a implementação em software, a implementação em hardware e a aplicação do modelo tanto à modelagem direta quanto à linearização do PA. Em software, os coeficientes dos modelos MP foram estimados em Python a partir de dados medidos de entrada e saída, e a precisão foi avaliada em conjuntos independentes de validação. Em hardware, as estruturas foram descritas em VHDL com aritmética de vírgula fixa, permitindo comparar sua equivalência funcional com o modelo em Python e analisar os recursos estruturais após a síntese lógica.

O erro de modelagem foi quantificado pelo _Normalized Mean Squared Error_ (NMSE) --- erro quadrático médio normalizado @Muha1999, definido por:

$ "NMSE" = 10 log_(10) lr(( frac(
  sum_(n=1)^(N) |e(n)|^2,
  sum_(n=1)^(N) |y_"real" (n)|^2
) )) $ <eq:nmse>

#par(first-line-indent: 0pt)[em que $y_"real" (n)$ é a amostra medida na saída do PA, $e(n) = y_"real" (n) - y_"model" (n)$ é o erro entre a saída medida e a estimada, e $N$ é o número de amostras consideradas. Valores de NMSE mais negativos indicam menor erro normalizado.]

Foram considerados dois conjuntos de dados empíricos. O primeiro corresponde a medições de um amplificador de potência classe AB, do tipo GaN HEMT, excitado por uma portadora de 900~MHz modulada por um sinal WCDMA 3GPP com largura de banda aproximada de 3,84~MHz e amostrado a 61,44~MHz, conforme a caracterização experimental de Bonfim e Lima @Bonfim2016, também utilizada no TCC que antecede este trabalho. O segundo corresponde a medições de um amplificador LDMOS, organizadas em 4.500 amostras complexas para extração dos coeficientes e 4.500 amostras complexas para validação. Em ambos os casos, os dados disponíveis são pares complexos de entrada e saída do PA, adequados para identificação, validação e comparação entre estruturas de modelo. Os arquivos são, respectivamente, `in_out_SBRT2_direto.mat` e `data_LDMOS_formatted_4500p.mat`. Não se atribuem ao conjunto LDMOS as frequências e a largura de banda documentadas para o conjunto GaN HEMT.

=== Implementação em VHDL do modelo MP truncado

A validação em hardware foi realizada por meio da implementação em VHDL de duas arquiteturas: a versão original do modelo MP, com ordem polinomial uniforme em todos os atrasos, e a versão truncada com ordem dependente do atraso. Ambas foram descritas em vírgula fixa e organizadas em uma estrutura baseada em soma de produtos complexos, preservando os ramos de memória e o cálculo explícito dos termos polinomiais.

Na versão truncada, a redução da ordem polinomial nos atrasos mais antigos foi acompanhada por uma reorganização da arquitetura para remover diretamente as operações redundantes. Dessa forma, a comparação entre as duas implementações permite avaliar não apenas a equivalência funcional em relação ao modelo de referência em Python, mas também os ganhos efetivos de complexidade estrutural obtidos após a síntese lógica.

Para a verificação funcional e estrutural, foram empregadas ferramentas open source. O GHDL foi utilizado para analisar e elaborar a descrição VHDL e executar o testbench de simulação comportamental em nível RTL, com geração de formas de onda para inspeção no GTKWave. As saídas em vírgula fixa obtidas nessa simulação foram comparadas com a referência em Python. Na etapa de síntese lógica, o GHDL também atuou como interface de entrada VHDL do Yosys, por meio do plugin GHDL. O Yosys realizou a síntese e a otimização lógica e gerou as estatísticas de fios, células e registradores utilizadas na comparação de complexidade estrutural. Essas contagens correspondem à síntese genérica e não à ocupação física de recursos específicos da FPGA.

As implementações em FPGA dos modelos padrão, com configuração $[5,5,5]$, e reduzido, com configuração $[5,3,1]$, foram realizadas para o dispositivo Xilinx Artix-7 XC7A100T, encapsulamento CSG324, utilizando Xilinx ISE 14.7. Ambos os modelos foram testados no fluxo de implementação com frequência-alvo de operação de 100~MHz. A ocupação dos recursos físicos foi obtida após mapeamento, posicionamento e roteamento. A comparação correspondente é apresentada na @sec:resultados-fpga.

Os arquivos preservados em `questa_sim` documentam uma simulação em nível de portas (_gate-level_) com informações temporais pós-roteamento. A netlist Verilog `DPD_timesim.v` foi exportada pelo Netgen do ISE 14.7 a partir de `DPD.ncd`, e os atrasos foram fornecidos por `DPD_timesim.sdf`. O roteiro `setup.do` compila a netlist, `glbl.v`, as bibliotecas de primitivas Xilinx e os arquivos VHDL `functions.vhd` e `tb_main.vhd`. O registro `transcript` identifica o Questa Altera Starter FPGA Edition 2025.2, confirma a anotação SDF e registra o término em 45030~ns, com zero erros e zero avisos. Não foi identificado um registro independente de simulação funcional de uma netlist apenas sintetizada, sem atrasos pós-roteamento.

As duas configurações, padrão $[5,5,5]$ e reduzida $[5,3,1]$, foram simuladas e validadas em nível de portas com anotação SDF dos atrasos da tecnologia. Essa etapa utilizou as netlists pós-roteamento correspondentes e foi executada em Questa. Portanto, a validação contemplou tanto a simulação funcional RTL quanto a simulação temporal dos dois modelos. A simulação temporal considera os atrasos de propagação do circuito implementado e é distinta da análise estática de temporização no ISE, que verifica o atendimento às restrições dos caminhos temporais.

=== Evidências empíricas para o truncamento polinomial

Com o objetivo de fundamentar empiricamente a hipótese de que a não linearidade dominante do amplificador está concentrada no instante atual, foi realizada uma análise específica sobre o conjunto LDMOS descrito anteriormente. Nessa etapa, foram consideradas profundidade de memória $M = 2$ e ordens polinomiais variando de 1 a 5, utilizando três análises complementares: magnitude dos coeficientes por ramo de memória, sensibilidade do NMSE a cada parâmetro $P_m$ e espectro do erro residual.

Na análise dos coeficientes, foi considerado um modelo MP completo com $P_0 = P_1 = P_2 = 5$, usando as potências consecutivas do módulo da @eq:mp_truncado. Essa análise foi gerada em execução distinta da avaliação dos 125 modelos, cuja base contém somente ordens ímpares. A energia dos coeficientes de cada ramo foi calculada por

$ E_m = sum_(p=1)^(P_"max") |h_(p,m)|^2, $

#par(first-line-indent: 0pt)[em que $E_m$ é a norma quadrática do vetor de coeficientes do ramo $m$, $p$ enumera seus coeficientes e $P_"max"=5$ é o limite dessa análise. Essa medida descreve os coeficientes na base e na escala utilizadas; ela não é, isoladamente, a energia do sinal de saída do ramo, pois essa energia também depende das funções de base e de suas correlações. Adicionalmente, para avaliar a sensibilidade do modelo a cada ordem polinomial, dois parâmetros foram mantidos fixos em 1 enquanto o terceiro variou entre 1 e 5, medindo-se o ganho de NMSE produzido pelo aumento de complexidade em cada ramo. Por fim, o sinal de erro residual foi analisado no domínio da frequência com janela de Blackman, FFT de 8192 pontos e média de grupos de 50 bins espectrais consecutivos em dB, seguindo a organização do script de referência. Essa análise permite comparar o erro residual associado às configurações $P_0$, $P_1$ e $P_2$. Como não há registros de aquisição e calibração do conjunto LDMOS, os eixos herdados do exemplo não são empregados como frequências ou potências físicas desse PA. As figuras utilizam frequência normalizada em ciclos por amostra e níveis relativos a uma referência comum, definida pelo máximo do espectro médio da saída medida. Não são atribuídas a esses gráficos unidades de MHz ou dBm/Hz.]

=== Avaliação em múltiplos conjuntos de dados

Para verificar a capacidade de generalização da metodologia, o _pipeline_ completo de identificação e avaliação dos modelos MP com ordem dependente do atraso foi aplicado aos dois conjuntos empíricos descritos anteriormente. Em ambos os casos, foram avaliadas exaustivamente todas as 125 combinações possíveis de quantidades de funções de base $(P_0, P_1, P_2)$ com $P_m in {1, 2, 3, 4, 5}$ e profundidade de memória $M = 2$. O código dessa avaliação utiliza $x(n-m)|x(n-m)|^(2(p-1))$, com $p=1, dots.c, P_m$, equivalente à indexação $q=p-1$ da @eq:mp-hardware. Portanto, os valores de 1 a 5 denotam quantidades de funções de base e correspondem a maiores ordens ímpares de 1 a 9. As configurações numéricas dos gráficos e das tabelas são mantidas nessa convenção de contagem.

Os coeficientes complexos de cada modelo foram estimados em Python com `scipy.optimize.least_squares`, utilizando os conjuntos de extração, e o desempenho foi avaliado nos conjuntos de validação por meio do NMSE. Essa etapa permitiu comparar não apenas o nível absoluto de desempenho entre tecnologias distintas de amplificadores, mas também a estabilidade dos padrões estruturais observados anteriormente, como a predominância de $P_0$ e a eficiência dos modelos com distribuição não crescente de ordens.

=== Identificação do sistema DPD + PA

Além da modelagem direta do amplificador, foi avaliado um sistema completo de pré-distorção digital baseado no modelo MP. Nessa etapa, utilizou-se o conjunto de medições do PA LDMOS para identificar inicialmente o modelo do PA com profundidade de memória $M = 2$ e cinco funções de base de ordem ímpar por ramo ($P = 5$), correspondentes às ordens 1, 3, 5, 7 e 9, totalizando 15 coeficientes complexos. Em seguida, foi adotada a arquitetura _Indirect Learning Architecture_ (ILA), na qual o DPD é treinado como o inverso do PA a partir do mapeamento entre a saída medida do amplificador e o sinal de entrada original.

A cascata final considerada foi composta por $x(n) -> "DPD"(x(n)) -> "PA"("DPD"(x(n)))$. Foi aplicado um fator global de ganho na entrada do sistema para ajustar a faixa de amplitudes utilizada na avaliação da cascata. Inicialmente, o ganho foi calculado pela razão entre a amplitude máxima de `out_data_ext` e a amplitude máxima de `in_data_ext`, correspondentes, respectivamente, aos sinais de saída e entrada do PA no conjunto de extração. Essa razão foi multiplicada pelo fator 0,9999999999999, ligeiramente inferior à unidade, resultando em aproximadamente 0,83. Posteriormente, o ganho foi ajustado manualmente por inspeção visual da resposta da cascata. Nas condições avaliadas, observou-se uma relação aproximadamente linear entre entrada e saída, com ganho aproximadamente constante, até o ajuste de 0,95; valores superiores apresentaram perda dessa característica. Assim, adotou-se o ganho fixo de 0,95 como ajuste empírico para o cenário considerado. A escolha não decorreu de uma busca sistemática nem de um critério quantitativo de otimização. A @fig:cascatadpd ilustra o encadeamento dos blocos do sistema.

// ═════════════════════════════════════════════════════════════════════════════
= Resultados e Discussão
// ═════════════════════════════════════════════════════════════════════════════

Este capítulo apresenta os resultados obtidos a partir da validação inicial das estruturas de modelagem propostas na @sec:mp-original, com foco na caracterização do desempenho do modelo _Memory Polynomial_ (MP) clássico aplicado à modelagem comportamental de um amplificador de potência real. Além da validação em vírgula flutuante, são apresentados os resultados do modelo MP com truncamento polinomial dependente do atraso e sua implementação em VHDL, com ênfase na equivalência funcional em vírgula fixa e na redução de complexidade estrutural obtida em síntese.

Os conjuntos de dados, a métrica NMSE e os procedimentos de validação estão descritos na @sec:metodologia-validacao. Os resultados gráficos dos 125 modelos, apresentados da @fig:desempenho125modelos à @fig:fronteiradepareto, correspondem exclusivamente ao conjunto GaN HEMT. As demais análises de modelagem, coeficientes, sensibilidade, espectros, validação em vírgula fixa e aplicação DPD + PA deste capítulo utilizam o conjunto LDMOS. A seção de generalização apresenta separadamente a comparação entre os dois conjuntos. Neste capítulo, são apresentados os resultados da modelagem do PA, da avaliação dos truncamentos e da implementação em VHDL. Valores mais negativos de NMSE correspondem a menor erro normalizado e, portanto, a melhor aproximação dos dados medidos.

== Modelagem do PA com MP original

Nesta seção são apresentados os resultados da modelagem comportamental do amplificador de potência (PA) utilizando o modelo _Memory Polynomial_ (MP) original, conforme descrito no Capítulo~3. Esta etapa utiliza o conjunto LDMOS e tem como principal objetivo estabelecer uma referência de desempenho (_baseline_) que servirá de comparação para as abordagens alternativas propostas neste trabalho, em especial o modelo MP com truncamento polinomial dependente do atraso.

A implementação do modelo foi realizada em ambiente Python, empregando aritmética em vírgula flutuante, com o intuito de avaliar o desempenho do MP em um cenário de alta precisão numérica, sem restrições impostas por quantização ou limitações de hardware. Essa escolha permite isolar os efeitos da estrutura do modelo, garantindo que eventuais limitações observadas estejam associadas predominantemente à capacidade de representação do modelo MP, e não a aspectos relacionados à implementação ou à aritmética utilizada.

A @fig:modelopafloat apresenta o diagrama representativo do modelo do PA implementado em vírgula flutuante.

#figure(
  image("Figuras/modelopafloat.png", width: 50%),
  caption: [Característica AM–AM medida e estimada pelo modelo MP original para o PA LDMOS.],
  source: [Autor],
) <fig:modelopafloat>

A identificação dos coeficientes do modelo foi realizada por meio de um procedimento de otimização numérica, utilizando métodos de mínimos quadrados aplicados à formulação do erro entre o sinal de saída real do PA e o sinal estimado pelo modelo. Após o processo de identificação, o desempenho do modelo foi avaliado em um conjunto de dados distinto daquele utilizado na etapa de estimação dos coeficientes, de forma a evitar sobreajuste.

Para a configuração considerada, o modelo MP original alcançou um valor de NMSE igual a $-37,51$~dB, evidenciando uma boa capacidade de aproximação do comportamento do amplificador de potência real em regime de banda larga. Esse resultado confirma a adequação do modelo MP clássico como referência de desempenho e estabelece um ponto de comparação consistente para a avaliação das estruturas alternativas propostas neste trabalho.

== Evidências empíricas para o truncamento polinomial dependente do atraso

Com o objetivo de sustentar empiricamente a hipótese de truncamento polinomial dependente do atraso, foi realizada uma análise específica sobre o conjunto LDMOS descrito na @sec:metodologia-validacao. As evidências foram organizadas em três frentes complementares: análise da magnitude dos coeficientes por ramo de memória, sensibilidade do NMSE às ordens $P_0$, $P_1$ e $P_2$, e inspeção do espectro do erro residual.

=== Evidência 1: magnitude dos coeficientes por ramo de memória

A análise considera o conjunto LDMOS e o modelo MP completo com $P_0 = P_1 = P_2 = 5$, totalizando 15 coeficientes complexos na base de potências consecutivas do módulo. As energias por ramo apresentadas a seguir foram obtidas pela soma dos módulos quadráticos dos coeficientes associados a cada atraso. Essa execução é distinta da avaliação de ordens ímpares consolidada na @tab:generalizacao-configuracoes; os resultados das duas bases não são tratados como pertencentes ao mesmo ajuste.

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
  stack(dir: ttb, spacing: 3pt,
    image("Figuras/ev1_magnitude_coeficientes.png", width: 100%),
    grid(columns: (1fr, 1fr), align: center,
      [(a) Magnitude por termo e atraso],
      [(b) Energia dos coeficientes por ramo],
    ),
  ),
  caption: [Coeficientes do modelo MP no conjunto LDMOS: (a) magnitude $|h_(p,m)|$ por índice $p$; (b) energia $E_m$ dos coeficientes por ramo de memória.],
  source: [Autor],
) <fig:ev1-magnitude-coeficientes>

A @tab:energia-ramos-memoria mostra um decaimento monotônico da energia dos coeficientes com o atraso, para a base e a escala adotadas. Esse resultado motiva a investigação de truncamentos não crescentes ao longo da memória, mas não demonstra, isoladamente, a contribuição de cada ramo ao sinal de saída. Essa avaliação é complementada pelas análises de sensibilidade e do erro residual.

A @fig:ev1-magnitude-coeficientes(a) mostra que, ao passar do índice $p=4$ para $p=5$, a magnitude do coeficiente diminui nos três ramos, inclusive no ramo $m=0$. Essa observação compara termos de um mesmo ajuste com cinco funções por ramo; ela não representa uma comparação entre dois modelos reestimados com ordens máximas 4 e 5. A figura, por si só, não permite atribuir a redução a um mecanismo físico, à saturação ou ao sobreajuste. No painel (b), a energia agregada dos coeficientes diminui de $m=0$ para $m=2$, embora o painel (a) mostre que o ramo $m=1$ apresenta magnitude ligeiramente superior à do ramo $m=0$ em $p=4$ e $p=5$.

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
  caption: [Sensibilidade do NMSE a $P_0$, $P_1$ e $P_2$ no conjunto LDMOS. O ganho associado a $P_0$ é significativamente superior aos obtidos para os atrasos mais antigos.],
  source: [Autor],
) <fig:ev2-sensibilidade-nmse>

A @tab:sensibilidade-nmse-ordens quantifica a melhora de NMSE para cada ramo, e a @fig:ev2-sensibilidade-nmse apresenta visualmente essas três tendências. O incremento associado a $P_0$ (6,66 dB) supera o de $P_1$ (3,43 dB) em 3,23 dB e o de $P_2$ (1,49 dB) em 5,17 dB. Como esses valores estão em escala logarítmica, a comparação é expressa por diferenças em dB. Os resultados mostram que a complexidade polinomial deve ser concentrada no ramo do instante atual, enquanto os atrasos mais antigos apresentam ganhos marginais.

=== Evidência 3: espectro do erro residual

O erro residual foi analisado no domínio da frequência para diferentes configurações de modelo, com janela de Blackman, FFT de 8192 pontos e média de 50 bins espectrais consecutivos em dB. Os sete valores de NMSE reproduzem, ao arredondamento apresentado nos gráficos, os resultados da análise original. A frequência é normalizada e os níveis são relativos, conforme a @sec:metodologia-validacao; essa apresentação permite comparar as curvas sem presumir a calibração física do conjunto LDMOS.

#figure(
  image("Figuras/ev3_espectro_erro_normalizado.pdf", width: 100%),
  caption: [Espectros relativos do erro residual no conjunto LDMOS: (a) variação de $P_0$; (b) variação de $P_1$; (c) variação de $P_2$. Frequência em ciclos por amostra e referência comum no máximo do espectro da saída medida.],
  source: [Autor],
) <fig:ev3-espectro-erro>

Na @fig:ev3-espectro-erro, os três painéis isolam a influência de cada ramo: o painel (a) varia $P_0$, mantendo $P_1 = P_2 = 1$; o painel (b) varia $P_1$, com $P_0 = P_2 = 1$; e o painel (c) varia $P_2$, com $P_0 = P_1 = 1$. A curva pontilhada representa a saída medida do PA, a referência cinza corresponde ao modelo $(1,1,1)$ e as demais curvas mostram o erro residual das ordens testadas. Ao aumentar $P_0$, o NMSE melhora de $-28,7$ dB para $-33,9$ dB e $-35,4$ dB. Para $P_1$, a melhora é de $-28,7$ dB para $-31,8$ dB e depois apenas para $-32,1$ dB; para $P_2$, chega a aproximadamente $-30,2$ dB e praticamente satura entre as ordens 3 e 5.

#figure(
  image("Figuras/ev_bonus_psd_normalizado.pdf", width: 100%),
  caption: [Espectros relativos da entrada, da saída medida do PA e dos erros de modelagem no conjunto LDMOS. Frequência em ciclos por amostra e mesma referência de nível em todas as curvas.],
  source: [Autor],
) <fig:ev-bonus-psd-completo>

Na @fig:ev-bonus-psd-completo, a comparação entre entrada, saída medida e erros de modelagem mostra que o espalhamento espectral residual diminui mais quando a ordem do instante atual aumenta. Em conjunto, as @fig:ev3-espectro-erro e @fig:ev-bonus-psd-completo confirmam, no domínio da frequência, o padrão observado nas análises de coeficientes e NMSE: aumentar $P_0$ reduz mais efetivamente o erro residual e o _regrowth_ espectral, enquanto aumentos em $P_1$ e $P_2$ produzem ganhos menores.

== Avaliação do Modelo MP com Ordem Dependente do Atraso

Nesta seção é apresentada a avaliação dos 125 modelos _Memory Polynomial_ (MP) com ordem polinomial dependente do atraso no conjunto GaN HEMT, identificado pelo arquivo `in_out_SBRT2_direto.mat`. Todos os gráficos desta seção, da @fig:desempenho125modelos à @fig:fronteiradepareto, foram obtidos com esse conjunto, incluindo a análise de influência das ordens, a relação entre NMSE e complexidade e a fronteira de Pareto. Diferentemente do modelo MP tradicional, no qual todos os ramos de memória utilizam uma mesma ordem polinomial máxima, a abordagem analisada permite que cada atraso possua um truncamento polinomial próprio. Tal estratégia visa investigar a influência individual da ordem polinomial associada a cada atraso no desempenho global do modelo.

Para essa análise, foi considerada uma profundidade de memória $M = 2$, sendo avaliadas todas as combinações possíveis de quantidades de funções de base de ordem ímpar $(P_0, P_1, P_2)$ variando de 1 a 5. Os parâmetros são contagens por ramo, conforme a @eq:mp-hardware; o valor 5 corresponde à maior ordem ímpar 9. A denominação “ordem” preservada nos gráficos deve ser lida segundo essa convenção. Esse procedimento resultou em um total de 125 modelos distintos, todos treinados em vírgula flutuante. Para cada modelo, foram registrados o valor do NMSE e a quantidade total de coeficientes utilizada.

A @fig:desempenho125modelos apresenta o desempenho dos 125 modelos avaliados, relacionando o NMSE com o número total de coeficientes. De maneira geral, observa-se que o aumento da quantidade de coeficientes tende a melhorar a precisão do modelo. Entretanto, nota-se que esse fator, isoladamente, não é determinante para a obtenção de melhores resultados. Modelos com complexidade semelhante podem apresentar desempenhos significativamente distintos, indicando que a distribuição da ordem polinomial entre os atrasos exerce papel fundamental na acurácia do modelo.

#figure(
  image("Figuras/desempenho125modelos.png", width: 75%),
  caption: [Desempenho dos 125 modelos MP com ordem dependente do atraso no conjunto GaN HEMT.],
  source: [Autor],
) <fig:desempenho125modelos>

=== Influência da ordem polinomial nos respectivos atrasos

Nesta etapa, é analisada a influência individual da ordem polinomial associada a cada atraso de memória sobre o desempenho do modelo. Os gráficos da @fig:influenciap0, da @fig:influenciap1 e da @fig:influenciap2 mostram a relação entre o NMSE e a ordem polinomial correspondente aos atrasos $m=0$, $m=1$ e $m=2$, respectivamente, considerando todos os modelos avaliados.

#figure(
  image("Figuras/influenciap0.png", width: 75%),
  caption: [Influência da ordem polinomial no instante atual ($P_0$) no conjunto GaN HEMT.],
  source: [Autor],
) <fig:influenciap0>

#figure(
  image("Figuras/influenciap1.png", width: 75%),
  caption: [Influência da ordem polinomial no atraso $m=1$ ($P_1$) no conjunto GaN HEMT.],
  source: [Autor],
) <fig:influenciap1>

#figure(
  image("Figuras/influenciap2.png", width: 75%),
  caption: [Influência da ordem polinomial no atraso $m=2$ ($P_2$) no conjunto GaN HEMT.],
  source: [Autor],
) <fig:influenciap2>

Na @fig:influenciap0, a distribuição dos NMSEs se desloca de forma mais acentuada para valores negativos menores quando $P_0$ aumenta, indicando que elevar a ordem no instante atual melhora substancialmente a representação da não linearidade dominante. A @fig:influenciap1 também mostra melhora com o aumento de $P_1$, mas o deslocamento é menos pronunciado e parte da dispersão permanece, pois os demais ramos variam entre os modelos. Já na @fig:influenciap2, a mudança entre ordens é menor: os pontos se concentram em faixas de NMSE próximas, sugerindo que termos de alta ordem no atraso mais antigo acrescentam pouco desempenho. Em conjunto, as figuras mostram uma sensibilidade decrescente de $P_0$ para $P_1$ e $P_2$.

Os gráficos da @fig:nmsecomplexp0, da @fig:nmsecomplexp1 e da @fig:nmsecomplexp2 relacionam o NMSE à complexidade do modelo e destacam separadamente a influência das ordens polinomiais $P_0$, $P_1$ e $P_2$. Eles permitem visualizar como a alocação da complexidade entre os atrasos afeta o desempenho global.

#figure(
  image("Figuras/nmsecomplexp0.png", width: 75%),
  caption: [NMSE em função da complexidade no conjunto GaN HEMT, destacando a ordem $P_0$.],
  source: [Autor],
) <fig:nmsecomplexp0>

#figure(
  image("Figuras/nmsecomplexp1.png", width: 75%),
  caption: [NMSE em função da complexidade no conjunto GaN HEMT, destacando a ordem $P_1$.],
  source: [Autor],
) <fig:nmsecomplexp1>

#figure(
  image("Figuras/nmsecomplexp2.png", width: 75%),
  caption: [NMSE em função da complexidade no conjunto GaN HEMT, destacando a ordem $P_2$.],
  source: [Autor],
) <fig:nmsecomplexp2>

Na @fig:nmsecomplexp0, os pontos coloridos por $P_0$ mostram que configurações com maior ordem no instante atual tendem a alcançar NMSE mais negativo, mesmo com número moderado de coeficientes. Na @fig:nmsecomplexp1, as cores se sobrepõem mais para uma mesma complexidade: elevar $P_1$ isoladamente não garante melhora, pois o resultado também depende da ordem atribuída ao instante atual. A @fig:nmsecomplexp2 apresenta sobreposição ainda mais forte entre as ordens de $P_2$, sem uma tendência sistemática de redução do NMSE conforme esse parâmetro cresce.

Portanto, a comparação entre a @fig:nmsecomplexp0, a @fig:nmsecomplexp1 e a @fig:nmsecomplexp2 indica que a complexidade adicional é mais bem aproveitada quando direcionada a $P_0$. O aumento de $P_1$ pode contribuir em conjunto com $P_0$, enquanto elevar $P_2$ tende a aumentar o número de coeficientes sem ganhos equivalentes de precisão. Essa leitura complementa a análise de sensibilidade e explica por que a quantidade de termos, por si só, não determina o desempenho.

Por fim, a @fig:modelosdecrecenteatraso apresenta os modelos que respeitam a relação $P_0 >= P_1 >= P_2$. Observa-se que grande parte dos modelos com melhor desempenho pertence a esse conjunto, reforçando a hipótese de que a complexidade do modelo deve ser prioritariamente alocada no instante atual, com redução progressiva da ordem polinomial para atrasos mais antigos.

#figure(
  image("Figuras/modelosdecrecenteatraso.png", width: 75%),
  caption: [Modelos com ordens polinomiais não crescentes ao longo dos atrasos no conjunto GaN HEMT.],
  source: [Autor],
) <fig:modelosdecrecenteatraso>

Esses resultados demonstram que modelos com menor quantidade total de coeficientes podem apresentar desempenho superior quando a complexidade é adequadamente distribuída entre os atrasos. Tal comportamento evidencia que não apenas a quantidade de coeficientes, mas principalmente a forma como estes são organizados estruturalmente no modelo MP, é determinante para a acurácia obtida.

A análise da fronteira de Pareto, apresentada na @fig:fronteiradepareto, evidencia de forma clara o compromisso existente entre a complexidade estrutural do modelo e o desempenho obtido. Os modelos pertencentes à fronteira representam soluções eficientes, uma vez que não é possível melhorar o NMSE sem um aumento correspondente no número de coeficientes, ou reduzir a complexidade sem perda de desempenho.

Observa-se que os modelos localizados na fronteira de Pareto apresentam, em sua maioria, distribuições de ordem polinomial concentradas no instante atual, com redução progressiva das ordens associadas aos atrasos mais antigos. Tal comportamento reforça os resultados apresentados anteriormente, indicando que a não linearidade dominante do sistema está majoritariamente associada ao instante atual, enquanto os efeitos de memória contribuem de forma menos significativa e saturam com ordens polinomiais reduzidas.

#figure(
  image("Figuras/fronteiradepareto.png", width: 75%),
  caption: [Fronteira de Pareto para os modelos MP com ordem dependente do atraso no conjunto GaN HEMT.],
  source: [Autor],
) <fig:fronteiradepareto>

== Generalização em múltiplos conjuntos de dados empíricos

Para avaliar a robustez da metodologia proposta, o mesmo procedimento de identificação e avaliação foi aplicado aos dois conjuntos de dados descritos na @sec:metodologia-validacao, correspondentes aos PAs GaN HEMT e LDMOS. Diferentemente dos gráficos da seção anterior, que mostram apenas o GaN HEMT, as tabelas desta seção incluem explicitamente os resultados de ambos os conjuntos. Em ambos, foram testadas as 125 combinações possíveis de quantidades de funções de base de ordem ímpar $(P_0, P_1, P_2)$ com $M = 2$, mantendo o mesmo _pipeline_ de treinamento e validação.

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
  caption: [Desempenho de configurações representativas de quantidades de funções de base por ramo nos conjuntos GaN HEMT e LDMOS.],
  source: [Autor],
  table(
    columns: (auto, auto, auto, auto),
    align: center,
    table.header(
      [*Termos por ramo $(P_0, P_1, P_2)$*],
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

A @fig:fig_python_amam_ampm apresenta a característica AM-AM do conjunto LDMOS na avaliação em Python com vírgula fixa. A curva “Medido” corresponde à saída medida do PA; “Modelo PA Calculado” representa a saída estimada pelo modelo direto; e “Modelo DPD” representa a característica do pré-distorcedor. A expansão de amplitude do DPD é consistente com a compensação da compressão do PA, mas sua curva isolada não representa a saída linearizada da cascata. A referência em Python é utilizada na comparação com a simulação da implementação em VHDL.

#figure(
  image("Figuras/fig_python_amam_ampm.png", width: 75%),
  caption: [Característica AM-AM do conjunto LDMOS em Python: saída medida do PA, modelo direto do PA e modelo do DPD em vírgula fixa.],
  source: [Autor],
) <fig:fig_python_amam_ampm>

=== Validação da implementação em VHDL

A @fig:fig_vhdl_vs_python apresenta, para o conjunto LDMOS, as curvas dos modelos PA e DPD calculados em Python e os pontos identificados na imagem como “Sintesi-lógica”. O procedimento registrado no notebook de comparação carrega o vetor `simulation_sintese.txt`, cuja cópia em `OUTPUT` é idêntica à preservada em `questa_sim`. O testbench dessa pasta grava um arquivo com o mesmo nome, e o registro de execução documenta simulação de netlist pós-roteamento com SDF em Questa, conforme a @sec:metodologia-validacao. Assim, o rótulo “Sintesi-lógica” da imagem não deve ser interpretado como uma simulação RTL nem como uma simulação independente apenas pós-síntese. A sobreposição com o modelo DPD indica concordância visual para o vetor comparado. A validação temporal com SDF foi realizada para ambas as configurações, conforme o procedimento descrito na @sec:metodologia-validacao.

A análise do RTL descrito na @sec:arquitetura-hardware-proposta estabelece latência de dez períodos entre captura e saída e intervalo de iniciação de um ciclo, conforme a @fig:pipeline-dpd-clock. Essa análise e a comparação funcional da @fig:fig_vhdl_vs_python são distintas dos resultados de implementação física apresentados na @sec:resultados-fpga.

#figure(
  image("Figuras/fig_vhdl_vs_python.png", width: 75%),
  caption: [Característica AM-AM do conjunto LDMOS: modelos PA e DPD em Python e saída de simulação identificada na imagem como “Sintesi-lógica”.],
  source: [Autor],
) <fig:fig_vhdl_vs_python>

=== Comparação de complexidade estrutural na síntese genérica

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

Essa análise confirma que a redução da ordem polinomial nos atrasos mais antigos, quando acompanhada de reorganização estrutural do circuito, produz ganhos reais de implementação. Dessa forma, os resultados em VHDL reforçam a viabilidade do modelo MP com ordem dependente do atraso para aplicações digitais com restrições de recursos lógicos. Essas contagens de síntese genérica não devem ser equiparadas aos recursos físicos específicos da FPGA, discutidos a seguir.

=== Resultados de implementação em FPGA <sec:resultados-fpga>

A @tab:comparacao-fpga-dpd compara a ocupação de recursos das implementações do modelo padrão, com configuração $[5,5,5]$ e 15 coeficientes complexos, e do modelo reduzido, com configuração $[5,3,1]$ e nove coeficientes complexos. Ambas utilizam a FPGA Xilinx Artix-7 `xc7a100t-csg324-2` e o Xilinx ISE 14.7. As contagens de recursos correspondem à implementação após posicionamento e roteamento (_place & route_), e não às estimativas anteriores ao roteamento.

Os percentuais entre parênteses indicam a ocupação em relação aos recursos disponíveis no dispositivo: 63.400 Slice LUTs, 126.800 posições de Slice Registers, 15.850 slices e 240 DSP48E1. O total de Slice Registers inclui posições empregadas como lógica AND/OR e, portanto, difere da quantidade de flip-flops efetivos. No modelo padrão, são 1.642 flip-flops e 294 posições usadas como lógica AND/OR, totalizando 1.936 posições; no modelo reduzido, são 874 flip-flops e 178 posições AND/OR, totalizando 1.052. Nenhuma das execuções utilizou BRAM; ambas empregaram 46 IOBs e um BUFG.

#figure(
  kind: table,
  caption: [Comparação dos modelos padrão e reduzido após posicionamento e roteamento na FPGA Artix-7 XC7A100T-CSG324.],
  source: [Autor],
  table(
    columns: (46%, 27%, 27%),
    align: (left, center, center),
    inset: 5pt,
    table.header([*Métrica*], [*Modelo padrão*], [*Modelo reduzido*]),
    [Slice LUTs totais], [3.163 (4,99%)], [1.822 (2,87%)],
    [Slice Registers — posições utilizadas], [1.936 (1,53%)], [1.052 (0,83%)],
    [Flip-flops efetivos], [1.642], [874],
    [Slices ocupados], [1.198 (7,56%)], [668 (4,21%)],
    [DSP48E1], [67 (27,92%)], [44 (18,33%)],
  ),
) <tab:comparacao-fpga-dpd>

Tomando o modelo padrão como referência, o modelo reduzido apresenta redução de 40,00% no número de coeficientes complexos, 42,40% nas Slice LUTs, 45,66% nas posições de Slice Registers, 46,77% nos flip-flops efetivos, 44,24% nos slices ocupados e 34,33% nos DSP48E1. As reduções foram calculadas pela diferença entre as contagens das duas implementações, dividida pela contagem do modelo padrão. A diminuição observada abrange tanto a lógica programável quanto os recursos aritméticos dedicados e de armazenamento sequencial. Entretanto, não se atribui toda essa diferença exclusivamente ao número de coeficientes: a organização da arquitetura, as otimizações de síntese, o mapeamento e as decisões de posicionamento e roteamento também influenciam os resultados, obtidos em execuções distintas.

Ambos os modelos foram testados no fluxo de implementação do Xilinx ISE 14.7 com frequência-alvo de operação de 100~MHz. Os relatórios pós-roteamento indicam que essa restrição não foi atendida na execução do modelo padrão, enquanto o relatório consolidado da execução do modelo reduzido registra seu atendimento. Portanto, a frequência-alvo não deve ser confundida com uma frequência de operação validada para ambos os modelos. Nas execuções comparadas, o modelo reduzido apresentou menor ocupação de recursos, evidenciando a redução da complexidade de implementação nas condições dos testes. Não há resultados de potência elétrica que permitam quantificar economia de energia, e a redução de recursos não substitui uma análise de potência. Tampouco se apresentam frequência ou funcionamento como medições em placa, nem se deduzem taxa de amostragem, vazão ou latência apenas da frequência de relógio.

== Avaliação do sistema DPD + PA com arquitetura ILA

Além da modelagem direta do amplificador, foi avaliada a aplicação do modelo MP em um sistema de pré-distorção digital baseado na arquitetura ILA. Nessa configuração, o DPD foi treinado como o inverso do PA a partir do conjunto LDMOS, e posteriormente aplicado em cascata com o modelo do amplificador, formando a estrutura completa DPD + PA.

O cálculo inicial do ganho global de entrada, baseado na razão entre as amplitudes máximas de saída e entrada do conjunto de extração, resultou em aproximadamente 0,83. A partir desse valor, foram avaliados manualmente outros ajustes de ganho. Por inspeção visual, observou-se que a resposta da cascata mantinha uma relação aproximadamente linear entre entrada e saída, com ganho aproximadamente constante, até o ajuste de 0,95. Para valores superiores a 0,95, observou-se perda dessa característica. Esse procedimento motivou a escolha de 0,95 para ampliar a faixa de amplitudes utilizada, preservando a linearidade observada visualmente no cenário avaliado. Trata-se de um ajuste empírico, sem determinação quantitativa de um ganho ótimo ou de um limite geral de operação.

#figure(
  image("Figuras/ILA-AM-AM.png", width: 75%),
  caption: [Características AM-AM no conjunto LDMOS: PA medido, PA estimado pelo modelo direto, DPD estimado pelo modelo inverso e cascata simulada DPD + PA com ganho de entrada 0,95.],
  source: [Autor],
) <fig:am-am-dpd-pa>

#figure(
  image("Figuras/ILA-AM-PM.png", width: 75%),
  caption: [Características AM-PM do sistema DPD + PA. Observa-se redução da distorção de fase dependente da amplitude após a aplicação do DPD.],
  source: [Autor],
) <fig:am-pm-dpd-pa>

Na @fig:am-am-dpd-pa, “PA medido” representa os dados experimentais de validação LDMOS; “PA estimado” é a saída do modelo direto do amplificador para a entrada de validação; “DPD estimado” é a saída do modelo inverso avaliado sobre a saída estimada do PA, usada na verificação da aprendizagem indireta. A curva “Cascata DPD + PA” representa a sequência direta aplicada à entrada escalada pelo ganho de 0,95: primeiro o DPD e, depois, o modelo do PA. Portanto, essa última curva é um resultado de simulação da cascata, e não uma nova medição do amplificador com DPD em bancada. Observa-se uma resposta mais próxima de uma relação linear que a do PA isolado. A @fig:am-pm-dpd-pa mostra a resposta de fase: após a aplicação do DPD, a dispersão da fase em função da amplitude diminui, indicando compensação das distorções AM-PM.

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

Adicionalmente, a implementação em VHDL das versões original e truncada do modelo apresentou equivalência funcional com a referência em Python no cenário avaliado em vírgula fixa. A síntese genérica indicou reduções próximas de 40% em métricas estruturais como número de `wires`, células e registradores. Na implementação física com Xilinx ISE 14.7 para a Artix-7 XC7A100T-CSG324, o modelo reduzido apresentou menor ocupação de recursos do que o modelo padrão, com reduções de 42,40% nas Slice LUTs e 34,33% nos DSP48E1. Ambos os modelos foram testados no fluxo de implementação com frequência-alvo de operação de 100~MHz. Esses resultados se restringem às execuções realizadas, sem constituir medições em placa ou comprovação de economia de energia.

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
