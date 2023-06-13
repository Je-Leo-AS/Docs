#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Etapa 2",
  authors: (
    "Leonardo de Andrade Santos - GRR20196154",
  ),
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

Como o transistor escolhido na etapa anterior foi um #link("https://www.mpulsemw.com/Pdf_files/MP42141.pdf")[MP42141] que se trata de um transistor BJ, NPN, logo tem-se circuito de polariazação ilustrado pela @pol a seguir:


#figure(
  caption: [Circuito de Polarização],
  image("prints/pol.png", width: 50%),
)<pol>

De acordo com o datasheet, temos que no ponto de polarização de $V_"CE" = 10 V$ e $I_c = 5m A$ o valor tipico de $h_"FE"=β=125$. O valor de $V_"BE"$ não consta no datasheet, então por se tratar de um TBJ de silicio, irei considera-lo 0,7 V.

Considerando a tensão $V_"cc"$ igual a 12V e aplicando a lei das malhas tem-se:

#align(center)[
  $V_"cc" - R_C(I_C + I_B) - V_"CE" = 0$\
  \
  $V_"CE" - R_B*I_B - V_"BE" = 0$
]
Sabe-se que $I_B = I_C/h_"FE"$ tem-se:


#align(center)[
  $R_B = h_"FE" * (V_"CE" + V_"BE")/ I_C = 232500 ohm approx 240k ohm $\ 
  \
  $R_C = h_"FE" /(h_"FE" + 1) (V_"cc" + V_"CE")/ R_C =396 ohm approx 390 ohm $ 
]
Afim de fazer validação dos valores calculados de $R_B$ e $R_C$, foi calculado a corrente e a tensão em função desses valores.

#align(center)[
  $V_"cc" - R_C(I_C + I_B) - V_"CE" = 0$\
  \
  $V_"CE" - R_B*I_B - V_"BE" = 0$\
  \
]

Isolando o $I_C$ tem-se:


#align(center)[
  $I_C = (V_"cc" - V_"BE")*h_"fe"/(R_B+R_C*(h_"FE" + 1))$\
  \
  $I_C approx 4.8 m A$  
]

Realizando o mesmo processo para  $V_"CE"$ tem-se:
#align(center)[

  $V_"CE" - R_B*I_B - V_"BE" = 0$\
  \
  $V_"CE"=  R_B*I_B + V_"BE" $\
  \
  $V_"CE"=  R_B*I_C/h_"FE" + V_"BE" $\
  \
  $V_"CE" approx 10.08 V$ 

]
Analisando os resultados nota-se que ouve uma pequena variação menor que 5% o que é desejado para esse circuito.
