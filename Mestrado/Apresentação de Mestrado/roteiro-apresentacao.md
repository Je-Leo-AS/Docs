# Roteiro de fala — Apresentação de Mestrado

### Distribuição do tempo

| Bloco | Slides | Duração | Relógio acumulado |
| --- | --- | --- | --- |
| Abertura, motivação e objetivos | 1–4 | 3min05s | 03:05 |
| Fundamentação e métrica de desempenho | 5–13 | 7min55s | 11:00 |
| Modelo MP proposto e evidências | 14–20 | 4min40s | 15:40 |
| Avaliação dos modelos em software | 21–29 | 8min10s | 23:50 |
| Pipeline da implementação VHDL | 30 | 4min30s | 28:20 |
| Validação, síntese, FPGA e DPD | 31–34 | 4min30s | 32:50 |
| Conclusões e encerramento | 35–38 | 2min10s | 35:00 |
| Referências para consulta | 39–41 | Sem leitura oral | — |

As metas detalhadas abaixo incluem o tempo de observação das figuras. Ao terminar uma explicação antes da meta, siga adiante naturalmente; não prolongue a fala apenas para preencher o tempo.

## Slide 1 — Capa

[Meta: 00:40 neste slide | acumulado: 00:00 → 00:40.]

Bom dia a todos. Meu nome é Leonardo de Andrade Santos e vou apresentar meu trabalho sobre modelagem comportamental de amplificadores de potência usando polinômios com memória e ordens dependentes do atraso.

O foco é investigar como distribuir a complexidade do modelo entre a amostra atual e as amostras anteriores, avaliando tanto a precisão em software quanto os recursos necessários para a implementação em hardware.

## Slide 2 — Roteiro: Introdução

[Meta: 00:10 neste slide | acumulado: 00:40 → 00:50.]

Vou apresentar a motivação, os modelos, os resultados em software e hardware e, por fim, as conclusões.

## Slide 3 — Contextualização e Motivação

[Meta: 01:15 neste slide | acumulado: 00:50 → 02:05.]

Os sistemas de comunicação precisam transmitir mais informação em uma largura de banda limitada. Para isso, utilizam modulações com variações de amplitude e fase, que são sensíveis às não linearidades do amplificador de potência.

O amplificador também tem um papel importante no consumo de energia do transmissor. Ao operar próximo da saturação, existe um compromisso entre eficiência e linearidade: aparecem distorções que afetam o sinal e provocam espalhamento espectral.

Uma solução é a pré-distorção digital. Para aplicá-la, precisamos de um modelo que represente o amplificador com precisão e que tenha uma complexidade viável para implementação.

Essa motivação reúne 2 exigências. Precisamos aproveitar a energia disponível, mas também preservar a qualidade do sinal transmitido. EVM está relacionada ao erro na constelação; ACLR compara a potência no canal com a potência que vaza para canais adjacentes. A BER expressa o erro na recuperação dos bits. Essas métricas ajudam a entender por que a distorção importa para o sistema completo.

## Slide 4 — Objetivos

[Meta: 01:00 neste slide | acumulado: 02:05 → 03:05.]

O objetivo geral foi investigar e validar, em software e hardware, o modelo de polinômio com memória com ordens dependentes do atraso.

Para isso, implementei o modelo clássico e a variação proposta em Python, avaliei o compromisso entre NMSE e número de coeficientes e comparei os resultados em 2 conjuntos de dados, GaN HEMT e LDMOS.

Na etapa de hardware, o trabalho incluiu a implementação em VHDL, a validação funcional em vírgula fixa e a comparação dos resultados de síntese genérica e de utilização de recursos em FPGA.

A sequência do trabalho liga essas 2 avaliações. Primeiro, verifico se a redução de termos preserva uma precisão aceitável nos dados. Depois, observo como essa escolha se traduz em uma arquitetura digital. Dessa forma, a comparação não termina na contagem de coeficientes: ela chega aos recursos utilizados pela implementação.

## Slide 5 — Roteiro: Fundamentação Teórica

[Meta: 00:10 neste slide | acumulado: 03:05 → 03:15.]

Antes de apresentar os resultados, vou explicar o papel do amplificador no transmissor e a estrutura dos modelos utilizados.

## Slide 6 — Fundamentação Teórica: Sistema de Comunicação Sem Fio

[Meta: 00:45 neste slide | acumulado: 03:15 → 04:00.]

[Indique o amplificador no diagrama.]

O trabalho se concentra no transmissor. Nessa cadeia, o amplificador de potência fornece a potência necessária ao sinal de radiofrequência antes de sua transmissão pela antena.

