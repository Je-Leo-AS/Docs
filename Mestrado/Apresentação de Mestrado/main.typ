#import "@preview/touying-simpl-swufe:0.2.0": *

#show: swufe-theme.with(
  aspect-ratio: "16-9",
  lang: "pt",

  config-info(
    title: [Modelagem Comportamental de Amplificadores de Potência],
    subtitle: [Usando Polinômios com Memória e Ordens Dependentes do Atraso],
    short-title: [Modelagem Comportamental de Amplificadores de Potência],
    authors: [Leonardo de Andrade Santos, Eduardo Gonçalves de Lima, Sibilla Batista da Luz Franca],
    author: [Leonardo de Andrade Santos],
    date: str(datetime.today().year()),
    institution: [Universidade Federal do Paraná],
    banner: image("figuras/ufpr.png"),
  ),

  config-colors(
    primary: rgb(1, 83, 139),
    primary-dark: rgb(0, 42, 70),
    secondary: rgb(255, 255, 255),
    neutral-lightest: rgb(255, 255, 255),
    neutral-darkest: rgb(0, 0, 0),
  ),
)

// Regras locais dos slides: marcadores na linha de base e recuos uniformes.
// A capa e os slides de abertura de seção mantêm o layout do tema.
#let theme-slide = slide
#let slide(..args) = theme-slide(
  setting: body => {
    set align(left + top)
    set par(justify: false, leading: 0.35em)
    set list(
      marker: text(fill: rgb(1, 83, 139))[•],
      indent: 0em,
      body-indent: 0.85em,
      tight: false,
      spacing: 0.45em,
    )
    set enum(indent: 0em, body-indent: 0.55em, tight: false, spacing: 0.45em)
    set grid(align: top)
    block(width: 100%, inset: (top: 0.9em, bottom: 0.3em), body)
  },
  ..args,
)

#title-slide()

= Introdução

#slide(title: "Contextualização e Motivação")[
  #set text(size: 0.88em, weight: 400)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5em,
    [
      *Exigências dos sistemas sem fio*

      - Altas taxas de dados em largura de banda limitada
      - Modulações como OFDM e QAM elevada variam amplitude e fase simultaneamente
      - Essas modulações são sensíveis às não-linearidades do amplificador de potência RF (*PA*)
    ],
    [
      *Eficiência e distorção do PA*

      - Principal consumidor de energia do transmissor
      - Maior eficiência próxima da saturação, com forte distorção não-linear e efeitos de memória
      - Consequências: regrowth espectral e piora de EVM (Error Vector Magnitude), ACLR (Adjacent Channel Leakage Ratio) e BER (Bit Error Rate)
    ],
  )
  #v(0.7em)
  #block(width: 100%, inset: 0.7em, radius: 0.3em, fill: rgb(238, 245, 250))[
    *Solução: Pré-Distorção Digital (DPD)* em banda-base para compensar a não-linearidade do PA.

    Sua eficácia depende de um modelo preciso, de baixa complexidade e viável em hardware.
  ]
]

