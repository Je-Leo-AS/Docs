#let project(title: "", authors: (), body) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Times New Roman", lang: "pt")
  set heading(numbering: "1.")
  set math.equation(numbering: "(1)")

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.email
      ]),
    ),
  )

  // Main body.
  set par(justify: true)

  body
}

#let numbered_eq(content) = math.equation(
    block: true,
    numbering: "(1)",
    content,
)

#show: project.with(
  title: "Projeto de Rádio Enlace de Comunicação",
  authors: (
    (name: "Audric Costacurta dos Santos", email: "GRR20190225"),
    (name: "Leonardo de Andrade Santos", email: "GRR20196154"),
  ),
)

= Pontos Escolhidos

Para a execução dessa tarefa, em primeiro lugar foi necessário escolher um cenário para o projeto de comunicação de rádio enlace. O cenário escolhido foi considerando a casa de um dos integrantes do grupo, sendo ele em São Gabriel um bairro de Colombo, e como segundo ponto foi escolhido um ponto aleatório no centro de Curitiba. A @pontos mostra os pontos que foram detalhados acima.

#figure(caption: [Pontos escolhidos], image("pontos.png", width: 40%))<pontos>

Analisando a @topologia, que demonstra a topologia do terreno, foi possível enxergar que não há a necessidade implementar múltiplos enlaces ponto-a-ponto, apenas um enlace já atende a condição de linha de visada. 

#figure(caption: [Topologia do terreno], image("topologia.png", width: 70%))<topologia>

= Escolha de equipamento

A partir dos pontos escolhidos, em sequência é necessário escolher os equipamento que irão realizar a comunicação entre eles. Para essa escolha foi feita uma comparação entre as antenas de 2.4 GHz com as de 5 GHz, e foi notável que a taxa de transmissao foi maior para uma frequência de 5 GHz. Sendo assim, a escolha foi limitada para as antenas que trabalham nessa frequência, dentro dec todos os modelos o escolhido foi o *_PowerBeam 5AC 400 ISO_*. Dentro das opções de configuração do equipamento, foi optado por um _Channel Width_ de 80 MHz com uma potência de 25 dBm. Essas opções foram escolhidas devido a elas propriciarem uma maior taxa de transmissão.

= Posicionamento das antenas

Tendo os pontos e o equipamento definidos, e realizando uma análise da topologia do terro através da @topologia foi possível visualizar a presença de uma elavação no terreno no ponto de Colombo, e então foi optado por posicionar a antena sobre ela. Já para o ponto de Curitiba, não foi necessário um reposicionamento da antena

= Fotos do relevo

O ponto de master1 e estation1 estão ilustrados pelas @svgato e @svcasa respectivamente.

#figure(caption: [Street view station1 ], image("svgato.png", width: 70%))<svgato>

#figure(caption: [Street view master1], image("svcasa.png", width: 70%))<svcasa>
= Fotos de Satélite 
As imagens de satelite do master1 e estation1 estão ilustrados pelas @estation1satelite e @master1satelite respectivamente:

#figure(caption: [Imagem satélite station1 ], image("estation1satelite.png", width: 70%))<estation1satelite>

#figure(caption: [Imagem satélite master1], image("master1satelite.png", width: 70%))<svcasa>


= Comparação da taxa de transmissão. 

Através de gráficos comparativos, avaliar como a taxa de transmissão do enlace é afetada pelas diferentes potências de transmissão e larguras de banda de operação configuráveis no equipamento. Traçar os seguintes gráficos:
== a) Fixando o menor valor de largura de banda de operação do equipamento, traçar o gráfico da taxa de transmissão em função da potência de transmissão.


#figure(caption: [Taxa de Transmissão na menor largura de banda], image("d.png", width: 70%))<d>


== b) Fixando o maior valor de largura de banda de operação do equipamento, traçar o gráfico da taxa de transmissão em função da potência de transmissão.

#figure(caption: [Taxa de Transmissão na maior largura de banda], image("a.png", width: 70%))<a>


== c) Para a potência máxima, traçar o gráfico da taxa de transmissão em função da largura de banda.

#figure(caption: [Taxa de Transmissão na maior potência de transmissão], image("c.png", width: 70%))<c>

== d) Para a potência mínima, traçar o gráfico da taxa de transmissão em função da largura de banda

#figure(caption: [Taxa de Transmissão na menor potência de transmissão], image("d.png", width: 70%))<d>