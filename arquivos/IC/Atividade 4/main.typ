#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Atividade 4",
  authors: ("Leonardo Santos - GRR20196154",),
)

Primeiramente foi feito a normalização dos dados, utilizando esse trecho de código ilustrado pela @code a seguir:
#figure(
  caption: [Código de normalização dos dados],
  image("prints/code.png", width: 50%),
)<code>
Em seguida foi utilizado o trecho de código ilustrado pela @code1, para avaliar se osvalores se encotravam entre os valores de -1 e 1. O resultado esta ilustrado pela @output a seguir:

#figure(
  caption: [Código pra plotar gráficos de entrada e saída],
  image("prints/code1.png", width: 50%),
)<code1>

#figure(
  caption: [Gráficos entrada e saída],
  image("prints/output.png", width: 50%),
)<output>

Com os dados normalizados foi feito a matriz de coeficientes, utilizando o seguinte trecho de código ilustrado pela @code2 a seguir: 


#figure(
  caption: [Calculo das matrizes de Coeficientes],
  image("prints/code22.png", width: 50%),
)<code2>

Em seguida foi feito o calculo da adequeação e da multiplicação de matrizes utilizando esses trechos de código:

#figure(
  caption: [Calculo da precisão em bits],
  image("prints/code31.png", width: 50%),
)<code3>

Porém o resultado obtido não foi o esperado!