#slide(title: "Objetivos")[
  #set text(size: 0.92em)
  *Objetivo Geral* \
  Investigar e validar, em software e hardware, o modelo Memory Polynomial (MP) com ordens dependentes do atraso, avaliando o compromisso entre precisão e complexidade de implementação.

  #v(0.8em)
  *Objetivos Específicos*
  + Implementar o MP clássico e a variação com ordens dependentes do atraso em Python
  + Avaliar o NMSE e a complexidade, utilizando a fronteira de Pareto
  + Comparar o desempenho nos conjuntos GaN HEMT e LDMOS
  + Implementar e validar funcionalmente as arquiteturas em VHDL com aritmética em vírgula fixa
  + Comparar a síntese genérica e os recursos utilizados em FPGA
]
= Fundamentação Teórica
#slide(title: "Fundamentação Teórica")[
  #set text(size: 0.94em)
  *Sistema de Comunicação Sem Fio*

  - Sistemas modernos sem fio: transmissor → meio de propagação → receptor
  - Foco exclusivo deste trabalho: subsistema transmissor
  - Bloco crítico: Amplificador de Potência em RF (PA / PARF)
    - Maior consumidor de energia do transmissor
    - Converte energia CC (fonte) em potência RF irradiada pela antena
    - Eficiência global do transmissor depende diretamente do PA

  #v(0.6em)

  #figure(
    image("figuras/sistematrasmissorpng.png", width: 70%),
    caption: [
      Sistema de transmissão simplificado \
      #v(0.2em)
    ],
  ) <fig:sistematrasmissorpng>
]
#slide(title: "Distorção Espectral e Restrições Normativas")[
  #set text(size: 0.94em)
  #v(0.6em)
  - Sistemas sem fio sujeitos a restrições normativas rigorosas de emissão espectral
  - Máscara espectral limita potência máxima em bandas adjacentes (ex.: ACLR, SEM)
  - Não-linearidade do PA gera produtos de intermodulação (IMD) e regrowth espectral
  - Operação em regiões de alta eficiência → intensificação das distorções fora da banda
  - Consequência: risco de interferência em canais vizinhos e não conformidade regulatória

  #figure(
    image("figuras/distorcao_espectral_pa.svg", width: 95%, height: 37%, fit: "contain"),
    caption: [
      Exemplo de distorção espectral de um PA \
      #v(0.2em)

    ],
  ) <fig:distorcao-espectral-pa>
]

#slide(title: "Distorções em Amplificadores de Potência")[
  #set text(size: 0.92em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,

    [
      - PA apresenta comportamento não linear em altos níveis de potência (compressão e saturação)
      - Linearidade avaliada principalmente pelo ponto de compressão de 1 dB (P1dB)
      - Componentes reativos no circuito (bias, matching) introduzem efeitos de memória
      - Efeitos de memória degradam significativamente sinais de larga banda (ex.: OFDM, 5G)
      - Resultado: distorções AM/AM, AM/PM e regrowth espectral
    ],

    [
      #figure(
        image("figuras/curva_transferencia_pa.svg", width: 100%),
        caption: [
          Curva de transferência de um PARF \
          #v(0.2em)
        ],
      ) <fig:curva-transferencia-pa>
    ],
  )
]

#slide(title: "Pré-Distorção Digital (DPD)")[
  #set text(size: 0.92em)

  // Imagem extensa em cima, ocupando boa parte superior do slide
  #figure(
    image("figuras/DPDcascata.png", width: 50%),
    caption: [
      Esquema de pré-distorção digital (DPD) em cascata com o amplificador de potência \
      #v(0.2em)
    ],
  ) <fig:dpdcascata>

  #v(0.8em)  // espaço entre imagem e texto

  - DPD aplica distorção controlada no sinal em banda-base (digital)
  - Função de transferência do DPD ≈ inversa da não-linearidade do PA
  - Resultado: conjunto DPD + PA apresenta comportamento quase linear
  - Permite operação do PA em região de alta eficiência sem violação de máscaras espectrais
  - Bom compromisso entre desempenho (linearidade, EVM, ACLR) e custo de implementação
]

#slide(title: "Modelagem Comportamental")[
  #set text(size: 0.750em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Modelagem baseada exclusivamente na relação observável entre entrada e saída do PA
      - Não requer conhecimento da topologia interna ou parâmetros físicos do dispositivo
      - Capaz de representar não-linearidades (AM/AM, AM/PM) e efeitos de memória (dispersão térmica, bias, matching)
      - Ampla adoção em sistemas de pré-distorção digital (DPD) industriais e acadêmicos

      #v(1.2em)

      Principais vantagens:
      - Facilidade de extração de parâmetros a partir de medições
      - Boa generalização para sinais reais (larga banda, alta PAR)
      - Implementação eficiente em hardware digital (FPGA/ASIC)
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/modelagem_comportamental.svg", width: 100%),
          caption: [Diagrama genérico de modelagem comportamental],
        ) <fig:modelagem-comportamental>
      ]
    ],
  )
]

