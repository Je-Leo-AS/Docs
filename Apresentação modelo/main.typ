#import "@preview/touying-simpl-swufe:0.2.0": *

#show: swufe-theme.with(
  aspect-ratio: "16-9",
  lang: "en",

  config-info(
    title: [Modelagem Comportamental Híbrida de Amplificadores de Potência],
    subtitle: [Usando Polinômios com Memória e Tabelas de Busca],
    short-title: [Modelagem Comportamental de PA],
    authors: [Leonardo de Andrade Santos],
    author: [Leonardo de Andrade Santos],
    date: datetime.today(),
    institution: ([Universidade Federal do Paraná]),
    // banner: #image("ufpr.png")
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
#outline-slide()

= Introdução

== Contextualização

- A evolução dos sistemas de comunicação móveis, impulsionada por maiores taxas de dados e novos serviços
  (multimídia, web e IoT), impôs requisitos cada vez mais rigorosos aos sistemas de radiofrequência.
- A eficiência energética tornou-se um fator crítico, tanto em dispositivos móveis quanto em estações rádio base.
- A largura de banda disponível é limitada, exigindo modulações espectralmente eficientes.
- Modulações com variação de amplitude são altamente sensíveis à não linearidade dos amplificadores de potência (PA).
- O projeto do PA envolve um compromisso entre eficiência energética e linearidade.
- O uso de Pré-Distorção Digital (DPD) é uma estratégia amplamente adotada para mitigar esses efeitos.

== Objetivos

O objetivo geral deste trabalho é o desenvolvimento de um circuito integrado dedicado para a implementação
de um Pré-Distorcedor Digital (DPD) aplicado a amplificadores de potência de RF.

- Modelar matematicamente o PA e o DPD considerando não linearidade e memória;
- Implementar os modelos em VHDL;
- Realizar o projeto físico do circuito integrado utilizando ferramentas Cadence;
- Avaliar o compromisso entre linearidade, complexidade e eficiência energética.

= Fundamentação Teórica

== Sistema de Comunicação Sem Fio

- Sistemas sem fio são compostos por transmissor, meio de propagação e receptor;
- Este trabalho foca no transmissor;
- O Amplificador de Potência em RF é o bloco de maior consumo energético;
- Converte energia CC em potência RF irradiada pela antena.

#figure(
  image("figuras/sistematrasmissorpng.png", height: 70%),
  caption: [Sistema de transmissão simplificado],
)

== Distorção Espectral e Restrições Normativas

- Sistemas sem fio estão sujeitos a restrições normativas de emissão espectral;
- A máscara espectral limita a potência em bandas adjacentes;
- A não linearidade do PA gera produtos de intermodulação;
- Regiões de maior eficiência tendem a intensificar distorções.

#figure(
  image("figuras/normareg.png", height: 65%),
  caption: [Exemplo de máscara espectral e distorções adjacentes],
)

== Distorções em Amplificadores de Potência

- O PA apresenta comportamento não linear em altos níveis de potência;
- A linearidade é avaliada pelo ponto de compressão de 1 dB;
- Componentes reativos introduzem efeitos de memória;
- Esses efeitos degradam sinais de larga banda.

#figure(
  image("figuras/curvasaidaparf.png", height: 70%),
  caption: [Curva de transferência de um PARF],
)

== Pré-Distorção Digital (DPD)

#figure(
  image("figuras/DPDcascata.png", height: 65%),
  caption: [DPD em cascata com amplificador de potência],
)

- A DPD aplica uma distorção controlada em banda base;
- Possui função de transferência aproximadamente inversa à do PA;
- O conjunto DPD + PA apresenta comportamento quase linear;
- Bom compromisso entre desempenho e custo de implementação.

== Modelagem Comportamental

- Baseia-se na relação entre sinais de entrada e saída;
- Não requer conhecimento da topologia interna do PA;
- Representa não linearidades e efeitos de memória;
- Amplamente empregada em sistemas DPD.

== Séries de Volterra

- Extensão da série de Taylor para sistemas não lineares dinâmicos;
- Modela não linearidades e memória de forma geral;
- Alta capacidade de aproximação;
- Elevada complexidade computacional.




== Polinômio com Memória



- Simplificação da série de Volterra;
- Considera apenas termos diagonais;
- Modelo compacto e linear nos coeficientes;
- Amplamente utilizado em DPD.

= Resultados

== Dados Utilizados

- PA classe AB, tecnologia GaN HEMT;
- Frequência central: 900 MHz;
- Modulação WCDMA (3GPP);
- Largura de banda: 3,84 MHz;
- Aquisição com VSA Rohde & Schwarz;
- Taxa de amostragem: 61,44 MHz.

#figure(
  image("figuras/analisador.jpeg", height: 65%),
  caption: [Analisador vetorial de sinais],
)

== Modelagem do PA com MP Original

- Modelo Memory Polynomial (MP);
- Implementação em Python (ponto flutuante);
- Identificação dos coeficientes via `least_squares`;
- Ordem polinomial P = 3 e memória M = 2;
- Métrica de desempenho: NMSE;
- NMSE obtido: −26,58 dB.

#figure(
  image("figuras/modeloPAfloat.png", height: 65%),
  caption: [Modelo comportamental do PA],
)

= Conclusão

==

- A eficiência espectral e energética exige mitigação das não linearidades dos PA;
- O modelo MP foi estudado e validado para aplicações em DPD;
- A modelagem foi realizada em software com otimização numérica;
- A métrica NMSE comprovou a eficácia do modelo;
- Estratégias baseadas em LUTs foram analisadas conceitualmente;
- O modelo MP mostra-se adequado para futuras implementações em hardware.

= Referências
==

#bibliography("Referencias.bib")

#ending-slide("Obrigado!")