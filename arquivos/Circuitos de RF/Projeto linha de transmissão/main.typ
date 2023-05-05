#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Projeto de linha de transmissão",
  authors: ("Leonardo Santos - GRR20196154"),
)


Para iniciar o exercicio foi calculado a largura da linha de transmissão e a constante de permissividade relativa, utilizando a ferramenta indicada pelo professor, conforme ilustrado pela @largura a seguir:

#figure(
  caption: [Calculo da largura e da constante de permissividade relativa],

  image("W.png", width: 50%),
)<largura>

Em seguida foram calculados os valores de comprimento da linha utilizando a carta de smith, conforme ilustrado pela @smith a seguir:

#figure(
  caption: [Calculo do comprimento das linhas de transmissão],

  image("smith.png", width: 80%),
)<smith>


Em seguida foi calculado o valor dos compenentes que simulam a carga de entrada do circuito.

Como a antena utilizada para esse projeto é do tipo C, então, tem-se que a impedancia dela é de $Z_L = 3,81 - 30,8571j Omega$.

Para simular a resistência foi utilizado um simples resistor de $3,81 Omega$.

Já para reatância, foi observado pelo sinal negativo se tratava de uma reatância capacitiva. Portanto a capacitância foi calculado da seguinte forma:

#align(center)[
  \
  $X_C = 1/(omega * C)$\
  \
  $C = 1/(2*pi*f_0*X_C)$\
  \
  $C = 5.16 p F $
  
]

Em seguida foi simulado o circuito no QUC's o qual o esquemático está ilustrado pela @esquematico a seguir:
#figure(
  caption: [Esquemático do QUCs],

  image("esquematico.png", width: 80%),
)<esquematico>

Observe que a o comprimento da malha em paralelo, sofreu um leve ajuste, pois foi observado que na frequencia desejada o circuito apresentava uma atenução de $-12 d B$ aproximadamente, e portanto não satisfazia os critérios esperados pelo circuito.

Então, realizando um ajuste fino de um dos comprimentos alcançou-se a atenuação de $-20 d B$, que é o comportamento esperado do circuito.

O resultado da simulação esta ilustrada pela @resultado a seguir:

#figure(
  caption: [Resultado da Simulação do QUCs],

  image("resultado.png", width: 80%),
)<resultado>


Em seguida foi dado inicio a etapa de projeto do circuito impresso.

A primeira etapa consistia no desenvolvimento do esquematico do circuito o qual esta ilustrado pela @esquematico_circuito a seguir: 

#figure(
  caption: [Esquemático da placa de circuito impresso],

  image("esquematico_circuito.png", width: 80%),
)<esquematico_circuito>


Em seguida foi feito o design propriamente dito da PCB, o qual esta sendo ilustrado pelas @2d e @3d a seguir:


#figure(
  caption: [Projeto da placa de circuito impresso],

  image("2d.png", width: 80%),
)<2d>

#figure(
  caption: [Imagem 3D da placa de circuito impresso],

  image("3d.png", width: 80%),
)<3d>