Ele converte a energia da alimentação em potência de RF e tem influência direta na eficiência do transmissor. Por isso, seu comportamento e suas distorções são centrais para este estudo.

O sinal que chega ao amplificador já representa a informação que será enviada, codificada em características como amplitude e fase. O amplificador aumenta a potência desse sinal para que ele possa ser transmitido, mas deve preservar essas características: se alterá-las demais, o receptor pode ter dificuldade para recuperar a informação. Por isso, a amplificação precisa equilibrar potência e fidelidade.

## Slide 7 — Distorção Espectral e Restrições Normativas

[Meta: 00:50 neste slide | acumulado: 04:00 → 04:50.]

para ilustrar melhor as distorções, podemos observar o que acontece no espectro quando essa amplificação introduz distorção.

[Compare os espectros de entrada e saída.]

Na entrada, a potência está concentrada na banda do sinal. Na saída, as não linearidades geram produtos de intermodulação, que espalham parte dessa potência para fora da banda original.

Esse espalhamento pode interferir nos canais vizinhos. Por isso, as normas de emissão estabelecem limites para a potência nessas regiões. A figura ilustra esse efeito de forma qualitativa.

Assim, o compromisso apresentado no slide anterior fica mais claro: precisamos de eficiência, mas também de uma amplificação que respeite os limites de emissão. Para entender como tratar esse problema, vamos olhar agora para as características não lineares do amplificador.

## Slide 8 — Distorções em Amplificadores de Potência

[Meta: 01:05 neste slide | acumulado: 04:50 → 05:55.]

[Indique o afastamento entre a resposta ideal e a resposta não linear.]

À medida que o nível de entrada aumenta, o amplificador deixa de seguir uma relação linear e entra nas regiões de compressão e saturação.

Além dessa não linearidade, existem efeitos de memória: a saída depende também de amostras anteriores da entrada. O modelo precisa representar tanto as distorções de amplitude e fase quanto essa dependência temporal.

A memória significa que 2 ocorrências de uma mesma amplitude de entrada podem produzir saídas diferentes, dependendo do histórico do sinal. Isso explica por que uma curva estática, sozinha, pode ser insuficiente. Precisamos considerar simultaneamente a intensidade da entrada e sua evolução ao longo do tempo.

## Slide 9 — Pré-Distorção Digital

[Meta: 01:00 neste slide | acumulado: 05:55 → 06:55.]

A ideia da pré-distorção digital é aplicar uma distorção controlada antes do amplificador, buscando uma característica aproximadamente inversa à dele.

[Percorra a cascata DPD e PA no diagrama.]

O objetivo é que a resposta conjunta fique mais próxima de uma relação linear. Para isso, o pré-distorcedor precisa representar adequadamente o comportamento do amplificador, incluindo seus efeitos de memória.

A compensação procura antecipar a distorção do amplificador. O sinal intermediário pode estar deliberadamente deformado, enquanto o sinal após o PA se aproxima do desejado. É a resposta da cascata que interessa. A qualidade dessa compensação depende da identificação do modelo e das condições em que ele será utilizado.

## Slide 10 — Modelagem Comportamental

[Meta: 01:00 neste slide | acumulado: 06:55 → 07:55.]

Na modelagem comportamental, trabalhamos com a relação observada entre entrada e saída, sem precisar descrever todos os componentes internos do circuito.

[Indique os 2 caminhos do diagrama.]

O mesmo sinal é aplicado ao amplificador e ao modelo. Comparamos a saída medida com a saída calculada e ajustamos os coeficientes para reduzir esse erro.

Essa abordagem permite construir uma representação adequada à identificação em software e à implementação digital.

Os coeficientes são ajustados a partir de pares de amostras de entrada e saída. O modelo descreve o comportamento observado nessas condições de medição. A separação entre identificação e validação é importante para verificar se ele também representa amostras que não participaram desse ajuste.

## Slide 11 — Séries de Volterra

[Meta: 00:45 neste slide | acumulado: 07:55 → 08:40.]

A série de Volterra fornece uma representação geral de sistemas não lineares com memória. Ela combina amostras de diferentes atrasos e permite representar interações entre elas.

A dificuldade é o crescimento do número de termos conforme aumentam a ordem e a memória. Por isso, utilizamos estruturas simplificadas que preservem capacidade de representação com menor complexidade.

O modelo mais geral oferece muitas possibilidades de combinação, mas cada termo adicional precisa ser identificado e calculado. Para uma implementação digital, isso se traduz em operações, armazenamento e interconexões. A escolha de uma estrutura mais compacta busca preservar as contribuições relevantes para o comportamento do PA.

## Slide 12 — Polinômio com Memória

