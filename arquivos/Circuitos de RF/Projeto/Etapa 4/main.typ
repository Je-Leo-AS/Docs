#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Etapa 4",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)
#set math.equation(numbering: "(1)")
// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

Nessa etapa foi combinado o circuito polarização do circuito com o com as seções de transformação de impedância de entrada e de saída do amplificador usando filtros rejeita-faixa e capacitores de desacoplamento.

O filtro reijeta faixa escolhido é o mesmo do roteiro então ele emprega dois trechos de linha de transmissão com um quanto do comprimento de onda conform ilustrado pela @esquematico a seguir:

#figure(
  caption: [Esquematico],
  image("print/Esquematico.png", width: 50%),
)<esquematico>

Neste esquemático, quando a impedância $Z_L$ é terminada em circuito aberto, ela transforma uma impedância infinita em uma impedância nula. Por outro lado, o trecho com a impedância $Z_H$ transforma uma impedância nula em uma impedância infinita. Essas características permitem que o filtro seja conectado em paralelo em qualquer ponto do circuito do amplificador.

Considerando $Z_L = Z_H = Z_0 = 50 ohm$ e que a largura da linha de transmissão é aproximadamente 1.5 mmm o comprimento de onda deve ser igual a 1/4 do comprimento de onda na frequencia de operação, para fazer esse calculo, tem-se:

$d = 1/(4*f*sqrt(u_0*epsilon_0*epsilon_r))/
/
d = 17.0mm$
