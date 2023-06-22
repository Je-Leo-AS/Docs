#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "1.template",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)

A etapa 7 consisitia em simular o circuto adapatado na etapa 6 com os capacitores escolhidos na etapa anterior, sendo assim o seguinte esquematico do QUCs, ilustrado pela @QUCs foi desenvolvido:

#figure(
  caption: [Esquematico no QUCs],
  image("prints/Qucs.png", width: 50%),
)<QUCs>

Realizando a simulação chegou-se no seguinte resultado ilustrado pela @resultado a seguir

#figure(
  caption: [Resultado da Simulação],
  image("prints/resultado.png", width: 50%),
)<resultado>
OBS: embora nao esteja evidenciado no grafico a atenuação do Parametro $S_22$ foi de -27.4 dB.

Analisando a o grafico da @resultado é possivel ver que houve uma atenuação de 0.14 dB com o parametro do casamento de impedância, que é a perda proxima da simualada na etapa 5. Além de tambem de um ganho nos demais parametros S, mas que não chegam a descaracterizar o filtro.