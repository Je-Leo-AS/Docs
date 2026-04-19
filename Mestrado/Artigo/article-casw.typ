#set page(
  paper: "us-letter",
  margin: (top: 1.04in, bottom: 1.11in, left: 0.75in, right: 0.75in),
)

#set text(font: "Libertinus Serif", size: 9pt, lang: "pt")
#set par(justify: true, leading: 0.56em)
#set heading(numbering: "1")
#set figure.caption(position: bottom)
#set math.equation(numbering: "(1)")

#let conference-short = "CASW'26"
#let conference-long = "CASW'26, 2026, Curitiba, PR, Brasil"
#let running-authors = "L. A. Santos e E. G. Lima"
#let isbn = "Documento interno"
#let doi = ""
#let title = "Modelagem de Amplificadores de Potência com Polinômio de Memória de Ordem Dependente do Atraso"
#let subtitle = "Síntese dos resultados de modelagem comportamental, avaliação por NMSE e implementação em VHDL"

#let authors = (
  (
    name: "Leonardo de Andrade Santos",
    note: "",
    dept: "Programa de Pós-Graduação em Engenharia Elétrica",
    inst: "Universidade Federal do Paraná",
    city: "Curitiba, PR, Brasil",
    email: "leonard.andrade@ufpr.br",
  ),
  (
    name: "Eduardo de Gonçalves de Lima",
    note: "",
    dept: "Programa de Pós-Graduação em Engenharia Elétrica",
    inst: "Universidade Federal do Paraná",
    city: "Curitiba, PR, Brasil",
    email: "eduardo.goncalves@ufpr.br",
  ),
)

#let title-block() = [
  #align(center)[
    #text(size: 17pt, weight: "bold")[#title]
    #v(0.3em)
    #text(size: 10pt)[#subtitle]
  ]
]

#let author-block(author) = [
  #align(center)[
    #text(size: 10.5pt, weight: "bold")[#author.name#author.note] \
    #text(size: 9.4pt)[#author.dept] \
    #text(size: 9.4pt)[#author.inst] \
    #text(size: 9.4pt)[#author.city] \
    #text(size: 9.4pt)[#link("mailto:" + author.email)[#author.email]]
  ]
]

#let acm-reference-format = [
  #text(weight: "bold")[Formato de Referência ACM:]
  Leonardo de Andrade Santos e Eduardo de Gonçalves de Lima. 2026.
  #title. CASW, 5 páginas.
]

#show heading.where(level: 1): it => {
  v(0.8em)
  if it.numbering != none {
    text(size: 11pt, weight: "bold")[#counter(heading).display(it.numbering) #h(0.35em) #it.body]
  } else {
    text(size: 11pt, weight: "bold")[#it.body]
  }
  v(0.35em)
}

#show heading.where(level: 2): it => {
  v(0.6em)
  if it.numbering != none {
    text(style: "italic", weight: "bold")[#counter(heading).display(it.numbering) #h(0.3em) #it.body]
  } else {
    text(style: "italic", weight: "bold")[#it.body]
  }
  h(0.3em)
}

#let first-page-body(body) = context {
  let page-num = counter(page).get().first()
  [
    #if page-num == 1 [
      #body
    ] else [
      #body
    ]
  ]
}