#slide(title: "Séries de Volterra")[
  #set text(size: 0.92em)
  #grid(
    columns: (3fr, 2fr),
    gutter: 1.5em,

    [
      - Extensão da série de Taylor para sistemas não lineares dinâmicos
      - Modela não-linearidades e efeitos de memória de forma geral
      - Alta capacidade de aproximação teórica
      - Principal desvantagem: elevada complexidade computacional (número de termos cresce exponencialmente)
    ],

    [
      #align(center + horizon)[
        #block(
          fill: rgb(245, 245, 245),
          inset: 1.2em,
          radius: 0.6em,
          width: 100%,
        )[
          #set math.equation(numbering: none)
          #math.equation(block: true)[
            #text(
              size: 0.55em,
            )[$y(n) = sum_(k=1)^K sum_(m_1=0)^(M-1) ... sum_(m_k=0)^(M-1) h_k(m_1, ..., m_k) product_(i=1)^k x(n - m_i)$]
          ]
          #v(0.4em)
          #text(size: 0.88em)[Equação 2.2 – Série de Volterra discreta]
        ]
      ]
    ],
  )
]
#slide(title: "Polinômio com Memória")[
  #set text(size: 0.92em)
  #grid(
    columns: (3fr, 2fr),
    gutter: 1.5em,

    [
      - Simplificação da série de Volterra
      - Considera apenas os termos diagonais (mesmo atraso em todas as multiplicações)
      - Modelo compacto e linear nos coeficientes (fácil identificação)
      - Amplamente utilizado em sistemas de pré-distorção digital (DPD)
    ],

    [
      #align(center + horizon)[
        #block(
          fill: rgb(245, 245, 245),
          inset: 1.2em,
          radius: 0.6em,
          width: 100%,
        )[
          #set math.equation(numbering: none)
          #text(size: 0.70em)[$ y(n) = sum_(m=0)^M sum_(p=1)^P h_(p,m) x(n-m) |x(n-m)|^(p-1) $]
          #v(0.5em)
          #text(size: 0.88em)[Modelo Memory Polynomial (MP)]
        ]
      ]
    ],
  )
]

#slide(title: "Métrica de Desempenho: NMSE")[
  #set text(size: 0.92em)
  #grid(
    columns: (3fr, 2fr),
    gutter: 1.5em,
    [
      - $e(n) = y_"real" (n) - y_"model" (n)$
      - $y_"real" (n)$: saída medida do PA real
      - $y_"model" (n)$: saída calculada do modelo MP
      - N: número total de amostras
      - Quanto menor o NMSE (mais negativo em dB), melhor a precisão
      - Avaliação em conjunto de validação separado do treinamento (evita sobreajuste)
    ],
    [
      #align(center + horizon)[
        #block(
          fill: rgb(245, 245, 245),
          inset: 1.2em,
          radius: 0.6em,
          width: 100%,
        )[
          #set math.equation(numbering: none)
          #math.equation(block: true)[
            $ "NMSE" = 10 log_(10) (frac(sum_(n=1)^N |e(n)|^2, sum_(n=1)^N |y_"real"(n)|^2)) $
          ]
          #v(0.4em)
          #text(size: 0.88em)[Equação (4.1) – Normalized Mean Square Error]
        ]
      ]
    ],
  )
]

= Modelo MP Proposto

#slide(title: "Motivação Experimental")[
  #set text(size: 0.92em)
  #block(width: 100%, inset: 0.8em, radius: 0.3em, fill: rgb(238, 245, 250))[
    *A mesma ordem é necessária em todos os atrasos?*
  ]
  #v(0.6em)
  - No MP clássico, todos os ramos utilizam a mesma ordem máxima
  - Essa escolha atribui a mesma quantidade de termos à amostra atual e às anteriores
  - Investigação no conjunto LDMOS: os termos de maior ordem têm a mesma importância em cada ramo?

  #v(0.5em)
  *Três análises complementares*
  + Magnitude dos coeficientes
  + Sensibilidade do NMSE à ordem de cada ramo
  + Espectro do erro residual
]

