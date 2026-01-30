#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Atividade 4",
  authors: ("Leonardo Santos - GRR20196154",),
)

Primeiramente foi realizada a normalização dos dados, utilizando esse trecho de código ilustrado pela @code a seguir:
#figure(
  caption: [Código de normalização dos dados],
  image("prints/code.png", width: 50%),
)<code>
Em seguida foi utilizado o trecho de codigo para avaliar se osvalores se encotravam entre os valores de -1 e 1. O resultado esta ilustrado pela @output a seguir:

#figure(
  caption: [Gráficos entrada e saída],
  image("prints/output.png", width: 50%),
)<output>

Com os dados normalizados foi realizado a estração dos coeficientes, utilizando o seguinte trecho de código ilustrado pela @code1 a seguir: 


#figure(
  caption: [Calculo das matrizes de Coeficientes],
  image("prints/code1.png", width: 50%),
)<code1>

Em seguida foi realizado a extração da matriz XX de validação, com a vírgula fixa utilizando o seguinte trecho de codigo ilustrado pela @code2. 

#figure(
  caption: [Função que realiza o cálculo da matriz XX inteira],
  image("prints/code2.png", width: 50%),
)<code2>

e tambem foram desenvolvido a função que realiza a multiplicação de matrizes de numeros inteiros imaginarios conforme ilustrado @code3 a seguir:

#figure(
  caption: [Função que realiza o cálculo da matriz XX inteira],
  image("prints/code3.png", width: 50%),
)<code3>

Os resultados de MNSE e numeros de bits estão ilustrados pela @print a seguir:

#figure(
  caption: [Resultado NMSE],
  image("prints/print.png", width: 50%),
)<print>

E os graficos resultantes estão disponveis pelas @resultado1 @resultado2 a seguir:

#figure(
  caption: [Grafico 1],
  image("prints/resultado1.png", width: 50%),
)<resultado1>

#figure(
  caption: [Grafico 2],
  image("prints/resultado2.png", width: 50%),
)<resultado2>