[Meta: 01:15 neste slide | acumulado: 08:40 → 09:55.]

O modelo de polinômio com memória, ou MP, é uma dessas simplificações. Ele utiliza termos polinomiais associados a cada atraso e soma suas contribuições para calcular a saída.

[Indique os somatórios na equação.]

Um somatório percorre os atrasos e o outro percorre as ordens polinomiais. No modelo clássico, a ordem máxima é a mesma em todos os ramos. Os coeficientes entram linearmente na expressão, o que facilita sua identificação.

Por exemplo, para cada atraso o modelo pode combinar um termo linear com termos de maior ordem. O primeiro acompanha a entrada; os demais permitem representar sua dependência não linear com a amplitude. A memória aparece porque repetimos essa construção para amostras anteriores e somamos as contribuições de todos os ramos.

## Slide 13 — Métrica de Desempenho: NMSE

[Meta: 01:05 neste slide | acumulado: 09:55 → 11:00.]

O NMSE compara a energia do erro de modelagem com a energia da saída medida do amplificador, em escala logarítmica.

O erro é a diferença entre o sinal medido e o sinal calculado pelo modelo. Quanto mais negativo o NMSE, menor é o erro relativo.

A avaliação é feita em dados separados daqueles utilizados na identificação dos coeficientes, permitindo verificar o desempenho fora do conjunto de treinamento.

A normalização permite interpretar o erro em relação ao nível do sinal de referência. Um NMSE de −30 dB corresponde a uma energia de erro equivalente a 1/1.000 da energia desse sinal. A métrica resume o erro total; a análise espectral complementa essa informação ao mostrar sua distribuição em frequência.

## Slide 14 — Roteiro: Modelo MP Proposto

[Meta: 00:05 neste slide | acumulado: 11:00 → 11:05.]

A teoria define a estrutura do MP. Agora, vou apresentar a pergunta que motivou a investigação e as análises realizadas para respondê-la.

## Slide 15 — Motivação Experimental

[Meta: 00:30 neste slide | acumulado: 11:05 → 11:35.]

No MP clássico, utilizamos a mesma ordem máxima em todos os atrasos. Isso significa reservar a mesma quantidade de termos para a amostra atual e para cada amostra anterior. Mas será que todos esses ramos precisam da mesma ordem?

Para investigar essa pergunta, fiz 3 análises no conjunto LDMOS: a magnitude dos coeficientes, a sensibilidade do NMSE à ordem de cada ramo e o espectro do erro residual. Vamos começar pelos coeficientes.

## Slide 16 — Evidência 1 — Magnitude dos Coeficientes

[Meta: 00:30 neste slide | acumulado: 11:35 → 12:05.]

Parto do modelo completo, com ordem 5 nos 3 ramos, no conjunto LDMOS.

[Indique o gráfico à esquerda da Figura 6.]

À esquerda, temos a ordem polinomial no eixo horizontal e a magnitude dos coeficientes no vertical. Cada cor representa um atraso: azul para a amostra atual, vermelho para o primeiro atraso e verde para o segundo.

[Indique as barras à direita.]

À direita, somamos os quadrados dessas magnitudes em cada ramo. Essa energia cai de 20,58 para 13,71 e 4,85 conforme o atraso aumenta. É um indício de diferenças entre os ramos; as próximas análises verificam o efeito no erro.

## Slide 17 — Evidência 2 — Sensibilidade do NMSE

[Meta: 00:40 neste slide | acumulado: 12:05 → 12:45.]

Na segunda evidência, vario a ordem de um ramo de 1 para 5, mantendo as outras 2 em 1. Todos os testes partem do mesmo modelo linear, com NMSE de −28,71 dB.

[Compare o ganho nas 3 curvas.]

O ganho é de 6,66 dB no ramo atual, 3,43 no primeiro atraso e 1,49 no segundo. Portanto, nesse teste, acrescentar ordens ao ramo atual oferece o maior retorno em precisão.

## Slide 18 — Evidência 3 — Espectro do Erro Residual

[Meta: 00:40 neste slide | acumulado: 12:45 → 13:25.]

No slide anterior, o NMSE resumiu o erro em um único número. Aqui, observo como esse erro se distribui em frequência. O erro residual é a diferença entre a saída medida do amplificador e a saída prevista pelo modelo.

[Indique a referência cinza e as curvas coloridas.]

Quanto mais baixa a curva de erro, menor a parcela do sinal que o modelo deixou de representar naquela região de frequência. A referência cinza corresponde à ordem 1 nos 3 ramos.

[Compare a referência cinza com as curvas de erro no mesmo gráfico.]

