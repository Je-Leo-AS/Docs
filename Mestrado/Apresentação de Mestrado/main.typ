#import "@preview/touying-simpl-swufe:0.2.0": *

#show: swufe-theme.with(
  aspect-ratio: "16-9",
  lang: "pt",

  config-info(
    title: [Modelagem Comportamental de Amplificadores de Potência],
    subtitle: [Usando Truncamento Polinomial Dependente do Atraso],
    short-title: [Modelagem Comportamental de PA],
    authors: [Leonardo de Andrade Santos, Eduardo Gonçalves de Lima],
    author: [Leonardo de Andrade Santos],
    date: str(datetime.today().year()),
    institution: ([Universidade Federal do Paraná]),
    banner: image("figuras/ufpr.png")
  ),

  config-colors(
    primary: rgb(1, 83, 139),
    primary-dark: rgb(0, 42, 70),
    secondary: rgb(255, 255, 255),
    neutral-lightest: rgb(255, 255, 255),
    neutral-darkest: rgb(0, 0, 0),
  ),
)

#title-slide()

= Introdução

#slide(title: "Contextualização e Motivação")[
  #set text(size: 0.92em, weight: 400)
  #set par(leading: 0.55em)

  - Evolução dos sistemas de comunicação sem fio exige altas taxas de dados em largura de banda limitada
  - Modulações complexas (ex.: OFDM, QAM elevada) → variação simultânea de amplitude e fase
  - Essas modulações são altamente sensíveis às não-linearidades dos amplificadores de potência RF (*PA*)
  - PA é o principal consumidor de energia do transmissor
  - Máxima eficiência energética → operação próxima da saturação
  - Consequência: forte distorção não-linear + efeitos de memóri
  - Resultado: regrowth espectral, piora de EVM, ACLR e BER


  *Solução consolidada*:  
  Pré-Distorção Digital (DPD) em banda-base para compensar a não-linearidade do PA

  - Eficácia da DPD depende de modelo matemático preciso e de baixa complexidade
  - Necessidade: estruturas de modelagem que conciliem precisão, baixa complexidade e viabilidade em hardware
]

#slide(title: "Objetivos")[
  #set text(size: 0.95em)

  *Objetivo Geral*  
  Investigar, em software Python, estruturas alternativas do modelo Memory Polynomial (MP) para modelagem comportamental de amplificadores de potência (PA), com ênfase em ordens polinomiais dependentes do atraso e abordagens híbridas (MP + LUT), avaliando o compromisso entre precisão e complexidade computacional.

  #v(1em)

  *Objetivos Específicos*
  #set enum(tight: true, spacing: 0.7em)
  + Implementar o modelo Memory Polynomial clássico em Python
  + Desenvolver variação do MP com ordens polinomiais dependentes do atraso
  + Avaliar desempenho dos modelos via Normalized Mean Squared Error (NMSE)
  + Analisar trade-off complexidade × precisão utilizando fronteira de Pareto
  + Propor e comparar abordagem híbrida (polinômios nos ramos de memória + LUT no termo corrente)
]
= Fundamentação Teórica
#slide(title: "Fundamentação Teórica")[
  #set text(size: 0.94em)
  #set par(leading: 0.6em)

  == Sistema de Comunicação Sem Fio

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
    ]
  )
]
#slide(title: "Distorção Espectral e Restrições Normativas")[
    #set text(size: 0.94em)
    #set par(leading: 0.6em)
    #v(0.6em)
      - Sistemas sem fio sujeitos a restrições normativas rigorosas de emissão espectral
      - Máscara espectral limita potência máxima em bandas adjacentes (ex.: ACLR, SEM)
      - Não-linearidade do PA gera produtos de intermodulação (IMD) e regrowth espectral
      - Operação em regiões de alta eficiência → intensificação das distorções fora da banda
      - Consequência: risco de interferência em canais vizinhos e não conformidade regulatória

      #figure(
        image("figuras/normreg.png", width: 100%),
        caption: [
          Exemplo de máscara espectral e distorções adjacentes \
          #v(0.2em)

    ]
  )
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
        image("figuras/curvasaidaparf.png", width: 100%),
        caption: [
          Curva de transferência de um PARF \
          #v(0.2em)
        ]
      )
    ]
  )
]