// Três análises complementares do relatório M5, no conjunto LDMOS.
#slide(title: "Evidência 1 — Magnitude dos Coeficientes")[
  #set text(size: 0.82em)
  - LDMOS: 4.500 amostras de extração e 4.500 de validação; $M = 2$
  - Modelo completo: $P_0 = P_1 = P_2 = 5$; energia por ramo $E_m = sum_(p=1)^5 |h_(p,m)|^2$
  #align(center)[#figure(image("figuras/ev1_magnitude_coeficientes.png", width: 90%, height: 43%, fit: "contain"), caption: text(size: 0.65em)[Magnitude dos coeficientes por ramo de memória]) <fig:ev1-magnitude-coeficientes>]
  Energia por ramo: *20,5751 → 13,7146 → 4,8489* para $m = 0, 1, 2$.
]

#slide(title: "Evidência 2 — Sensibilidade do NMSE")[
  #set text(size: 0.82em)
  - Variação de uma ordem $P_m$ de 1 a 5, mantendo as outras duas em 1
  - Referência comum: $P_0 = P_1 = P_2 = 1$; NMSE de −28,71 dB
  #align(center)[#figure(image("figuras/ev2_sensibilidade_nmse.png", width: 90%, height: 50%, fit: "contain"), caption: text(size: 0.65em)[Sensibilidade do NMSE à ordem de cada ramo]) <fig:ev2-sensibilidade-nmse>]
  Ganhos: *6,66 dB* em $P_0$; *3,43 dB* em $P_1$; *1,49 dB* em $P_2$.
]

#slide(title: "Evidência 3 — Espectro do Erro Residual")[
  #set text(size: 0.82em)
  - Erro no conjunto de validação; janela de Blackman e FFT de 8192 pontos
  - Entrada, saída medida e erros de modelos selecionados; referência $[1,1,1]$
  #align(center)[#figure(image("figuras/ev3_espectro_erro.png", width: 95%, height: 50%, fit: "contain"), caption: text(size: 0.65em)[Espectro do erro residual para variações de cada ramo]) <fig:ev3-espectro-erro>]
  Maior redução espectral ao aumentar $P_0$, na banda e nas adjacências.
  Hipótese: preservar alta ordem em $m=0$ e reduzir termos nos atrasos.
]

#slide(title: "Alternativa Proposta: MP com Ordem Variável")[
  #set text(size: 0.80em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.3em,
    [
      - MP clássico: mesma ordem polinomial em todos os atrasos
      - Evidências motivam definir uma ordem $P_m$ para cada atraso $m$
      - $bold(P) = [P_0, P_1, dots, P_M]$, com $P_m in {1, 2, dots, P_"max"} subset ZZ_(>0)$
      - Hipótese: concentrar a complexidade no instante atual
      - Reduzir termos de alta ordem nos atrasos mais antigos
      - Avaliar a precisão pelo NMSE e a complexidade pelo número de coeficientes
      #v(0.6em)
      $ y(n) = sum_(m=0)^M sum_(p=1)^(P_m) h_(p,m) x(n-m) |x(n-m)|^(p-1) $
    ],
    [#figure(
      image("figuras/mp_padrao.svg", width: 100%),
      caption: [Estrutura do MP clássico: ordem uniforme nos ramos],
    ) <fig:mp-padrao>],
  )
]

