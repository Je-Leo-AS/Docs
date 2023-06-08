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
  image("prints/code2.png", width: 50%),
)<code2>

Em seguida foram feitos os calulos utilizando os valores do extraidos e normalizados que correspoderam a -21dB.


Em seguida foi realizados os passos do item 3, na etapa do item a) observou-se que o maior valor, depois da conversão para um numero inteiro foi de 15, enquanto para a proxima etapa do item b) na etapa de readequação o maior valor foi arendondado para 0. A figura @code3 ilustra a o codigo utilizado:



#figure(
  caption: [Calculo da precisão em bits],
  image("prints/code3.png", width: 50%),
)<code3>

Estou com dificuldade nessa etapa!