Ao aumentar P₀, a redução do erro é maior do que ao aumentar as ordens dos ramos atrasados. Em conjunto, as 3 observações motivam a hipótese de preservar alta ordem no instante atual e reduzir termos nos atrasos. É essa hipótese que orienta o modelo apresentado a seguir.

[Apoio para ensaio ou perguntas — fora da fala de 40 segundos:]

- O eixo horizontal representa a frequência em banda-base, com o centro do sinal em 0. O eixo vertical mostra a densidade espectral de potência: como a potência do sinal ou do erro se distribui em frequência.
- A curva da saída medida serve como referência para localizar a banda do sinal e o espalhamento espectral nas adjacências. As curvas de erro mostram o que restou da diferença entre medição e previsão, depois da modelagem.
- A curva preta representa a entrada; a vermelha, a saída medida do PA; a cinza tracejada, o erro de referência. As demais curvas mostram os erros ao aumentar a ordem de um ramo, mantendo as outras 2 em 1. A comparação mostra onde acrescentar ordem traz maior benefício.
- A melhora aparece na banda do sinal e em parte das frequências adjacentes. Isso indica que o modelo com P₀ maior representa melhor tanto o sinal na banda quanto parte da distorção fora dela, nas condições avaliadas.
- Essa figura avalia a precisão do modelo do PA. Uma curva de erro mais baixa não significa que a saída física do amplificador já foi linearizada; a avaliação da cascata DPD + PA aparece mais adiante.
- Os ramos atrasados continuam representando efeitos de memória. A conclusão é que aumentar suas ordens traz menos ganho neste teste, o que sustenta reduzir seletivamente seus termos de maior ordem.

## Slide 19 — Alternativa Proposta: MP com Ordem Variável

[Meta: 01:00 neste slide | acumulado: 13:25 → 14:25.]

A partir dessas observações, a proposta é permitir uma ordem diferente em cada atraso. Na equação, a ordem máxima passa a ser definida por Pₘ, ou seja, por um parâmetro específico de cada ramo.

A hipótese investigada é que os atrasos mais antigos podem utilizar menos termos de alta ordem. Assim, podemos concentrar a complexidade no instante atual e avaliar quanto essa redução altera o erro de modelagem.

Para fazer essa comparação, utilizo o NMSE como medida de precisão e o número de coeficientes como medida de complexidade do modelo.

A redução é seletiva: preservamos a ordem do ramo atual e simplificamos os demais. O benefício precisa ser verificado nos dados de cada amplificador.

## Slide 20 — Arquitetura Implementada em VHDL

[Meta: 01:15 neste slide | acumulado: 14:25 → 15:40.]

Na implementação em VHDL, utilizo funções de base de ordem ímpar. Aqui, cada valor do vetor P indica a quantidade de termos ímpares preservados no respectivo ramo.

O modelo padrão tem 5 termos em cada um dos 3 ramos, totalizando 15 coeficientes complexos. O modelo reduzido utiliza (5, 3, 1) termos, totalizando 9 coeficientes.

[Indique as linhas da tabela.]

No ramo atual, isso corresponde às ordens 1, 3, 5, 7 e 9. No primeiro atraso, são mantidas as ordens 1, 3 e 5; no segundo, apenas o termo linear. A redução no número de coeficientes é de 40%.

Aqui, o vetor indica a quantidade de termos ímpares, e não a maior ordem implementada. O modelo reduzido continua tendo memória, porque os 2 ramos atrasados permanecem presentes.

## Slide 21 — Roteiro: Resultados

[Meta: 00:10 neste slide | acumulado: 15:40 → 15:50.]

Com a proposta motivada, passo à sua avaliação: comparo as distribuições de ordens em software e, depois, a implementação em hardware.

## Slide 22 — Resultados: Visão Geral

[Meta: 01:10 neste slide | acumulado: 15:50 → 17:00.]

Foram utilizados 2 conjuntos de medições. O primeiro corresponde a um amplificador GaN HEMT classe AB, com portadora de 900 MHz e sinal WCDMA. O segundo corresponde a um amplificador LDMOS, com 4.500 amostras para extração e a mesma quantidade para validação.

Em cada conjunto, foram avaliadas 125 combinações de ordens, com profundidade de memória igual a 2.

As análises preliminares motivaram a proposta; agora avalio o compromisso entre precisão e complexidade nas 125 combinações. Na etapa de hardware, comparei a simulação em VHDL com a referência em Python e avaliei a síntese e os recursos utilizados em FPGA.

