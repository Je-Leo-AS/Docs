#import "template.typ": *
// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Atividade 5",
  authors: (
    "Leonardo Santos - GRR20196154",
  ),
)

Primeiramente foram encontrados os parametros g seguindo como referência a tabela da @tabela.

#figure(
  image("tabela1.png", width: 80%),
  caption: [
   Tabela com os coeficientes do filtro Chebyshev para 0,5 dB em função da sua ordem (N = 1 a 10). 
],
)<tabela>

Portanto tem-se os seguintes valores de g para o filtro de terceira ordem:
#align(center)[
  g0 = 1;\
  g1 = 1,5963;\
  g2 = 1,0967;\
  g3 = 1,5963;\
  g4 = 1; \
]

Em seguida foram calculados os parâmetro $k_"nm"$:

#align(center)[
$k_01 = sqrt(pi/2 "BW"/omega_0 1/(g_0g_1))$\

$k_01 = 0,4436$\

$k_12 = pi/2 "BW"/omega_0 1/sqrt(g_0g_1)$\

$k_12 =  0,2486$

$k_01 = sqrt(pi/2 "BW"/omega_0 1/(g_0g_1))$\

$k_23 = k_12 = 0,2486$\

$k_34 = k_01 = 0,4436 $\
]

Com os valores do parametros k calculados foram então calculados as impedancias da linha acoplados.

#align(center)[
  $Z_"01o" = Z_0*(1 - k_01 + k_01^2)$\
  $Z_"01o" = 37,66 Omega $\
  \
  $Z_"01e" = Z_0*(1+k_01+k_01^2)$\
  $Z_"01e" = 82,022 Omega$\
  \
  $Z_"12o" = Z_0*(1-k_12+k_12^2)$\
  $Z_"12o" = 40,66 Omega$\
  \
  $Z_"12e" = Z_0*(1+1-k_12+1-k_12**2)$\
  $Z_"12e" = 65,52 Omega$\
  \
  $Z_"23e" = Z_"12o" = 40,66 Omega$\
  \
  $Z_"23e" = Z_"12e" = 65,52 Omega$\
  \
  $Z_"34o" = Z_"01o" = 37,66 Omega$\
]

Com isso é possivel calcular as dimensões fisicas da linha de transmissão utilizando a calculado do QUCS conforme mostrado pelas @ext e @inte a seguir:

#figure(
  image("linha extremidade.png", width: 80%),
  caption: [
   Parâmetros físicos das linhas da extremidade. 
],
)<ext>


#figure(
  image("linha intermediaria.png", width: 80%),
  caption: [
   Parâmetros físicos das linhas intermediária. 
],
)<inte>


Com isso tem-se os seguintes valores de largura e comprimento:

#align(center)[

  $ W_01 = W_34 = 1.01381 "mm"$\
  $ W_12 = W_23 = 1.30247 "mm"$\
  $ S_01 = S_34 = 0.1147 "mm"$\
  $ S_12 = S_23 = 0.3459 "mm"$\
  $ L_01 = L_34 = 17.869 "mm"$\
  $ L_12 = S_23 = 17.249 "mm"$\
]

Com esses valores ja é possivel desenvolver o esquematico no QUCS, conforme ilustrado pela @Esq a seguir:

#figure(
  image("esquematico.png", width: 80%),
  caption: [
   Esquematico do circuito no QUCS. 
],
)<Esq>
\
\
\
E o resultado obtido esta ilustrado pela @Res a seguir:

#figure(
  image("resultado_sim.png", width: 80%),
  caption: [
   Resultado da Simulação. 
],
)<Res>
