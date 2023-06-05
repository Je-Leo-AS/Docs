#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Etapa 3",
  authors: (
    "Leonardo de Andrade Santos - GRR20196154",
  ),
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

Com as etapas anteriores concluídas, foi possível realizar o casamento de impedância para as potências de entrada e saída do transistor escolhido. Para isso, utilizamos novamente a ferramenta da carta de Smith, tanto para a impedância de entrada quanto para a impedância de saída do nosso amplificador. Primeiramente, realizamos o cálculo do casamento para a entrada do amplificador. Importamos o arquivo .s2p do amplificador para o software da carta de Smith e selecionamos a frequência de atuação do amplificador (2.4 GHz). Ao importar esses dados, obtivemos um valor de impedância característica. Portanto, o casamento dessa impedância ocorrerá no complexo conjugado da mesma. O resultado desse casamento é ilustrado pela @inplane a seguir:

#figure(
  caption: [Carta de smith inplane],
  image("prints/inplane.jpg", width: 50%),
)<inplane>

Em seguida foram realizados os mesmos passos para o casamento de saida do amplificador cujo o resultado esta ilustrado pela @outplane a seguir:

#figure(
  caption: [Carta de smith outplane],
  image("prints/out.jpg", width: 50%),
)<outplane>

Então foi realizado a simulação no QUCs desses valores calculados, afim de comprova-los. Então foi desenvolvido o seguinte esquematico ilustrado pela @esquematico a seguito a seguir:

#figure(
  caption: [Esquematico no QUCs],
  image("prints/esquematico.png", width: 50%),
)<esquematico>

E o resultado obtido esta ilustrado pela @resultado a seguir:

#figure(
  caption: [Resultado da Simulação no QUCs],
  image("prints/resultado.png", width: 50%),
)<resultado>