Como cada um dos 3 ramos possui 5 escolhas possíveis, o total é 5 × 5 × 5. Para apresentar os resultados, utilizo o LDMOS na referência do MP original e nas etapas de validação, síntese, FPGA e DPD. Nos gráficos de distribuição das ordens, até a fronteira de Pareto, utilizo o GaN HEMT. Escolhi essa disposição porque ela evidencia melhor os aspectos discutidos em cada etapa. Ao final da análise em software, a tabela reúne os 2 conjuntos.

## Slide 23 — Modelagem do PA com MP Original

[Meta: 00:55 neste slide | acumulado: 17:00 → 17:55.]

Este resultado estabelece a referência do MP padrão para o conjunto LDMOS. O modelo foi implementado em Python, em vírgula flutuante, com ordem 5, profundidade de memória 2 e 15 coeficientes complexos.

[Indique os pontos medidos e calculados.]

A figura mostra a comparação AM–AM. Os pontos calculados acompanham os valores medidos, e o NMSE obtido na validação foi de −37,51 dB.

A proximidade visual dos pontos ajuda a observar a resposta de amplitude, enquanto o NMSE quantifica o erro do sinal complexo no conjunto de validação. Esse resultado estabelece a referência de precisão para as comparações no LDMOS. A seguir, passo ao GaN HEMT para mostrar a influência da distribuição das ordens.

## Slide 24 — MP com Ordem Dependente do Atraso

[Meta: 01:05 neste slide | acumulado: 17:55 → 19:00.]

Agora utilizo o conjunto GaN HEMT, que será mantido nos próximos gráficos, até a fronteira de Pareto. Nesse conjunto, a influência da distribuição das ordens fica mais evidente. Permiti que as ordens dos 3 ramos variassem independentemente entre 1 e 5, gerando as 125 combinações avaliadas.

[Indique modelos com o mesmo número de coeficientes e NMSEs diferentes.]

O gráfico mostra que o número de coeficientes, isoladamente, não determina a precisão. Modelos com a mesma quantidade de termos podem apresentar erros diferentes, dependendo de como as ordens são distribuídas entre os atrasos.

A dispersão vertical entre configurações com a mesma complexidade é especialmente relevante. Se a quantidade de coeficientes fosse suficiente para explicar o resultado, esses modelos teriam desempenho semelhante. Como isso não ocorre, a seleção dos termos passa a ser parte central da otimização.

## Slide 25 — Influência da Ordem Polinomial por Atraso

[Meta: 01:00 neste slide | acumulado: 19:00 → 20:00.]

Ainda no conjunto GaN HEMT, estes gráficos separam a influência de cada parâmetro. O aumento da ordem no instante atual, P₀, está associado à melhora mais pronunciada do NMSE.

No primeiro atraso, o efeito é menor. No segundo, os ganhos são mais limitados.

Esse comportamento sustenta a proposta de priorizar os termos de maior ordem no ramo atual e reduzir a complexidade nos atrasos mais antigos.

Não interpreto esse resultado como ausência de memória. Os termos atrasados continuam contribuindo para o modelo. A conclusão é mais específica: nos conjuntos e nas configurações avaliadas, acrescentar ordens elevadas aos atrasos mais antigos oferece menos benefício do que acrescentá-las ao instante atual.

## Slide 26 — NMSE em Função da Complexidade

[Meta: 00:50 neste slide | acumulado: 20:00 → 20:50.]

Nestes gráficos do GaN HEMT, o eixo horizontal mostra a quantidade de coeficientes e o eixo vertical mostra o NMSE. As cores destacam as ordens de cada ramo.

[Compare a separação das cores nos 3 gráficos.]

A ordem do ramo atual apresenta a associação mais clara com o ganho de precisão. Nos atrasos, aumentar a ordem não produz a mesma melhora de forma sistemática.

Isso reforça que precisamos considerar onde os termos são colocados, além de quantos termos o modelo utiliza.

Esses gráficos ajudam a identificar regiões em que aumentar a complexidade traz ganhos pequenos. Isso é útil porque, no hardware, um ganho modesto de precisão pode exigir mais operadores. A decisão depende do erro tolerável e dos recursos disponíveis para a aplicação.

## Slide 27 — Modelos com P₀ ≥ P₁ ≥ P₂

[Meta: 00:45 neste slide | acumulado: 20:50 → 21:35.]

Neste gráfico do GaN HEMT, destaco os modelos em que a ordem se mantém ou diminui conforme o atraso aumenta.

[Indique os pontos destacados.]

Essas configurações concentram muitas das soluções de melhor desempenho. O resultado é coerente com a hipótese de que os atrasos mais antigos podem ser representados com ordens menores, preservando uma boa relação entre precisão e complexidade.

