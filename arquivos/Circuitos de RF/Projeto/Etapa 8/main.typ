#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Etapa 8",
  authors: (
    "Leonardo de Andrade Santos",
  ),
)

Com isso conclui-se o projeto cujo o esquemático do QUCs e o resultado simulado estão ilustrados pelas @QUCs e @resultado a seguir:

#figure(
  caption: [Esquematico no QUCs],
  image("prints/Qucs.png", width: 50%),
)<QUCs>

#figure(
  caption: [Resultado da Simulação],
  image("prints/resultado.png", width: 50%),
)<resultado>

E a placa de circuito impresso resultante está ilustrada pela @circuito a seguir:

#figure(
  caption: [Circuito EasyEda],
  image("prints/circuito.png", width: 50%),
)<circuito>

#figure(
  caption: [Resultado da Simulação da etapa 4],
  image("prints/resultado4.png", width: 50%),
)<resultado4>

Comparando com os resultados com os obtidos na etapa 4 ilustrado pela @resultado4, nota-se que houve uma atenuação devido a adição do filtro mas principalmente pela adição dos capacitores, e portanto, para diminuir essa atenuação, uma solução seria mudar os capacitores, e por isso não foi feito um redimensionamento das linhas de transmissão, uma vez que a atenuação da mesma foi bem pequena. 
