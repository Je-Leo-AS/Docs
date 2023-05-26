#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Atividade 3",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)

Primeiramente foi adaptado o código da atividade 2 conforme ilustrado pela @code1 a seguir:

#figure(
  caption: [Código Atualizado],
  image("prints/code.png", width: 50%),
)<code1>

A partir disso foi calculado a matriz de coeficientes dos dados de validação e de extração:

#figure(
  caption: [Calculo das predições],
  image("prints/code1.png", width: 50%),

)<code2>

Em seguida foi calculado o valor do NMSE, cujo o resultado foi -22.62 dB utilizando o seguinte trecho de código ilustrado pela @code3 a seguir : 

#figure(
  caption: [Calculo calculo do nsme],
  image("prints/code3.png", width: 50%),
)<code3>

os resultados estão ilustrados pelas @resultado1 e @resultado2:  

#figure(
  caption: [Calculo calculo do nsme],
  image("prints/resultado1.png", width: 50%),
)<resultado1>

#figure(
  caption: [Calculo calculo do nsme],
  image("prints/resultado2.png", width: 50%),
)<resultado2>