A condição permite ordens iguais entre ramos, além das estritamente decrescentes. Ela expressa uma preferência de distribuição da complexidade. Os pontos destacados devem ser comparados aos demais para verificar quais configurações preservam os menores erros.

## Slide 28 — Fronteira de Pareto

[Meta: 01:05 neste slide | acumulado: 21:35 → 22:40.]

Para concluir os gráficos do GaN HEMT, apresento a fronteira de Pareto. Ela reúne as soluções para as quais não existe outra configuração que melhore a precisão sem aumentar a complexidade, ou reduza a complexidade sem piorar a precisão.

[Indique os pontos da fronteira.]

Ela permite selecionar o modelo de acordo com o compromisso desejado entre erro e número de coeficientes. As configurações destacadas reforçam a importância de concentrar a ordem no instante atual.

Uma configuração fora da fronteira pode ser descartada se outra atingir erro igual ou menor com menos coeficientes. Já entre os pontos da fronteira, precisamos escolher o compromisso adequado à aplicação. A fronteira orienta a seleção; ela não estabelece um único modelo ideal para todos os requisitos.

## Slide 29 — Resultados em GaN HEMT e LDMOS

[Meta: 01:10 neste slide | acumulado: 22:40 → 23:50.]

A tabela compara configurações representativas nos 2 conjuntos de dados. Os níveis de NMSE são diferentes, mas o interesse é verificar como a distribuição das ordens se comporta em cada conjunto.

[Indique as linhas com 10, 12 e 15 coeficientes.]

No LDMOS, por exemplo, a configuração (5, 3, 2) utiliza 10 coeficientes e atinge −37 dB. A configuração completa utiliza 15 coeficientes e atinge −37,51.

Essa comparação mostra o compromisso entre reduzir termos e aceitar uma diferença de precisão, mantendo a prioridade no ramo atual.

Nesse exemplo do LDMOS, retirar 5 dos 15 coeficientes altera o NMSE em cerca de 0,5 dB. É uma diferença que pode ser interessante dependendo da aplicação. A tabela mostra configurações representativas; a comparação de hardware a seguir utiliza especificamente os vetores (5, 5, 5) e (5, 3, 1).

## Slide 30 — Pipeline da Implementação VHDL

[Meta: 04:30 neste slide | acumulado: 23:50 → 28:20. Inclui o tempo para acompanhar as etapas na figura.]

[Mostre as colunas e acompanhe primeiro apenas a letra A.]

Este diagrama mostra como o cálculo do modelo foi dividido em etapas. É como uma linha de montagem: cada etapa faz uma parte do trabalho e passa o resultado para a seguinte. Os registradores guardam os valores entre as etapas.

Cada coluna representa uma batida do relógio. A letra A identifica uma janela com a amostra atual e as 2 anteriores. Vamos acompanhar essa janela até a saída.

[Percorra C1 e C2.]

Em C1, o circuito recebe a nova amostra e organiza as 2 anteriores. Em C2, calcula o módulo ao quadrado de cada amostra, que vou chamar de r. Para um sinal com componentes I e Q, r é I ao quadrado mais Q ao quadrado.

[Percorra C3 até C7.]

Depois, construímos os termos do polinômio. Começamos com a própria amostra x. A cada multiplicação por r, avançamos uma ordem ímpar: de 1 para 3, depois 5, 7 e 9.

Assim, entre C3 e C7, o circuito gera as funções de base para os ramos de memória.

[Aponte o alinhamento em C8.]

O alinhamento acontece à medida que os termos ficam prontos e se completa em C8. O termo de ordem 1, pronto em C3, percorre 5 registros de alinhamento; o de ordem 9, pronto em C7, percorre apenas 1. Esses registros preservam os resultados enquanto novas entradas são processadas. Assim, em C8, todos os termos da janela A ficam disponíveis no mesmo ciclo para continuar o cálculo.

[Percorra C9, C10 e C11.]

Em C9, selecionamos os 9 termos do modelo reduzido: 5 da amostra atual, 3 do primeiro atraso e 1 do segundo.

Em C10, multiplicamos esses termos pelos respectivos coeficientes. Depois, somamos as contribuições. Em C11, limitamos o resultado à faixa numérica utilizada e registramos a saída.

[Acompanhe o percurso completo de A e depois compare com B e C.]

A entrou em C1 e saiu em C11. Entre essas bordas existem 10 ciclos: essa é a latência.

Enquanto A avança, B já pode entrar. No ciclo seguinte, entra C. Assim, A sai em C11, B em C12 e C em C13.

A ideia principal é esta: cada janela leva 10 ciclos para atravessar o circuito, mas, depois que o pipeline está preenchido, podemos ter uma saída por ciclo.

