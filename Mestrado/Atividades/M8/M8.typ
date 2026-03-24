#import "template.typ": *

#show: project.with(
  title: "Relatório Atividade M6 [DPD + PA]",
  authors: ("Leonardo Santos",),
)

== Objetivo

O objetivo desta etapa foi implementar e avaliar um sistema de
*pré-distorção digital* (DPD) baseado no modelo _Memory Polynomial_ (MP),
com o intuito de linearizar a resposta de amplificadores de potência
reais.

A abordagem adotada foi a *Indirect Learning Architecture (ILA)*, na qual
o DPD é treinado como o inverso do amplificador de potência (PA), utilizando
os dados experimentais disponíveis. A partir disso, foi construída a
cascata completa DPD + PA, permitindo avaliar o ganho de linearidade
em termos de características AM-AM, AM-PM e NMSE.

== Descrição do Conjunto de Dados

Foi utilizado o conjunto experimental:

*Conjunto — `data_LDMOS_formatted_4500p.mat`* (PA LDMOS)

- Amplificador de tecnologia LDMOS
- Dados experimentais reais
- Estrutura:
  - `in_extraction`, `out_extraction` (treinamento)
  - `in_validation`, `out_validation` (validação)

Os sinais foram normalizados pelo maior valor absoluto entre partes real
e imaginária, garantindo estabilidade numérica durante a identificação.

== Metodologia

A metodologia seguiu três etapas principais:

*1. Identificação do modelo do PA*

O amplificador foi modelado utilizando um _Memory Polynomial_ com
profundidade de memória $M = 2$ e ordem polinomial $P = 5$, resultando
em $15$ coeficientes complexos.

Os coeficientes foram estimados por mínimos quadrados não lineares,
minimizando o erro:

$ e(n) = y_"real"(n) - y_"est"(n) $

*2. Treinamento do DPD (ILA)*

O DPD foi obtido utilizando a arquitetura ILA, onde o modelo aprende a
inversão do PA:

- Entrada do DPD: saída do PA
- Saída desejada: entrada original

Ou seja, o treinamento foi realizado com o mapeamento:

$ y_"PA"(n) -> x(n) $

*3. Aplicação da cascata DPD + PA*

A estrutura final aplicada foi:

$ x(n) -> "DPD"(x(n)) -> "PA"("DPD"(x(n))) $

Para evitar extrapolação do modelo polinomial, foi aplicado um fator de
ganho global na entrada do sistema.

== Ajuste de Ganho

Foram testadas duas estratégias de ganho:

- Ganho baseado na relação entre entrada e saída do PA:

$ "gain" = 0.9999999999999 * max(|y_"PA"|) / max(|x|) approx 0.83 $

Esse ganho produziu um sinal estável e bem comportado, porém com
*amplitude reduzida*, limitando a excursão dinâmica do sistema.

- Ganho fixo:

$ "gain" = 0.95 $

Com esse valor, observou-se melhor utilização da faixa dinâmica do
modelo, mantendo estabilidade e melhorando a qualidade da linearização.

Esse resultado evidencia o compromisso entre estabilidade numérica e
exploração da não linearidade do PA.

== Resultados

=== Comportamento AM-AM

A Figura de AM-AM mostra que:

- O modelo do PA reproduz adequadamente a compressão de ganho do
  amplificador real
- O DPD compensa essa não linearidade, tornando a resposta mais próxima
  de uma relação linear
- A cascata DPD + PA apresenta uma característica significativamente
  mais linear em comparação ao PA isolado

=== Comportamento AM-PM

Na característica AM-PM:

- O PA apresenta distorção de fase dependente da amplitude
- O DPD reduz essa variação, aproximando a diferença de fase de zero
- A cascata final apresenta menor dispersão de fase, indicando
  compensação eficaz da não linearidade

=== Análise Qualitativa

Os resultados obtidos indicam que:

- O modelo MP é capaz de capturar adequadamente as não linearidades do PA
- A abordagem ILA é eficaz para estimar um predistorcedor funcional
- A linearização é claramente observável nos gráficos AM-AM e AM-PM
- O ajuste de ganho é um fator crítico para o desempenho do sistema

== Figuras

As figuras de AM-AM e AM-PM foram geradas diretamente a partir dos dados
de validação, incluindo:

- Sinal medido
- Modelo do PA
- Modelo do DPD
- Cascata final (DPD + PA)

#figure(
  caption: [Características AM-AM do sistema DPD + PA],
)[
  #image("./assets/AM-AM.png", width: 90%)
]

#figure(
  caption: [Características AM-PM do sistema DPD + PA],
)[
  #image("./assets/AM-PM.png", width: 90%)
]

== Conclusão

A implementação do sistema DPD + PA utilizando _Memory Polynomial_ e
arquitetura ILA demonstrou resultados consistentes na linearização de
um amplificador real LDMOS.

Os resultados mostram que:

- O DPD reduz significativamente as distorções de amplitude e fase
- A cascata final apresenta comportamento mais linear
- O modelo MP é adequado tanto para modelagem quanto para inversão
- O ajuste de ganho é essencial para evitar extrapolação e garantir
  desempenho adequado

Essa etapa representa um avanço importante em direção à implementação
em hardware, fornecendo uma base sólida para futuras etapas envolvendo
aritmética de ponto fixo e síntese em VHDL.

== Próxima Etapa

Como continuidade do trabalho, pretende-se:

- Avaliar quantitativamente o ganho de linearização via NMSE e espectro
- Implementar o modelo em aritmética de ponto fixo
- Desenvolver uma versão em VHDL para síntese em FPGA
- Investigar técnicas mais avançadas de DPD (ex.: GMP)

Esses passos permitirão validar a viabilidade prática da solução em
sistemas embarcados.