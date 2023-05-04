#import "template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "AT07",
  authors: (
    "Leonardo Santos - GRR20196154",
  ),
)

A primeira etapa do exercicio foi calcular a equação do divisor de tensão do circuito ilustrado @esquematico a seguir

#figure(
  image("esquematico.png", width: 80%),
  caption: [
   esquematico do circuito 
],
)<esquematico>

Portanto tem-se:

#align(center)[
  $V_2 = V * (R_2 || Z_2)/(R_1 + Z_1 + (R_2 || Z_2))$\
  \
  
]
Sabe-se que:

#align(center)[
  $Z_1 - R_1 = (R_2 || Z_2)$\
  \
  
]

Logo:

#align(center)[
  $V_2 = 2V_0 *  Z_1/ (Z_1 - R_1)$ <eq1>
]

Sabe-se pelo slide 09 do capitulo 3 que:

#align(center)[
  $S_31 = [2V_3/V sqrt(Z_1/Z_2)]$\
]
Porém como busca-se o parametro $S_21$:


#align(center)[
  $S_21 = [(2V_0)/V_2 sqrt(Z_1/Z_2)]$ \
]
Agora substituindo  as equações tem-se :

#align(center)[
  $S_21 = [(2V_0)/(2V_0 * Z_1) / (Z_1 - R_1) sqrt(Z_1/Z_2)]$ \
  \
  $S_21 = [ (Z_1 - R_1)/(Z_1)  sqrt(Z_1/Z_2)]$<eq2> \
]

Substituindo o valor de $R_1$:


#align(center)[
  $S_21 = [(Z_1 - Z_1(sqrt(1-Z_2/Z_1)))/(Z_1)  sqrt(Z_1/Z_2)]$\
  \
  $S_21 = [(1 - sqrt(1-Z_2/Z_1)) sqrt(Z_1/Z_2)]$ \
\
    $S_21 = a = [sqrt(Z_1/Z_2) - sqrt(Z_1/Z_2- 1)]$ \
]