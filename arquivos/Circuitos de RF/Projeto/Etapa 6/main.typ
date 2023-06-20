#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "1.template",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)


Para o inicio da etapa 3 foi primeiramente adaptado o projeto no QUCs de forma a deixa-lo mais facil de faze-lo em uma placa de circuito impresso.

Portanto realisou-se as seguintes adaptações no esquematico do projeto, ilustrados pela figura @QUCS:

#figure(
  caption: [Esquematico no QUCs],
  image("prints/Qucs.png", width: 50%),
)<QUCS>

Analisando a figura notouse que foram adicionados alguns trechos de linha de transmissão afim de facilitar o desenvolvimento da placa, cujo o resultado da simulção esta ilustrado pela @resultados a seguir:

#figure(
  caption: [Resultados da simulação],
  image("prints/resultados.png", width: 50%),
)<resultados>

Comparando com o resultado da etapa 4 ilustrado pela @resultadopassado, é notavel que houve uma distoção dos parametros S nas frequencias de operação alem de uma leve atenuação de 0.02 dB no parametro $S_21$, alem de um ganho de nos parametrs $S_11$ e $S_22$, mas que não chegam a ser significativamente prejudiciais ao filtro.

#figure(
  caption: [Resultados da simulação da etapa 4],
  image("prints/resultadopassado.png", width: 50%),
)<resultadopassado>

Em seguida foi desenvolvido o projeto do circuito impresso utilizado o software EasyEda o qual está ilistrado pela @circuito a seguir:

#figure(
  caption: [Circuito EasyEda],
  image("prints/circuito.png", width: 50%),
)<circuito>

Note que foi adicionado uma linha de transmissão acoplada na simulação do QUCs de forma a simular a os trechos em paralelo. 

