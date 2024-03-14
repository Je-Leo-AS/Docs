#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Atividade 5",
  authors: ("Leonardo Santos - GRR20196154",),
)

Essa etapa consiste no desenvolvimento do modelo do predistorcedor digital.

Para isso inicialmente e feito o mesmo processo para realização do modelo do PA, porem com as entradas e saidas trocadas, conforme ilustrado pela @code, em valores com virgula flutuante.


#figure(
  caption: [Código do para modelo do predistorcedor em virgula flutuante],
  image("./prints/code.png", width: 50%),
)<code>

E o resultado dessa etapa esta ilustrado pela @output a seguir:

#figure(
  caption: [Gráficos entrada e saída em virgul flutuante],
  image("./prints/output.png", width: 50%),
)<output>

Portanto observa-se que a saida do prédistorcedor esta conforme o esperado. Em seguida foram realizados os calculos com os valores para virgula fixa que pode ser utilizando as funções desenvolvidas nas ultima atividade, conforme ilustrado pela @code1 a seguir.

#figure(
  caption: [Código para modelo do predistorcedor em virgula fixa],
  image("./prints/code1.png", width: 50%),
)<code1>

E o resultado dessa implementação esta ilustrado pela @output1 a seguir:

#figure(
  caption: [Gráficos entrada e saída em virgula fixa],
  image("./prints/output1.png", width: 50%),
)<output1>

Em seguida foi feito a simulação do predistorcedor tanto para virgula fixa,com uma resolução de 10 bits, quanto para virgula flutuante cujos os resultados estão ilustrados pelas @output3, @output2 a seguir:



#figure(
  caption: [Gráficos entrada e saída em virgula flutuante simulado],
  image("./prints/output3.png", width: 50%),
)<output3>

#figure(
  caption: [Código para modelo do predistorcedor em virgula fixa simulado],
  image("./prints/output2.png", width: 50%),
)<output2>