Essa capacidade depende de cada etapa terminar seu cálculo dentro do período de relógio, o que precisa ser verificado na análise de temporização. A seguir, comparo os valores calculados em VHDL com a referência em Python.

## Slide 31 — Validação Funcional: VHDL e Python

[Meta: 01:05 neste slide | acumulado: 28:20 → 29:25.]

Agora retomo o conjunto LDMOS, utilizado nesta validação e nos resultados seguintes de síntese, FPGA e DPD. Para verificar a implementação, comparei o resultado da simulação funcional em VHDL, executada com GHDL, com a referência em Python em vírgula fixa.

[Indique a sobreposição dos pontos.]

Os resultados se sobrepõem no cenário avaliado, indicando correspondência funcional entre a descrição em hardware e a referência utilizada.

Essa comparação verifica o cálculo com a representação numérica adotada. Para comparar corretamente, também é necessário associar cada saída à janela de entrada correspondente, respeitando a latência do pipeline. A concordância funcional verifica os valores calculados; a análise de temporização trata da velocidade com que o circuito pode operar.

## Slide 32 — Resultados de Síntese Genérica

[Meta: 00:55 neste slide | acumulado: 29:25 → 30:20.]

A síntese genérica com GHDL e Yosys permite comparar a complexidade estrutural das 2 arquiteturas utilizadas no estudo com LDMOS.

O modelo reduzido apresentou queda de 41,2% em wires, 40,8% em wire bits e 41,4% em células. Nos flip-flops, a redução foi de 36,7%.

Esses resultados mostram que a simplificação do modelo também se reflete na estrutura descrita em hardware.

Wires e wire bits descrevem aspectos das conexões da representação sintetizada; células e flip-flops descrevem sua estrutura lógica. Essa etapa permite uma comparação anterior ao mapeamento físico. Para observar o uso dos recursos específicos do dispositivo, precisamos olhar também os resultados de implementação em FPGA.

## Slide 33 — Resultados de Implementação em FPGA

[Meta: 01:15 neste slide | acumulado: 30:20 → 31:35.]

Mantendo as arquiteturas utilizadas no estudo com LDMOS, a implementação foi realizada para a FPGA Artix-7 XC7A100T, com Xilinx ISE 14.7 e frequência-alvo de 100 MHz. A tabela apresenta os recursos após posicionamento e roteamento.

[Indique as linhas de Slice LUTs e DSP48E1.]

As Slice LUTs passaram de 3.163 para 1.822, uma redução de 42,40%. Os blocos DSP passaram de 67 para 44, com redução de 34,33%.

Também houve redução nos registradores e slices ocupados. Assim, o modelo reduzido utilizou menos recursos nas implementações comparadas.

As LUTs implementam lógica, enquanto os blocos DSP oferecem recursos aritméticos dedicados. A redução dos 2 tipos de recurso indica que a simplificação se refletiu no mapeamento para o dispositivo. Esses resultados quantificam ocupação de hardware; o trabalho não apresenta uma medição de potência elétrica que permita transformar essas porcentagens em economia de energia.

## Slide 34 — Linearização DPD + PA com ILA

[Meta: 01:15 neste slide | acumulado: 31:35 → 32:50.]

Também avaliei a aplicação do modelo na pré-distorção digital, utilizando a arquitetura de aprendizagem indireta, ou ILA, no conjunto LDMOS.

O DPD foi ajustado para compensar a distorção do amplificador: ele modifica o sinal antes da amplificação para que a saída final fique mais próxima da desejada. Neste teste, essa saída é calculada pelo modelo do PA.

Também ajustei a amplitude do sinal antes do DPD, multiplicando a entrada por um fator de ganho. Com 0,83, a amplitude é reduzida em cerca de 17%; com 0,95, em apenas 5%. Nos testes, 0,95 permitiu utilizar uma faixa maior de amplitudes do modelo e apresentou melhor linearização visual nas curvas de amplitude e fase.

[Compare a resposta do PA com a da cascata nos 2 gráficos.]

Na resposta AM–AM, a cascata se aproxima de uma relação linear. Na resposta AM–PM, observa-se redução da distorção de fase.

Na aprendizagem indireta, ajustamos uma estrutura inversa a partir da relação entre os sinais do amplificador e utilizamos os coeficientes no pré-distorcedor. Aqui, a evidência apresentada são as curvas de amplitude e fase. Elas mostram a melhora da cascata no cenário avaliado, sem substituir uma avaliação quantitativa adicional de outras métricas de linearização.

## Slide 35 — Roteiro: Conclusão

[Meta: 00:05 neste slide | acumulado: 32:50 → 32:55.]

Com esses resultados, passo às principais conclusões do trabalho.

