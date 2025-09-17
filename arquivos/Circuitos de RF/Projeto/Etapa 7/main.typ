#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Etapa 7",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)

A etapa 7 consisitia em simular o circuto adapatado na etapa 6 com os capacitores escolhidos na etapa 5, sendo assim o seguinte esquematico no QUCs, ilustrado pela @QUCs foi desenvolvido:

#figure(
  caption: [Esquematico no QUCs],
  image("prints/Qucs.png", width: 50%),
)<QUCs>

Realizando a simulação chegou-se no seguinte resultado ilustrado pela @resultado a seguir

#figure(
  caption: [Resultado da Simulação],
  image("prints/resultado.png", width: 50%),
)<resultado>
OBS: embora não esteja evidênciado no gráfico a atenuação do Parâmetro $S_22$ foi de -27.4 dB.

#figure(
  caption: [Resultado da Simulação etapa 6],
  image("prints/resultado6.png", width: 50%),
)<resultado6>

Analisando a o gráfico da @resultado é possivel ver que houve uma atenuação de 0.24 dB com o parâmetro do casamento de impedância, que é a perda próxima da simulada na etapa 5. Observou-se também um ganho nos demais parametros S, mas que não chegam a descaracterizar o filtro. 