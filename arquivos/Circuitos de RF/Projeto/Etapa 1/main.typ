#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Etapa 1",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!


Para o desenvolvimento desse projeto foi escolhido o Transistor  #link("https://www.mpulsemw.com/Pdf_files/MP42141.pdf")[MP42141], cujo o datasheet esta disponivel no link do nome, em aplicações de IoT.

Observou-se que, quando ele esta polarizado com uma corrente de $I_c = 5m A$ e uma tensão $V_"CE" = 10 V$ o parametro $h_"FE"$ e 125, portanto esses foram os valores selecionados para  utilizar como referência para a tabela de parametro de espelhamento.

A partir dela foi gerado o arquivo .s2p o qual esta ilustrado pela @s2p a seguir:

#figure(
  caption: [Tabla .s2p],
  image("prints/s2p.png", width: 50%),
)<s2p>

Em seguida foi importado esse arquivo para dentro da carta de smith, que deram os resultados ilustrados pela @csmith a seguir:

#figure(
  caption: [Graficos da Carta de Smith],

  image("prints/carta de smith.png", width: 50%),
)<csmith>

A partir da tabela de ganho ilustrada pela @ganho, foi possivel selecionar a frequência de operação do transistor. Foi optado em utilizar a frequência de 2.4GHz pois apresenta um ganho e uma estabilidade razoavel $K<1$.

#figure(
  caption: [Tabela de Ganho],

  image("prints/ganho.png", width: 50%),
)<ganho>
