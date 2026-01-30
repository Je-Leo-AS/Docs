#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Tarefa 4 ",
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
Para iniciar essa etapa foi feito o cálculo da curva teórica do 8ASK, cujo o código esta ilustrado pela @teorica8ask a seguir:
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

\
Para iniciar a simualção de uma modulação 16-QAM, em primeiro lugar é preciso entender que a mesma possui uma constelação em 2D, o que é diferente de todos as outras modulações simuladas até agora.



Sendo assim, para simular esse comportamento 2D, foram definidos dois vetores onde cada um indica os "eixos" X e Y desse tipo de modulação. Em sequência, a constelação como um todo foi normalizada e foram gerados 100000 valores aleatórios entre 1 e 4.

Apartir disso, foram calculados os valores de desvio e padrão e variancia, os quais foram usados para a geração de ruído, que ao ser somadao com a constelação normalizadas em função dos valores sorteados, geram o sinal recebido.

Para a conferência da quantidade de erros foi feita uma comparação entre os valores da modulação QAM, sem ruído, com os valores encontrados através da função quantalph. No caso desses valores serem diferentes, isso indica que foi obtido um erro, e isso é contabilizado através da variável erro. Vale ressaltar que isso tudo é feito para os dois eixos da constelação.


Em sequência disso é calculada a taxa de erros de bits, com base na quantidade de erros e na quantidade de interações, que no caso foi 100000.

= g) Plotar os pontos simulados juntamente com a curva teórica de desempenho.

Rodando o codigo chegou-se no seguinte resultado ilustrado pela 

cod16Com os todos os passos descritos no item f, torna-se possível plotar uma curva simulada da modulação 16-QAM. Para plotar a curva teórica, foi elaborado o seguinte código.

#figure(caption:[Código da simulação 16 QAM], 
image("cod16.png", width: 50%)
)<cod16> 

Sendo assim, foi possível gerar a figura demonstrada abaixo, onde a curva em azul indica o resultado teorico. Enquanto que os pontos em vermelho mostram o resultado simulado. Isso é indicativo favorável de que a simulação elaborada pela equipe está correta, além de ser uma forma de visualízar como a "prática" converge para o mesmo ponto da teorica, logico que isso considerando as condições impostas por essa simulação. A @Resultado16 abaixo mostra as curvas teórica e simulada.

#figure(caption:[Resultado da simulação 8 ASK], 
image("Resultado16.png", width: 80%)
)<Resultado16>

= h) Adaptar o código de simulação do item e) para visualizar os pontos recebidos na constelação de sinais do 16-QAM, investigando o efeito da variação da SNR.
\

#figure(caption:[Constelações recebidas], 
image("constela.png", width: 80%)
)<constela>

\
Para plotar os pontos recebidos na constelação, foi usado os valores definidos nos vetores X_rx e Y_rx. O que gerou o resulado demonstrado na figura X. E como pode ser visualizado, a concentração dos pontos é semelhante ao que se espera de uma modulação do tipo 16-QAM, ou seja, 4 pontos por quadrante. Entranto, nota-se que ocorre uma grande variação na posição dos pontos, por isso os pontos não ficam concentrados exatamente no mesmo ponto. Isso se deve a variação de SNR, a qual é introduzida pela inclusão de ruído na simulação.

\
