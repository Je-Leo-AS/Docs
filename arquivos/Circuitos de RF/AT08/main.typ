#import "template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "AT08",
  authors: (
    "Leonardo Santos - GRR20196154",
  ),
)
Para essa atividade foi desenvolvido o circuito do slide 18 do capitulo 6, o qual esta ilustrado pela @Esquematico a seguir:


#figure(
  caption: [Esquematico do Slide],

  image("Figuras/Esquematico.png", width: 50%),
)<Esquematico>

Portanto a primeira etapa consistia em encontrar os valores de $Z_p$ e $Z_r$. Para isso foi primeiramente calculado o fator de acoplamento em ($C$) em escala linear ($c$).

#align(center)[
$C = 20 * log(c)$

$c = 0,7$

$(Z_0/Z_p)^2 = c^2/ (1 - c^2)$

$(Z_0/Z_r)^2 = 1 + (Z_0/Z_p)^2$

$Z_p = Z_0/sqrt(c^2/(1 - c^2)) $

$Z_p  = 49.88141725554918$

$Z_r =  Z_0/sqrt(1 + c^2/ (1 - c^2))$

$Z_r = 35.31333906517224$
]

Em seguida foi utilizado a calculadora do QUCs para calcular as dimensões das linhas de trasmissões os quais os resultados estão ilustradas pelas @Calculadorazr e @Calculadorazp a seguir:


#figure(
  caption: [Calculadora das dimensões da impedância Zr],

  image("Figuras/Calculadorazp.png", width: 50%),
)<Calculadorazp>

#figure(
  caption: [Calculadora das dimensões da impedância Zp],

  image("Figuras/Calculadorazr.png", width: 50%),
)<Calculadorazr>


Em seguida foi desenvolvido o esquematico no QUCs ilustrado pela @QUCs a seguir:


#figure(
  caption: [Esquematico no QUCS],

  image("Figuras/QUCs.png", width: 50%),
)<QUCs>


Após isso foi feito a simulação do circuito o qual o resultado esta ilustrado pela @Resultado a seguir

#figure(
  caption: [Resultado da simulação],

  image("Figuras/Resultado.png", width: 50%),
)<Resultado>

A partir desses resultados é possivel notar que as os parâmetros $S_11$, $S_22$ e $S_32$ tendem a zero na frequência de $2,4 G H z$, enquanto o parâmetro $S_21$ tende a $-3 d B$ ou $-1/sqrt(2)$ em escala linear.

Esse resultado se confirma quando analisamos a matriz de espelhamento completa para o caso específico doacoplador direcional ramificado:

#align(center)[
$S = mat(
  delim: "[",
  0, -j sqrt(1-c^2), -c, 0;
  -j sqrt(1-c^2), 0, 0, 0;
  -c, 0, 0, -j sqrt(1-c^2);
  0, -c, -j sqrt(1-c^2), 0;
  )\$]

#align(center)[ 
  $S = mat(
  delim: "[",
  0, -j/sqrt(2), -1/sqrt(2), 0;
  -j/sqrt(2), 0, 0, 0;
  -1/sqrt(2), 0, 0, -j/sqrt(2);
  0, -1/sqrt(2), -j/sqrt(2), 0;
  )$]





