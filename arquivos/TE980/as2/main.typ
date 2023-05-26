#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Projeto de linha de transmissão",
  authors: ("Leonardo Santos - GRR20196154",),
)

= A)
Para realizar essa simulação foi optado em utilizar o exemplo disponibilizado pelo Matlab.

Primeramente foram ajustados o waypoints, de forma a realizar a trajetoria retangular conforme ilutrada pela @coderetangular a seguir

#figure( 
  caption: [Codigo da trajetória retangular],
  image("figuras/coderetangular.png", width: 50%), 
)<coderetangular>

Realizando a simulção chegou-se no seguinte resultado:

#figure( 
  caption: [trajetória retangular],
  image("figuras/trajetoriaretangular.png", width: 50%), 
)<trajetoriaetangular>

Após isso foi adaptado o código de forma a relizar a trajetória, o qual está ilustrado pela @codecircular a seguir. 

#figure( 
  caption: [Codigo da trajetória retangular],
  image("figuras/codecircular.png", width: 50%), 
)<codecircular>

Em seguida foi feito a trajetoria circular do o resultado esta ilustrado pela @trajetoriacircular a seguir.

#figure( 
  caption: [Trejatória Circular],
  image("figuras/trajetoriacircular.png", width: 50%), 
)<trajetoriacircular>

= B
Pode se dizer que o erro médio de cada modelo(MSE), é a distancia média de cada modelo para o poligono definido pelos waypoints. 
Sendo assim para fazer esse calculo foi feito um ajuste no codigo de forma o numero de amostras simuladas fosse que o mesmo numero de pontos presentes nos waypoints. Então foi calculado o erro médio. Para isso foi feito os seguintes trechos de código, que estão sendo ilustrados pelas @codeMSEret, @codeMSEretbi, @codeMSEretdiff a seguir, 


#figure( 
  caption: [MSE retangular uniciclo],
  image("figuras/codeMSEretuni.png", width: 50%), 
)<codeMSEret>


#figure( 
  caption: [MSE retangular uniciclo],
  image("figuras/codeMSEretbi.png", width: 50%), 
)<codeMSEretbi>

#figure( 
  caption: [MSE retangular uniciclo],
  image("figuras/codeMSEretdiff.png", width: 50%), 
)<codeMSEretdiff>

E com isso chegou-se aos seguintes valore de MSE:

#align(center)[
$"MSE"_"uni" = 5.91$
\
$"MSE"_"bi" = 6.3$
\
$"MSE"_"dif" = 5.83$
]

Portanto, podemos realizar uma suposição de que o movimento dos três  modelos não estão sendo limitados pela velocidade angular maxima. Apesar dos resultadoe é visivel que o modelo diferencial é oque apresenta o melhor comportamento em curvas perpendiculares, o que é observado na @trajetoriaetangular.

Em seguida foi realizado o mesmo processo para a trajtória circular, onde foi calculado MSEs muito próximos de zero, o que era de se esperar visto que a varição da direção é constante. E portanto a velocidade angular também nao influencia no desempenho de cada modelo.