#slide(title: "Arquitetura Implementada em VHDL")[
  #set text(size: 0.88em)
  - Implementação em VHDL com funções de base de ordem ímpar
  - $P_m$: quantidade de termos ímpares mantidos em cada ramo
  - Modelo padrão: $bold(P)=(5,5,5)$ → 15 coeficientes complexos
  - Modelo reduzido: $bold(P)=(5,3,1)$ → 9 coeficientes complexos

  #v(0.5em)
  $ y(n) = sum_(m=0)^2 sum_(q=0)^(P_m-1) c_(m,q) x(n-m)|x(n-m)|^(2q) $

  #v(0.5em)
  #table(
    columns: (1fr, 2fr),
    inset: 7pt,
    align: center,
    table.header([*Ramo*], [*Ordens ímpares no modelo reduzido*]),
    [$m=0$], [1, 3, 5, 7 e 9],
    [$m=1$], [1, 3 e 5],
    [$m=2$], [1],
  )
  #v(0.4em)
  Redução de 40% no número de coeficientes complexos.
]
= Resultados
#slide(title: "Resultados – Visão Geral")[
  #set text(size: 0.92em)
  - Modelagem em Python e validação em dados distintos dos usados na identificação
  - GaN HEMT: PA classe AB, portadora de 900 MHz, WCDMA de 3,84 MHz e amostragem de 61,44 MHz
  - LDMOS: 4.500 amostras complexas para extração e 4.500 para validação
  - 125 combinações de ordens por conjunto, com $M=2$ e $P_m in {1,2,3,4,5}$
  - Avaliação do compromisso entre precisão e complexidade nas 125 combinações
  - Validação funcional em VHDL, síntese genérica e implementação em FPGA
  - Avaliação da cascata DPD + PA com arquitetura ILA
]

#slide(title: "Modelagem do PA com MP Original")[
  #set text(size: 0.90em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Implementação em Python (ponto flutuante) → alta precisão numérica
      - Objetivo: estabelecer baseline de desempenho
      - Identificação: mínimos quadrados sobre erro de modelagem
      - Validação em dados independentes (evita sobreajuste)

      #v(1.2em)

      Resultado LDMOS: *NMSE = −37,51 dB*

      MP padrão: $P=5$, $M=2$ e 15 coeficientes complexos
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/modelopafloat.png", width: 100%),
          caption: [AM–AM medida e estimada para o PA LDMOS],
        ) <fig:modelopafloat>
      ]
    ],
  )
]