#set page(
  header: context {
    let page-num = counter(page).get().first()
    if page-num > 1 [
      #align(center)[
        #grid(
          columns: (1fr, 1fr),
          gutter: 1em,
          [#text(size: 8pt)[#conference-long]],
          [#align(right)[#text(size: 8pt)[#running-authors]]],
        )
      ]
    ]
  },
  footer: context {
    let page-num = counter(page).get().first()
    if page-num == 1 [
      #grid(
        columns: (1fr, 1fr, 1fr, 0.5fr),
        gutter: 1em,
        [#text(size: 8pt)[#conference-short]],
        [#align(center)[#text(size: 8pt)[#title]]],
        [#align(right)[#text(size: 8pt)[#isbn]]],
        [#align(right)[#text(size: 8pt)[#page-num]]],
      )
    ] else [
      #align(center)[#text(size: 8pt)[#page-num]]
    ]
  },
)

#title-block()
#v(0.85em)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.65in,
  ..authors.map(author => author-block(author)),
)

#v(1.15em)

#columns(2, gutter: 0.33in)[
#first-page-body[

#text(weight: "bold")[RESUMO]

Este artigo sintetiza uma investigação sobre modelagem comportamental de amplificadores de potência de RF voltados à pré-distorção digital. O trabalho parte do modelo _Memory Polynomial_ (MP) clássico e propõe uma variação em que a ordem polinomial máxima depende do atraso de memória. A hipótese central é que a maior parcela da não linearidade está concentrada na amostra atual, enquanto atrasos mais antigos podem ser representados por ordens menores. A metodologia foi avaliada em software por identificação via mínimos quadrados e validação com a métrica _Normalized Mean Square Error_ (NMSE), além de uma implementação em VHDL em ponto fixo para análise de viabilidade em hardware. Os resultados indicam que a distribuição decrescente das ordens ao longo da memória preserva a acurácia do modelo, melhora a relação entre desempenho e número de coeficientes e reduz sua complexidade estrutural, com ganhos também observados após a síntese lógica. Em conjunto, as evidências mostram que o ajuste seletivo das ordens ao longo da memória constitui uma estratégia consistente para aproximar desempenho de modelagem e eficiência de implementação.

#v(0.7em)

#text(weight: "bold")[PALAVRAS-CHAVE]

Pré-distorção digital, amplificador de potência, _Memory Polynomial_, NMSE, VHDL

#v(0.7em)

#acm-reference-format

= Introdução

Amplificadores de potência operando próximos da saturação apresentam não linearidade acentuada e efeitos de memória, o que compromete a qualidade espectral de sinais de banda larga. Em sistemas modernos de comunicação sem fio, esse comportamento se torna especialmente crítico, pois o espalhamento espectral e a distorção da envoltória degradam a eficiência de transmissão e dificultam a convivência com canais adjacentes. Nesse cenário, a pré-distorção digital depende de modelos matemáticos capazes de representar o comportamento do amplificador com boa precisão e custo computacional compatível com a implementação prática.

#cite(<Kim2001>) mostrou cedo que a modelagem com memória é essencial para a pré-distorção de sinais de banda larga. Mais tarde, #cite(<GonalvesdeLima2009>) consolidou essa linha ao tratar a modelagem comportamental e a pré-distorção em banda-base como elementos centrais no projeto de linearizadores para amplificadores de RF. Em perspectiva mais ampla de projeto, #cite(<Cripps2006>) e #cite(<Kenington2000>) discutem como os compromissos entre linearidade, eficiência e complexidade condicionam a escolha do modelo matemático e da arquitetura de implementação.

Dentro desse contexto, o _Memory Polynomial_ tornou-se uma solução particularmente atrativa por combinar boa capacidade de representação com estimação relativamente simples. Em aplicações práticas, #cite(<Kwan2012>) mostra a importância de modelos viáveis para implementação em FPGA, enquanto #cite(<Bonfim2016>) explora extensões baseadas em séries de Volterra para melhorar a descrição comportamental de amplificadores de potência. No âmbito acadêmico nacional, #cite(<John2016>), #cite(<Luiza2016>) e #cite(<Chavez2018>) reforçam a relevância de modelos com memória em diferentes estratégias de identificação e linearização. Já #cite(<Schuartz2017>) destaca explicitamente o potencial de reduzir a complexidade do polinômio com memória sem perder desempenho de forma significativa.

Apesar desses avanços, a formulação tradicional do MP adota a mesma ordem polinomial para todos os ramos de memória, o que pode impor operações desnecessárias quando a contribuição dos atrasos mais antigos já é pequena. Este trabalho investiga, portanto, uma formulação alternativa em que a ordem máxima é definida individualmente para cada atraso, concentrando maior complexidade apenas nos termos mais relevantes.

Além do interesse algorítmico, essa questão é particularmente importante quando o modelo precisa ser transportado para plataformas digitais com restrições de área, frequência de operação e consumo energético. Em tais cenários, o número de coeficientes, a profundidade da cadeia de multiplicações e o volume de registradores deixam de ser detalhes secundários e passam a influenciar diretamente a viabilidade da solução. Assim, um modelo ligeiramente mais simples pode ser preferível a outro marginalmente mais preciso quando a perda em NMSE é pequena e o ganho em custo de implementação é expressivo.

Com esse pano de fundo, o objetivo deste artigo é reunir os principais resultados teóricos, experimentais e de hardware associados à hipótese de ordem dependente do atraso. A contribuição central não se restringe à formulação matemática do modelo, mas inclui também uma leitura conjunta entre desempenho de identificação, sensibilidade paramétrica e impacto arquitetural. Desse modo, a análise busca responder não apenas se o modelo reduz erro, mas se essa redução permanece tecnicamente justificável quando observada do ponto de vista de implementação digital.

= Premissa

A premissa central do trabalho é que a parcela mais intensa da não linearidade do amplificador está associada à amostra atual. Em consequência, atrasos mais antigos podem ser descritos com ordens progressivamente menores, hipótese compatível com os resultados de modelagem relatados em #cite(<John2016>) e com a estratégia de redução de complexidade discutida em #cite(<Schuartz2017>). Sob essa hipótese, a busca por configurações eficientes deixa de se concentrar apenas no menor erro possível e passa a considerar também o custo estrutural do modelo. A fronteira de Pareto resultante permite identificar combinações que oferecem melhor compromisso entre desempenho e complexidade, evitando soluções dominadas por alternativas simultaneamente mais simples e mais precisas.

Essa premissa é compatível com a interpretação física de muitos amplificadores de potência com memória curta ou moderada, nos quais mecanismos térmicos, elétricos e de polarização deixam uma assinatura temporal perceptível, mas tipicamente menos intensa à medida que o atraso se afasta do instante corrente. Em outras palavras, a memória continua relevante, porém sua contribuição tende a se tornar menos exigente em termos de ordem polinomial. Se essa leitura estiver correta, empregar ordens idênticas em todos os atrasos representa uma superparametrização do problema.

Do ponto de vista de identificação, a adoção de ordens específicas por atraso também tem uma implicação importante: ela reduz a probabilidade de ajustar termos pouco informativos, o que ajuda a conter colinearidade na matriz de regressão e torna a interpretação dos coeficientes mais clara. Em vez de expandir indiscriminadamente o espaço de busca, a proposta organiza a complexidade de acordo com a relevância esperada de cada ramo. Isso oferece uma base metodológica mais coerente para comparar modelos de diferentes tamanhos e interpretar a fronteira de Pareto obtida experimentalmente.

#figure(
  image("../Tese/template/Figuras/mp_padrao.png", width: 97%),
  caption: [Estrutura conceitual do modelo _Memory Polynomial_ com ramos de memória.],
)