#slide(title: "Pré-Distorção Digital (DPD)")[
  #set text(size: 0.92em)
  #set par(leading: 0.6em)

  // Imagem extensa em cima, ocupando boa parte superior do slide
  #figure(
    image("figuras/DPDcascata.png", width: 50%),
    caption: [
      Esquema de pré-distorção digital (DPD) em cascata com o amplificador de potência \
      #v(0.2em)
    ]
  )

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
          image("figuras/diagrama-modelagem-comportamental.png", width: 100%),
          caption: [Diagrama genérico de modelagem comportamental]
        )
      ]
    ]
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
            $y(n) = sum_(k=1)^K sum_(m_1=0)^(M-1) ... sum_(m_k=0)^(M-1) h_k(m_1, ..., m_k) product_(i=1)^k x(n - m_i)$
          ]
          #v(0.4em)
          #text(size: 0.88em)[Equação 2.2 – Série de Volterra discreta]
        ]
      ]
    ]
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
          $ y(n) = sum_(m=0)^(M-1) sum_(k=1)^K a_{k m} |x(n-m)|^(k-1) x(n-m) $
          #v(0.5em)
          #text(size: 0.88em)[Equação 2.3 – Modelo Memory Polynomial (MP)]
        ]
      ]
    ]
  )
]

#slide(title: "Alternativa Proposta: MP com Ordem Variável")[
  #set text(size: 0.7em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Formulação tradicional do MP: ordem polinomial máxima P uniforme para todos os atrasos
      - Essa restrição não é imposta pela série de Volterra → pode gerar complexidade desnecessária
      - Termos de atrasos mais elevados: efeitos não lineares geralmente menos pronunciados
      - Proposta: adotar ordens polinomiais diferenciadas em função do atraso de memória
        - Reduz complexidade computacional
        - Mantém capacidade de representação do PA

      #v(0.8em)

      - Para implementação em hardware (altas taxas de amostragem):
        - Exploração de arquiteturas paralelizáveis
        - Substituição de multiplicações por tabelas de consulta (LUTs) nos termos mais complexos
      - Abordagem híbrida: LUT no termo corrente (m=0) + polinômios nos termos de memória (m ≥ 1)
        - Maior eficiência em FPGA/ASIC
        - Menor consumo de recursos e latência
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/diagrama-blocos-MP.png", width: 100%),  // substitua pelo nome real da Figura 7 da sua tese
          caption: [Diagrama de blocos do modelo Memory Polynomial (MP) clássico (Figura 7)]
        )
      ]
      
    ]
  )
]

