#import "template.typ": *

#show: project.with(
  title: "Relatório Atividade M7",
  subtitle: "Implementação em VHDL do modelo Memory Polynomial com ordem polinomial dependente do atraso",
  authors: ("Leonardo Santos",),
)

== Objetivo

O objetivo desta atividade foi validar, em ambiente de síntese em hardware, a redução de complexidade obtida com o modelo Memory Polynomial (MP) com ordem polinomial dependente do atraso.

Para isso, foi realizada a implementação em VHDL de duas versões do modelo:

- MP original completo (ordem uniforme em todos os atrasos);
- MP com truncamento polinomial dependente do atraso, utilizando uma estrutura compactada.

A motivação central é verificar se a redução de complexidade observada em ambiente de simulação (Python) se traduz efetivamente em menor utilização de recursos em hardware digital, mantendo equivalência funcional entre as implementações.

== Metodologia

A metodologia consistiu nas seguintes etapas:

1. Implementação em VHDL

O modelo MP foi implementado em VHDL considerando:

- Representação em ponto fixo;
- Estrutura baseada em somatório de produtos complexos;
- Organização por ramos de memória (𝑀 + 1);
- Cálculo explícito dos termos polinomiais.

Foram desenvolvidas duas arquiteturas:

- Versão original: com todas as ordens polinomiais iguais para todos os atrasos;
- Versão truncada: com redução da ordem polinomial nos atrasos mais antigos e reorganização da estrutura para eliminar operações redundantes.

2. Ferramentas de síntese

A síntese foi realizada utilizando ferramentas open source:

- GHDL (análise e simulação VHDL)
- Yosys (síntese lógica)
- GTKWave (visualização de sinais)

3. Validação funcional

A equivalência entre o modelo em Python e a implementação em VHDL foi verificada por comparação direta das saídas em ponto fixo, além da análise das curvas AM-AM e AM-PM.

== Resultados

=== Validação Funcional (Python)

#figure(
  caption: [Curvas AM-AM e AM-PM obtidas em Python, comparando os dados medidos com os modelos PA e DPD em ponto fixo.],
)[
#image("./assets/fig_python_amam_ampm.png", width: 80%)
]<fig:fig_python_amam_ampm>

A @fig:fig_python_amam_ampm acima apresenta a comparação entre os sinais medidos e os modelos implementados em Python. Observa-se que o modelo DPD é capaz de compensar a não linearidade do amplificador, aproximando a resposta do comportamento ideal.

=== Validação da Implementação em VHDL

#figure(
  caption: [Curva AM-AM comparando o modelo em Python com o resultado da síntese lógica em VHDL.],
)[
  // ⬇️ INSERIR FIGURA 2 AQUI
  // Exemplo:
  #image("./assets/fig_vhdl_vs_python.png", width: 80%)
]<fig:vhdl_vs_python>

A @fig:vhdl_vs_python acima apresenta a comparação entre o modelo DPD calculado em Python e o resultado obtido a partir da simulação da implementação em VHDL.

Observa-se que os pontos referentes à síntese lógica se sobrepõem aos resultados do modelo, indicando equivalência funcional entre as implementações.

=== Comparação de Complexidade

#figure(
  caption: [Comparação de complexidade entre o modelo MP original e o modelo truncado implementado em VHDL.],
)[
  #align(center)[
    #table(
      columns: 4,
      align: center,
      stroke: (x, y) => if y == 1 { (bottom: 1pt) },

      [*Métrica*], [*MP Original*], [*MP Truncado*], [*Redução (%)*],

      [Wires],        [69 735], [41 022], [41,2],
      [Wire bits],    [72 087], [42 703], [40,8],
      [Cells],        [70 800], [41 497], [41,4],
      [Flip-flops],   [765],    [484],    [36,7],
    )
  ]
]<tab:complexidade>

Observa-se na @tab:complexidade uma redução consistente de aproximadamente 40% em todas as métricas estruturais, indicando uma diminuição significativa na complexidade do circuito.

=== Análise Estrutural

A redução no número de células demonstra que a abordagem proposta elimina efetivamente operações aritméticas do circuito, e não apenas coeficientes nulos.

Além disso, a redução no número de registradores indica simplificação na estrutura sequencial, decorrente da remoção de termos polinomiais desnecessários.

== Discussão

Os resultados obtidos confirmam que:

- A não linearidade dominante está concentrada nos termos de menor atraso;
- A redução da ordem nos atrasos mais antigos não compromete a precisão do modelo;
- A reorganização estrutural do circuito é essencial para obter ganhos reais em hardware.

Diferentemente de abordagens baseadas apenas na anulação de coeficientes, a estratégia adotada remove diretamente blocos aritméticos da implementação.

== Conclusão

Esta atividade demonstrou que o modelo MP com ordem polinomial dependente do atraso permite reduzir significativamente a complexidade da implementação em hardware, mantendo equivalência funcional com o modelo de referência em Python.

A redução de aproximadamente 40% nas métricas estruturais evidencia o potencial da abordagem para aplicações em sistemas digitais com restrições de área e consumo.