= Metodologia

O modelo proposto é descrito por

$ y(n) = sum_(m=0)^(M) sum_(p=1)^(P_m) h_(p,m) x(n - m) |x(n - m)|^(p - 1), $

em que $P_m$ representa a ordem máxima associada ao atraso $m$. O MP clássico é recuperado como caso particular quando todas as ordens são iguais. A principal vantagem dessa formulação é preservar a linearidade nos parâmetros, permitindo a estimação dos coeficientes por mínimos quadrados com uma matriz de regressão potencialmente menor do que a do modelo convencional.

Para a avaliação experimental, foram considerados modelos com profundidade de memória $M = 2$ e combinações de ordens $(P_0, P_1, P_2)$ variando de 1 a 5. Essa escolha produz um espaço de busca suficientemente amplo para evidenciar tendências de sensibilidade, sem comprometer a análise comparativa entre configurações. A estratégia adotada consistiu em estimar cada configuração independentemente, registrar seu NMSE e, em seguida, relacionar esse desempenho ao número de coeficientes empregados pelo modelo. Dessa forma, foi possível observar não apenas qual configuração oferece menor erro, mas quais delas permanecem competitivas quando se incorpora o custo estrutural à análise.

O desempenho foi medido por meio do NMSE,

$ "NMSE" = 10 log_(10) lr(( frac(sum |e(n)|^2, sum |y_"real"(n)|^2) )), $

comparando a saída medida do amplificador com a saída estimada pelo modelo. Como o NMSE normaliza a energia do erro pela energia do sinal de referência, ele permite comparar de maneira direta modelos com diferentes números de termos e diferentes estratégias de parametrização. Valores mais negativos indicam melhor aderência entre o modelo e o comportamento observado do amplificador.

Além da avaliação em software, duas arquiteturas foram descritas em VHDL: a versão MP original e a versão truncada com ordem dependente do atraso. Na implementação em hardware, o foco foi verificar como a redução seletiva de ordem repercute nas principais métricas de síntese. Essa etapa é importante porque a utilidade prática de um modelo comportamental não depende apenas de sua qualidade de ajuste, mas também da possibilidade de ser implementado com custo previsível em plataformas reconfiguráveis ou dedicadas.

Em termos de fluxo de trabalho, a metodologia pode ser resumida em quatro etapas: definição do conjunto de ordens candidatas; estimação dos coeficientes por mínimos quadrados; avaliação de desempenho via NMSE; e, por fim, comparação entre custo algorítmico e custo de implementação. Esse encadeamento permite que a análise saia do nível puramente numérico e alcance uma perspectiva de projeto, mais apropriada para aplicações de pré-distorção digital em sistemas reais.

= Resultados