#slide(title: "MP com Ordem Dependente do Atraso")[
  #set text(size: 0.90em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Profundidade de memória M = 2
      - Ordens: P₀, P₁, P₂ variando de 1 a 5 → 125 combinações
      - Treinamento em ponto flutuante
      - Métricas avaliadas: NMSE e número total de coeficientes

      #v(1.2em)

      - Aumento do número de coeficientes melhora NMSE
      - Mas não é o único fator determinante
      - Distribuição das ordens entre os atrasos é crítica para o desempenho
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/desempenho125modelos.png", width: 100%),
          caption: [Desempenho dos 125 modelos MP com ordem dependente do atraso],
        ) <fig:desempenho125modelos>
      ]
    ],
  )
]
#slide(title: "Influência da Ordem Polinomial por Atraso")[
  #set text(size: 0.88em)

  - P₀ (m=0): forte redução de NMSE com aumento da ordem
  - P₁ (m=1): impacto moderado
  - P₂ (m=2): impacto muito limitado

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    [#figure(image("figuras/influenciap0.png", width: 100%), caption: [P₀]) <fig:influenciap0>],
    [#figure(image("figuras/influenciap1.png", width: 100%), caption: [P₁]) <fig:influenciap1>],
    [#figure(image("figuras/influenciap2.png", width: 100%), caption: [P₂]) <fig:influenciap2>],
  )

  Não-linearidade dominante concentrada no instante atual
]

#slide(title: "NMSE em Função da Complexidade")[
  #set text(size: 0.88em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    [#figure(image("figuras/nmsecomplexp0.png", width: 100%), caption: [Destacando P₀]) <fig:nmsecomplexp0>],
    [#figure(image("figuras/nmsecomplexp1.png", width: 100%), caption: [Destacando P₁]) <fig:nmsecomplexp1>],
    [#figure(image("figuras/nmsecomplexp2.png", width: 100%), caption: [Destacando P₂]) <fig:nmsecomplexp2>],
  )

  #v(0.6em)

  Ordem P₀ é o principal driver de ganho de precisão
  Aumento em atrasos antigos traz ganhos marginais
]

#slide(title: "Modelos com P₀ ≥ P₁ ≥ P₂")[
  #set text(size: 0.92em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Modelos com ordens polinomiais *decrescentes* ao longo dos atrasos
        (P₀ ≥ P₁ ≥ P₂)
      - Maioria dos modelos com *melhor desempenho* pertence a esse grupo
      - Indica que a complexidade deve ser *priorizada no instante atual* (m = 0)
      - Redução progressiva da ordem nos atrasos mais antigos traz pouco prejuízo
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/modelosdecrecenteatraso.png", width: 100%),
          caption: [Modelos com ordens polinomiais decrescentes ao longo dos atrasos],
        ) <fig:modelosdecrecenteatraso>
      ]
    ],
  )
]
#slide(title: "Fronteira de Pareto")[
  #set text(size: 0.92em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Trade-off entre precisão (NMSE) e complexidade (número de coeficientes)
      - Modelos na fronteira: soluções mais eficientes (melhor NMSE com menor complexidade possível)
      - Distribuição típica dos melhores modelos: alta ordem em m=0 + redução rápida em m ≥ 1
      - Confirma que a *não-linearidade dominante* está concentrada no instante atual
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/fronteiradepareto.png", width: 100%),
          caption: [Fronteira de Pareto para os modelos MP com ordem dependente do atraso],
        ) <fig:fronteiradepareto>
      ]
    ],
  )
]


#slide(title: "Resultados em GaN HEMT e LDMOS")[
  #set text(size: 0.88em)
  125 modelos avaliados por conjunto; NMSE no conjunto de validação.
  #v(0.7em)
  #table(
    columns: (1.2fr, 0.7fr, 1fr, 1fr),
    inset: 8pt,
    align: center,
    table.header([*Ordens*], [*Coef.*], [*GaN (dB)*], [*LDMOS (dB)*]),
    [#text("[3,2,1]")], [6], [−25,53], [−34,75],
    [#text("[4,3,2]")], [9], [−25,64], [−36,31],
    [#text("[5,3,2]")], [10], [−25,49], [−37,00],
    [#text("[5,4,3]")], [12], [−26,07], [−37,44],
    [#text("[5,5,5]")], [15], [−26,10], [−37,51],
  )
  #v(0.6em)
  Os dois conjuntos mantêm a predominância do ramo do instante atual.
]

#slide(title: "Pipeline da Implementação VHDL")[
  #set text(size: 0.78em)
  #align(center)[#figure(image("figuras/pipeline_dpd_por_clock.svg", width: 95%, height: 62%, fit: "contain"), caption: text(size: 0.65em)[Pipeline da arquitetura em VHDL por ciclo de clock]) <fig:pipeline-dpd-por-clock>]
  - Captura em $C_1$ e saída registrada em $C_11$: latência RTL de dez períodos
  - Intervalo de iniciação de um ciclo; após o preenchimento, uma amostra complexa por ciclo, se atendidas as restrições de temporização
]

#slide(title: "Validação Funcional: VHDL e Python")[
  #set text(size: 0.85em)
  - Simulação funcional com Xilinx e comparação com a referência em Python em vírgula fixa
  - Sobreposição dos resultados no cenário avaliado
  #align(center)[#figure(image("figuras/fig_vhdl_vs_python.png", width: 80%, height: 56%, fit: "contain"), caption: text(size: 0.65em)[Comparação funcional entre VHDL e Python em vírgula fixa]) <fig:fig-vhdl-vs-python>]
]

#slide(title: "Resultados de Síntese Genérica")[
  #set text(size: 0.86em)
  Síntese genérica com GHDL/Yosys: comparação das arquiteturas em VHDL.
  #v(0.8em)
  #table(
    columns: (1.4fr, 1fr, 1fr, 1fr),
    inset: 8pt,
    align: center,
    table.header([*Métrica*], [*Padrão*], [*Reduzido*], [*Redução*]),
    [Wires], [69.735], [41.022], [41,2%],
    [Wire bits], [72.087], [42.703], [40,8%],
    [Cells], [70.800], [41.497], [41,4%],
    [Flip-flops], [765], [484], [36,7%],
  )
  #v(0.8em)
  Redução próxima de 40% nas principais métricas estruturais.
]