#slide(title: "Abordagem Híbrida: Polinômios + Tabelas de Consulta (LUTs)")[
  #set text(size: 0.75em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Termo corrente (m = 0) concentra a maior parte da complexidade não linear
      - Substituição por LUT (Look-Up Table) no termo atual:
        - Alta precisão com alta ordem polinomial
        - Elimina multiplicações pesadas
        - Acesso rápido em hardware (FPGA/ASIC)
      - Ramos de memória (m ≥ 1): mantidos como polinômios de baixa ordem
        - Reduz número de coeficientes e operações
        - Menor impacto na precisão total

      Vantagens da abordagem híbrida:
      - Menor consumo de recursos lógicos (multiplicadores)
      - Menor latência e maior paralelismo
      - Bom trade-off precisão × complexidade computacional
      - Viável para implementação em alta taxa de amostragem
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/mp_lut.png", width: 100%),  // Figura 8 da tese
          caption: [Implementação do modelo MP utilizando LUTs (Figura 8)]
        )
      ]
    ]
  )
]
// Slide 1 – Introdução ao Capítulo de Resultados
= Resultados
#slide(title: "Resultados – Visão Geral")[
  #set text(size: 0.82em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,

    [
      - Validação inicial das estruturas propostas na Seção 3.2
      - Foco principal: modelo Memory Polynomial (MP) clássico em ponto flutuante
      - Resultados preliminares → baseline para comparação futura
      - Modelos com ordem dependente do atraso e híbrido (MP + LUT) ainda em implementação
      - Métrica principal: Normalized Mean Square Error (NMSE) – Eq. (4.1)
      - Dados: medições reais de PA classe AB GaN HEMT a 900 MHz com WCDMA (3,84 MHz)
      - Aquisição: analisador vetorial de sinais (VSA) Rohde & Schwarz @ 61,44 MSps
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/analisador.jpeg", width: 70%),
          caption: [Analisador vetorial de sinais (VSA)]
        )
      ]
    ]
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
    ]
  )
]
// Slide 3 – Modelagem com MP Original
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

      Resultado: NMSE = −26,7 dB  
      Boa capacidade de representação do PA real em banda larga
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/modelopafloat.png", width: 100%),
          caption: [Modelo do PA com MP Original]
        )
      ]
    ]
  )
]

// Slide 4 – MP com Ordem Dependente do Atraso
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
          caption: [Desempenho dos 125 modelos MP com ordem dependente do atraso]
        )
      ]
    ]
  )
]
// Slide 5 – Influência Individual das Ordens
#slide(title: "Influência da Ordem Polinomial por Atraso")[
  #set text(size: 0.88em)

  - P₀ (m=0): forte redução de NMSE com aumento da ordem
  - P₁ (m=1): impacto moderado
  - P₂ (m=2): impacto muito limitado

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    figure(image("figuras/influenciap0.png", width: 100%), caption: [P₀]),
    figure(image("figuras/influenciap1.png", width: 100%), caption: [P₁]),
    figure(image("figuras/influenciap2.png", width: 100%), caption: [P₂])
  )

  Não-linearidade dominante concentrada no instante atual
]

// Slide 6 – NMSE vs. Complexidade por Ordem
#slide(title: "NMSE em Função da Complexidade")[
  #set text(size: 0.88em)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    figure(image("figuras/nmsecomplexp0.png", width: 100%), caption: [Destacando P₀]),
    figure(image("figuras/nmsecomplexp1.png", width: 100%), caption: [Destacando P₁]),
    figure(image("figuras/nmsecomplexp2.png", width: 100%), caption: [Destacando P₂])
  )

  #v(0.6em)

  Ordem P₀ é o principal driver de ganho de precisão
  Aumento em atrasos antigos traz ganhos marginais
]

// Slide 7 – Modelos com Ordens Decrescentes
#slide(title: "Modelos com P₀ ≥ P₁ ≥ P₂")[
  #set text(size: 0.92em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Modelos com ordens polinomiais **decrescentes** ao longo dos atrasos  
        (P₀ ≥ P₁ ≥ P₂)
      - Maioria dos modelos com **melhor desempenho** pertence a esse grupo
      - Indica que a complexidade deve ser **priorizada no instante atual** (m = 0)
      - Redução progressiva da ordem nos atrasos mais antigos traz pouco prejuízo
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/modelosdecrecenteatraso.png", width: 100%),
          caption: [Modelos com ordens polinomiais decrescentes ao longo dos atrasos]
        )
      ]
    ]
  )
]
// Slide 8 – Fronteira de Pareto
#slide(title: "Fronteira de Pareto")[
  #set text(size: 0.92em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,

    [
      - Trade-off entre precisão (NMSE) e complexidade (número de coeficientes)
      - Modelos na fronteira: soluções mais eficientes (melhor NMSE com menor complexidade possível)
      - Distribuição típica dos melhores modelos: alta ordem em m=0 + redução rápida em m ≥ 1
      - Confirma que a **não-linearidade dominante** está concentrada no instante atual
    ],

    [
      #align(center + horizon)[
        #figure(
          image("figuras/fronteiradepareto.png", width: 100%),
          caption: [Fronteira de Pareto para os modelos MP com ordem dependente do atraso]
        )
      ]
    ]
  )
]