Os experimentos mostraram que a complexidade do modelo deve ser concentrada no instante atual. No conjunto LDMOS analisado, um modelo completo com $(P_0, P_1, P_2) = (5,5,5)$ atingiu NMSE de $-38,47$ dB, mas a análise da energia dos coeficientes indicou decaimento monotônico ao longo dos atrasos. A sensibilidade do NMSE confirmou esse comportamento: ao variar cada ramo isoladamente entre 1 e 5, o ganho associado a $P_0$ foi de 6,66 dB, enquanto $P_1$ e $P_2$ produziram ganhos de 3,43 dB e 1,49 dB, respectivamente.

Esse resultado é relevante porque mostra que o melhor desempenho absoluto não coincide necessariamente com a configuração mais eficiente. Embora a configuração completa ainda seja a referência de maior acurácia, a diferença entre ela e modelos truncados bem escolhidos torna-se relativamente pequena quando comparada à redução de complexidade obtida. Em outras palavras, parte expressiva da capacidade de modelagem já é capturada por um conjunto reduzido de termos, desde que a distribuição das ordens respeite a importância relativa de cada atraso.

#figure(
  placement: top,
  image("../Tese/template/Figuras/ev2_sensibilidade_nmse.png", width: 97%),
  caption: [Sensibilidade do NMSE às ordens $P_0$, $P_1$ e $P_2$, destacando a predominância do instante atual.],
)

#figure(
  kind: table,
  caption: [Desempenho de modelagem para diferentes configurações de ordem e número de coeficientes.],
  table(
    columns: (1.25fr, 0.8fr, 1fr, 1fr),
    align: center,
    inset: 4pt,
    table.header([*Configuração*], [*Coeficientes*], [*NMSE GaN*], [*NMSE LDMOS*]),
    [$(1,1,1)$], [3], [$-21,66$ dB], [$-28,71$ dB],
    [$(3,2,1)$], [6], [$-25,53$ dB], [$-34,75$ dB],
    [$(4,3,2)$], [9], [$-25,64$ dB], [$-36,31$ dB],
    [$(5,3,2)$], [10], [$-25,49$ dB], [$-37,00$ dB],
    [$(5,5,5)$], [15], [$-26,10$ dB], [$-37,51$ dB],
  ),
)

A tabela mostra que boa parte do ganho pode ser obtida com modelos intermediários, sem a necessidade de manter a ordem máxima em todos os atrasos. Configurações com ordens decrescentes preservam a tendência observada e aproximam o desempenho do modelo completo com número menor de coeficientes.

Na avaliação exaustiva de 125 combinações, modelos como $(3,2,1)$, $(4,3,2)$ e $(5,3,2)$ ofereceram o melhor compromisso entre número de coeficientes e desempenho. Em GaN e LDMOS, o parâmetro $P_0$ foi o principal responsável pela melhora do NMSE, enquanto atrasos mais antigos saturaram rapidamente em ordens menores.

Outro aspecto importante da análise é que a ordenação das melhores soluções não depende apenas do dispositivo considerado, mas a tendência global se mantém consistente entre os conjuntos avaliados. Isso fortalece a interpretação de que a hipótese de ordem dependente do atraso não é um ajuste pontual a um experimento específico, e sim uma regularidade estrutural do problema de modelagem. Mesmo quando os valores absolutos de NMSE variam entre tecnologias, a hierarquia de relevância entre os ramos de memória permanece semelhante.

Sob a perspectiva de projeto, essa estabilidade é particularmente útil. Se a configuração ótima mudasse de forma abrupta entre diferentes conjuntos de dados, a proposta teria valor limitado como regra de síntese de modelos. No entanto, a recorrência de soluções com ordens decrescentes indica que há uma diretriz prática robusta: começar com maior ordem no atraso nulo e reduzir progressivamente a complexidade nos atrasos subsequentes tende a produzir soluções competitivas já nas primeiras iterações de projeto.

= Avaliação de Hardware e Pareto

A avaliação de síntese em VHDL comparou a arquitetura MP clássica com a versão truncada com ordens dependentes do atraso. A configuração $(5,3,2)$ reduz em cerca de 40% os principais recursos de síntese, mantendo o NMSE próximo ao modelo completo. Esse resultado reforça que a simplificação algorítmica também se traduz em redução efetiva de custo na implementação digital.

Do ponto de vista arquitetural, essa redução não deve ser interpretada apenas como economia de coeficientes armazenados. A diminuição da ordem em ramos menos relevantes implica menos produtos parciais, menor profundidade de somadores e menor pressão sobre registradores intermediários. Na prática, isso contribui para simplificar o caminho de dados e pode facilitar o fechamento temporal em implementações mais agressivas de frequência.