#slide(title: "Resultados de Implementação em FPGA")[
  #set text(size: 0.80em)
  Artix-7 XC7A100T-CSG324; Xilinx ISE 14.7; frequência-alvo de 100 MHz.
  #v(0.6em)
  #table(
    columns: (1.6fr, 1fr, 1fr, 0.9fr),
    inset: 7pt,
    align: center,
    table.header([*Após place & route*], [*Padrão*], [*Reduzido*], [*Redução*]),
    [Slice LUTs], [3.163], [1.822], [42,40%],
    [Slice Registers (posições)], [1.936], [1.052], [45,66%],
    [Flip-flops efetivos], [1.642], [874], [46,77%],
    [Slices ocupados], [1.198], [668], [44,24%],
    [DSP48E1], [67], [44], [34,33%],
  )
  #v(0.5em)
  - Modelo padrão: 15 coeficientes; modelo reduzido: 9 coeficientes
  - Ambas as implementações: sem BRAM, 46 IOBs e um BUFG
]

#slide(title: "Linearização DPD + PA com ILA")[
  #set text(size: 0.82em)
  - DPD identificado como inverso do PA no conjunto LDMOS
  - Ganho de entrada de 0,95: melhor aproveitamento da faixa dinâmica em relação a aproximadamente 0,83
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [#figure(image("figuras/AM-AM.png", height: 48%, fit: "contain"), caption: [Resposta AM–AM]) <fig:am-am>],
    [#figure(image("figuras/AM-PM.png", height: 48%, fit: "contain"), caption: [Resposta AM–PM]) <fig:am-pm>],
  )
  A cascata apresenta resposta de amplitude mais linear e menor distorção de fase.
]

= Conclusão
#slide(title: "Conclusões")[
  #set text(size: 0.92em)
  - Ordens dependentes do atraso permitem concentrar a complexidade no instante atual
  - Tendência confirmada nos conjuntos GaN HEMT e LDMOS
  - Implementação em VHDL validada funcionalmente com a referência em Python
  - Redução de 40% no número de coeficientes complexos
  - Na FPGA: redução de 42,40% em Slice LUTs e 34,33% em DSP48E1
  - Linearização da cascata DPD + PA observada nas curvas AM–AM e AM–PM
]

= Próximas Etapas

#slide(title: "Próximas Etapas")[
  #set text(size: 0.92em)
  - Aplicar a metodologia a outros modelos comportamentais: GMP e série de Volterra
  - Comparar precisão, complexidade e recursos de hardware
  - Ampliar a validação em plataformas FPGA
  - Investigar diferentes precisões numéricas e arquiteturas de pipeline

  #v(1.5em)
  #align(center)[*Obrigado pela atenção!*]
]


#theme-slide(title: "Referências")[
  #set text(size: 0.65em)          // fonte menor para caber tudo
  #set par(leading: 0.45em)        // espaçamento entre linhas reduzido
  #set block(spacing: 0.6em)
  #v(0.6em)


  #block(inset: (top: 1em, bottom: 0.5em), breakable: true)[
    #columns(2, gutter: 1.2em)[
      #bibliography("Referencias.bib", full: true, style: "ieee")
    ]
  ]
]
