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

O filtro reijeta faixa escolhido é o mesmo do roteiro então ele emprega dois trechos de linha de transmissão com um quanto do comprimento de onda conform ilustrado pela @filtro a seguir:

#figure(
  caption: [Topologia do Filtro],
  image("print/Esquematico.png", width: 50%),
)<filtro>

Neste esquemático, quando a impedância $Z_L$ é terminada em circuito aberto, ela transforma uma impedância infinita em uma impedância nula. Por outro lado, o trecho com a impedância $Z_H$ transforma uma impedância nula em uma impedância infinita. Essas características permitem que o filtro seja conectado em paralelo em qualquer ponto do circuito do amplificador.

Considerando $Z_L = Z_H = Z_0 = 50 ohm$ e que a largura da linha de transmissão é aproximadamente 1.5 mmm o comprimento de onda deve ser igual a 1/4 do comprimento de onda na frequencia de operação, para fazer esse cálculo, tem-se:

$ d = 1/(4*f*sqrt(u_0*epsilon_0*epsilon_r))\
\
d = 17.0 m m $ <eq17>

Em seguida, procedeu-se com a seleção do capacitor e o cálculo de sua impedância. Optou-se por utilizar um capacitor de $10 n F$, uma vez que seu valor não é muito alto e sua impedância é significativamente menor que $50 ohm$.

Posteriormente, o esquemático foi desenvolvido no QUCs, conforme ilustrado pela @QUCS abaixo:

#figure(
  caption: [Esquematico no QUCs],
  image("print/Qucs.png", width: 50%),
)<QUCS>

O resultado da simulação no QUCs é apresentado na @res abaixo:

#figure(
  caption: [Resultado da Simulção no QUCs],
  image("print/resultado.png", width: 50%),
)<res>

Ao comparar os resultados dessa simulação com a simulação sem o filtro, observou-se uma leve atenuação no parâmetro $S_{21}$, porém ela foi considerada insignificante e, portanto, foi desprezada.