#figure(
  kind: table,
  caption: [Comparação de recursos de hardware entre a arquitetura MP completa e versões truncadas.],
  table(
    columns: (1.75fr, 0.7fr, 1fr, 0.9fr, 1fr),
    align: center,
    inset: 4pt,
    table.header([*Arquitetura*], [*Coef.*], [*Redução*], [*Células*], [*Registradores*]),
    [MP completo $(5,5,5)$], [15], [--], [100%], [100%],
    [MP truncado $(5,3,2)$], [10], [40%], [60%], [60%],
    [MP truncado $(4,3,2)$], [9], [40%], [58%], [58%],
  ),
)

A fronteira de Pareto entre complexidade de hardware e desempenho NMSE revela que $(4,3,2)$ e $(5,3,2)$ dominam o espaço de soluções. Configurações com ordens maiores em atrasos menos relevantes exigem mais recursos sem ganhos proporcionais. Assim, a redução seletiva da ordem polinomial preserva o desempenho útil do modelo ao mesmo tempo que favorece arquiteturas mais compactas.

Na implementação em VHDL, a versão truncada manteve equivalência funcional com o modelo de referência em Python e apresentou reduções próximas de 40% nas principais métricas de síntese, incluindo `wires`, `wire bits`, células e registradores. Esses resultados mostram que a redução da ordem polinomial nos atrasos mais antigos não representa apenas economia algorítmica, mas também simplificação concreta da arquitetura digital.

Esse resultado tem implicações práticas diretas para sistemas embarcados e transmissores com orçamento restrito de recursos. Em muitos casos, uma pequena perda de NMSE é aceitável desde que o modelo continue satisfazendo os requisitos de linearização do sistema e permita uma implementação mais compacta e energeticamente eficiente. A fronteira de Pareto ajuda justamente a formalizar essa decisão, substituindo escolhas intuitivas por um critério quantitativo de comparação entre desempenho e custo.

= Discussão

Os resultados permitem interpretar a proposta sob duas perspectivas complementares. A primeira é a perspectiva de modelagem: o modelo de ordem dependente do atraso reorganiza a distribuição de complexidade de maneira mais coerente com a relevância observada dos ramos de memória. A segunda é a perspectiva de implementação: ao reduzir termos de baixa contribuição, a proposta transforma ganho conceitual em economia mensurável de hardware. A robustez da abordagem está exatamente na convergência dessas duas leituras.

Também é importante notar que o trabalho não afirma que todos os amplificadores devam ser modelados com o mesmo perfil de ordens. O que os resultados sugerem é uma diretriz de projeto: a ordem polinomial não precisa ser uniforme ao longo dos atrasos, e assumir uniformidade por padrão pode mascarar soluções mais eficientes. À medida que a profundidade de memória cresce, essa ideia tende a se tornar ainda mais valiosa, pois evita a expansão indiscriminada do número de termos.

Por fim, a análise conjunta de NMSE, sensibilidade e síntese reforça que a escolha do modelo deve ser tratada como um problema de engenharia de compromisso, e não como uma competição isolada por menor erro numérico. Em aplicações reais de pré-distorção digital, a qualidade de ajuste continua sendo fundamental, mas ela precisa ser interpretada ao lado de restrições de área, latência, frequência de operação e consumo. O modelo proposto contribui justamente por oferecer uma forma simples de internalizar esse compromisso no próprio desenho da estrutura comportamental.

= Conclusão

O estudo confirma que o modelo MP com ordem polinomial dependente do atraso é uma alternativa eficiente para a modelagem comportamental de amplificadores de potência. A proposta preserva a precisão do MP clássico, reduz o número de termos necessários e favorece implementações digitais mais compactas. Os resultados de sensibilidade mostraram que a maior contribuição para a melhora do NMSE se concentra no ramo associado ao instante atual, enquanto atrasos mais antigos podem ser representados com ordens menores sem perda proporcional de desempenho.

Sob a ótica de implementação, a análise em VHDL demonstrou que essa reorganização da complexidade não é apenas uma simplificação matemática, mas uma vantagem concreta de arquitetura. Configurações como $(4,3,2)$ e $(5,3,2)$ se destacaram por combinar bom desempenho de modelagem com redução expressiva de recursos de síntese, o que as torna particularmente atrativas para aplicações práticas de pré-distorção digital. Como consequência, o trabalho oferece uma base promissora para aplicações com restrições de área e consumo, mantendo consistência tanto na avaliação em software quanto na validação em hardware.

= Referências

#set text(size: 7.5pt)
#set par(leading: 0.42em)
#bibliography("Referencias.bib", title: none)
]
]