## Slide 36 — Conclusões

[Meta: 01:15 neste slide | acumulado: 32:55 → 34:10.]

Os resultados mostram que podemos simplificar o modelo escolhendo melhor a ordem de cada atraso. Nos 2 conjuntos avaliados, os termos da amostra atual tiveram maior influência na precisão, o que favorece manter mais termos nesse ramo e reduzir os demais.

Em VHDL, passamos de 15 para 9 coeficientes complexos, uma redução de 40%. A simulação apresentou resultados correspondentes aos da referência em Python, e a implementação em FPGA utilizou menos recursos de lógica e de cálculo.

Na aplicação em pré-distorção digital, também observamos melhora nas respostas de amplitude e fase da cascata DPD e PA.

A principal contribuição foi mostrar como a escolha dos termos pode equilibrar a precisão do modelo e o uso de recursos no hardware, nas condições avaliadas.

## Slide 37 — Roteiro: Próximas Etapas

[Meta: 00:05 neste slide | acumulado: 34:10 → 34:15.]

Para finalizar, apresento as possibilidades de continuidade do trabalho.

## Slide 38 — Próximas Etapas e Agradecimento

[Meta: 00:45 neste slide | acumulado: 34:15 → 35:00.]

Como possibilidade de continuidade, a metodologia pode ser aplicada a outros modelos comportamentais, como o polinômio generalizado com memória e a série de Volterra, comparando precisão e recursos de hardware.

Outras possibilidades são ampliar a validação em plataformas FPGA e investigar o efeito de diferentes precisões numéricas e arquiteturas de pipeline.

Esses estudos poderiam verificar se a tendência observada se mantém em outras condições e identificar representações numéricas mais adequadas a diferentes requisitos de implementação.

Agradeço a atenção de todos e fico à disposição para as perguntas.

## Slides 39–41 — Referências

[As 3 páginas finais reúnem as referências bibliográficas. Não leia os itens individualmente. Encerre a fala no slide 38 e use as referências para consulta quando necessário.]

### Notas de ensaio — fora da fala de 35 minutos

- Faça uma passagem completa com cronômetro, apontando as figuras e trocando os slides. Registre o tempo real nos marcos 03:05, 11:00, 15:40, 23:50, 28:20 e 32:50. Ajuste o ritmo das explicações a partir desse ensaio.
- Se estiver atrasado ao terminar o slide 29, nos slides 31–34 diga o resultado principal de cada comparação e dispense os parágrafos complementares. Preserve a explicação de alinhamento e de latência do slide 30.
- Nas tabelas, apresente a conclusão e um exemplo representativo. Evite ler todas as linhas. Nos gráficos das evidências (slides 16–18) e da avaliação (slides 24–27), aponte a evidência específica de cada um, sem repetir toda a motivação.

#### Apoio para perguntas sobre o slide 30

| Pergunta | Resposta de apoio |
| --- | --- |
| Por que 10 ciclos se as bordas vão de C1 a C11? | A latência conta os intervalos: C1→C2 é o 1º e C10→C11 é o 10º. |
| A, B e C são os 3 ramos de memória? | São janelas consecutivas. A contém x[n], x[n−1] e x[n−2]; B contém x[n+1], x[n] e x[n−1]; C contém x[n+2], x[n+1] e x[n]. |
| Por que atrasar um termo que já ficou pronto? | Para que a ponderação e a soma combinem apenas termos da mesma janela de entrada. O módulo quadrático também é atrasado para acompanhar a geração recursiva dos termos. |
| Há 1 ciclo adicional para cada nível da árvore de soma? | Nesta descrição, os 4 níveis são combinacionais entre C10 e C11. A soma final é registrada em C11. |
| O modelo reduzido tem automaticamente menor latência? | Reduzir o número de coeficientes não implica reduzir a latência. Ela depende dos registradores e da organização adotada; o diagrama descreve a arquitetura reduzida apresentada. |
| Isso comprova uma taxa física de 100 milhões de amostras por segundo? | O RTL tem intervalo de iniciação de 1 ciclo. A 100 MHz, se a temporização for atendida e houver alimentação contínua de dados, isso corresponderia a 100 milhões de amostras complexas por segundo e latência de 100 ns. É uma relação condicional, não uma medição em placa nem uma demonstração de Fmax. |

Base da explicação: figura `figuras/pipeline_dpd_por_clock.svg`, descrição da arquitetura em `../Tese/template/main.typ` e verificação registrada em `../Tese/template/assets/verificacao_pipeline.json`. Essa verificação registra 10 ciclos de latência e intervalo de iniciação de 1 ciclo no RTL.
