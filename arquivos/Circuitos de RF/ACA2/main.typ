#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "ACA2",
  authors: ("Leonardo Santos - GRR20196154",),
)


Conforme solicitado pelo roteiro, foi realizada a simulação do divisor de potência apresentado no slide 08 do capítulo 06, cujo esquemático está disponível a seguir na @esquematico.

#figure(
  caption: [Esquemático do Slide],

  image("Figuras/Esquematico.png", width: 50%),
)<esquematico>

Inicialmente, as larguras e comprimentos da linha de transmissão foram calculados utilizando a calculadora do QUCs. O resultado está disponível na @Calculadora a seguir.


#figure(
  caption: [Calculadora do QUCs],

  image("Figuras/Calculadora.png", width: 50%),
)<Calculadora>

Em seguida foi desenvolvido o circuito esquematico no QUCs conforme ilustrado pela  @Qucs a seguir:

#figure(
  caption: [Circuito simulado no QUCs],

  image("Figuras/Qucs.png", width: 50%),
)<Qucs>


Os resultados da simulação do circuito utilizando o @Qucs são ilustrados abaixo pela @Resultado:

#figure(
  caption: [Resultado do circuito simulado no QUCs],

  image("Figuras/Resultado.png", width: 50%),
)<Resultado>

Ao analisar os gráficos, fica perceptível que eles coincidem com o que é teoricamente esperado.

#align(center)[
$|S| = -j/sqrt(2) mat(0,1,1;1,0,0;1,0,0)$ <eq1>
]
Na frequência de 2,4 GHz, os parâmetros $S_11$, $S_22$ e $S_32$ tendem a zero, indicando uma perda abaixo de -40 dB, enquanto os parâmetros $S_21$ e $S_31$ apresentam uma perda próxima a -3 dB.
#align(center)[
$|S_21| = |S_31| = 20 log(1/sqrt(2))$

$|S_21| = |S_31| = -3.01 d B$
]
Portanto, notou-se que o circuito apresentou o comportamento desejado.
