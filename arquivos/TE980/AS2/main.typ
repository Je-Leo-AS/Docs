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

= B)