// Slide 9 – Resultados Preliminares das LUTs
#slide(title: "Implementação Conceitual com LUTs")[
  #set text(size: 0.90em)

  - Análise arquitetural da substituição de operações por LUTs
  - Foco: redução de complexidade em alta taxa de amostragem
  - Abordagem seletiva: LUTs nos termos de maior ordem
  - Resultados quantitativos (NMSE, recursos FPGA) → etapas futuras
  - Implementação prática ainda em andamento
]


// = Conclusão

// #slide(title: "Conclusão")[
//   #set text(size: 0.94em)
//   #set par(leading: 0.65em)

//   A modelagem comportamental híbrida proposta, combinando polinômios com memória de ordem dependente do atraso e tabelas de consulta (LUTs) priorizadas no termo corrente, demonstrou ser uma alternativa eficiente para representar o comportamento não linear e com memória de amplificadores de potência em sistemas de comunicação sem fio modernos. A análise sistemática do modelo Memory Polynomial (MP) clássico revelou que a não-linearidade dominante concentra-se no instante atual, permitindo redução significativa da complexidade computacional por meio de ordens polinomiais decrescentes nos atrasos sem prejuízo expressivo de precisão (medida por NMSE). A abordagem híbrida MP + LUT surge como solução promissora para implementação prática em hardware digital de baixa potência e alta taxa de amostragem, conciliando desempenho, eficiência energética e viabilidade em pré-distorção digital (DPD), com potencial para aplicações em estações rádio-base e dispositivos móveis.

//   #v(1.5em)

//   #align(center)[
//     *Muito obrigado pela atenção!*
//   ]
// ]
// 
= Próximas Etapas

#slide(title: "Próximas Etapas")[
  #set text(size: 0.94em)
  #set par(leading: 0.65em)

  A partir dos resultados obtidos com a modelagem comportamental híbrida — combinando Polinômio com Memória (MP) com ordens dependentes do atraso e o uso de LUTs priorizadas no termo corrente — as próximas etapas concentram-se no aprofundamento da validação em ambiente de simulação.

  Entre as direções futuras, destacam-se:

  • Avaliação mais abrangente do modelo híbrido utilizando diferentes sinais modulados e diferentes níveis de não linearidade do PA;

  • Análise do impacto da granularidade e da estratégia de interpolação das LUTs na precisão da modelagem (NMSE);

  • Investigação de critérios sistemáticos para definição das ordens polinomiais dependentes do atraso;

  • Expansão da análise multiobjetivo baseada na fronteira de Pareto, incorporando métricas adicionais relacionadas à complexidade computacional;

  • Comparação detalhada entre as abordagens puramente polinomial, puramente LUT e híbrida sob diferentes cenários operacionais.

  Essas etapas visam consolidar a proposta como uma alternativa computacionalmente eficiente para modelagem e pré-distorção digital de amplificadores de potência em sistemas modernos de comunicação sem fio.

  #v(1.5em)

  #align(center)[
    *Obrigado pela atenção!*
  ]
]


#slide(title: "Referências")[
  #set text(size: 0.65em)          // fonte menor para caber tudo
  #set par(leading: 0.45em)        // espaçamento entre linhas reduzido
  #set block(spacing: 0.6em)
    #v(0.6em)
  

  #columns(2, gutter: 1.2em)[
    #bibliography("Referencias.bib", full: true, style: "ieee")  
  ]
]