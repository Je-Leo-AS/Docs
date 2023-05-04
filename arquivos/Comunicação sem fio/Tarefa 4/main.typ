#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Exercicio 4 ",
  authors: (
    "Leonardo de Andrade Santos", "Audric Costacurta dos Santos",
  ),
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= A) Utilizando o software Matlab, traçar o gráfico da curva teórica de desempenho da modulação BPSK (2-PSK). O eixo x deve ser a relação sinal-ruído (Eb/N0) em escala de dB, na faixa de -2 dB a 15 dB. O eixo y deve ser a probabilidade de erro de símbolo (bit) na faixa de 10−8
\
Para isso foi desenvolvido o seguinte trecho de código ilustrado pela @teoricabpsk a seguir:

#figure(caption:[Curva teórica da simulação BPSK], 
image("teoricabpsk.png", width: 80%),
)<teoricabpsk>

O resultado da simulação esta ilustrado pela @curvabpsk a seguir:
#figure(caption:[Curva teórica da simulada BPSK], 
image("curvabpsk.png", width: 80%),
)<curvabpsk>



= b) Simular uma modulação BPSK (2-PSK) usando a técnica de Monte Carlo para estimar a probabilidade de erro de bit (BER) para as seguintes relações sinal-ruído (Eb/N0): 2 dB, 5 dB, 8 dB e 10 dB.
\
Foi desenvolvido o seguinte código ilustrado pelas @codMCBPSK e @PARbpsk:
#figure(caption:[Código da simulação MonteCarlor BPSK], 
image("codbpsk.png", width: 80%),
)<codMCBPSK>

Em seguida foi feito a simulação utilzando os seguintes parâmetros:
#figure(caption:[Parâmetros da simulação BPSK], 
image("paramtrosbpsk.png", width: 80%)
)<PARbpsk>

= c) Plotar os pontos simulados do item b) juntamente com a curva teórica de desempenho da modulação do item a).
\
Realizando simulação chegou-se no seguinte resultado:

#figure(caption:[Resultado da simulação MonteCarlor BPSK], 
image("simulaçãobpsk.png", width: 80%),
)

Analisando o gráfico é possivel ver que os resultados simulados e calculados da curva teórica são bem semelhantes, ou seja, estam bem próximos do esperado.


= d) Simular uma modulação 8-ASK (polar) usando a técnica de Monte Carlo para estimar a probabilidade de erro de símbolo (SER) para as seguintes relações sinal-ruído (Eb/N0): 0 dB, 5 dB, 10 dB e 15 dB
\
Para iniciar essa etapa foi feito o calculo da curva teórica do 8ASK, cujo o código esta ilustrado pela @teorica8ask a seguir:
#figure(caption:[Código da simulação 8 ASK], 
image("teorica8ask.png", width: 80%)
)<teorica8ask>
Em seguida foi feito o código da simulação do de MonteCarlo do 8ASK, cujo o cpodigo esta disponibilizado pela @cod8ask a seguir:

#figure(caption:[Código da simulação 8 ASK], 
image("cod8ask.png", width: 80%)
)<cod8ask>


= e) Plotar os pontos simulados juntamente com a curva teórica de desempenho
\
Em seguida foi feito a simulação utilizando os seguintes parâmetros;

#figure(caption:[Código da simulação 8ASK], 
image("cod8ask.png", width: 80%)
)

Em seguida foi feito plotagem das curvas, as quais estão ilustradas pela @Resultado8ask, a seguir:
\
#figure(caption:[Resultado da simulação 8 ASK], 
image("simulação8ask.png", width: 80%)
)<Resultado8ask>

Conforme o esperado as curvas ficaram bem próximas.
= f) Simular uma modulação 16-QAM usando a técnica de Monte Carlo para estimar a probabilidade de erro de símbolo (SER) para as seguintes relações sinal-ruído (Eb/N0): 0 dB, 5 dB, 10 dB e 12 dB.

= g) Plotar os pontos simulados juntamente com a curva teórica de desempenho.

= h) Adaptar o código de simulação do item e) para visualizar os pontos recebidos na constelação de sinais do 16-QAM, investigando o efeito da variação da SNR.
