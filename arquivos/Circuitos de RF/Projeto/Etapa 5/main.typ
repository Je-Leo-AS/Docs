#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Etapa 5",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)
#set math.equation(numbering: "(1)")
// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

Na etapa 5 foi feito a escolha do capacitor de RF que será utilizado no projeto. O capacitor escolhido foi o BB0502 de $100 n F$ oferecido pela oferecidos pela Presidio Components Inc, cujo o datasheete esta disponivel no #link("")[link a seguir] .


Em seguida foi feito a simulçao do circuito ilustrado pela a seguir


#figure(
  caption: [Esquematico no QUCs],
  image("prints/Qucs.png", width: 50%),
)<QUCS>

O resultado da simulação no QUCs é apresentado na @res abaixo:

#figure(
  caption: [Resultado da Simulção no QUCs],
  image("prints/resultado.png", width: 50%),
)<res>


Analisando o grafico da @res, é possivel ver que a atenuação resultando do capacitor na frequencia de operação é menor que 1 dB, portanto, despresivel.