// Apêndice A – Resultados completos dos modelos MP com ordem dependente do atraso
// Lê automaticamente o arquivo CSV gerado pelo Python/pandas
// Coloque o arquivo em: template/assets/resultados_mp.csv
//
// O CSV deve ter este cabeçalho (primeira linha):
//   Modelo,Número de coeficientes,NMSE (dB),P0,P1,P2
#import "../../src/lib.typ": abnt-table
#let dados = csv("df_resultados.csv")

// Cabeçalhos com formatação matemática para P0, P1, P2
#let cabecalho = (
  [*Nº Coef.*],
  [*NMSE (dB)*],
  [$bold(P_0)$],
  [$bold(P_1)$],
  [$bold(P_2)$],
)
#show figure: set block(breakable: true)
#figure(
  abnt-table(
    columns: ( auto, auto, auto, auto, auto),
    align: center,
    table.header(..cabecalho),
    ..dados.slice(1).flatten()   // pula a linha de cabeçalho do CSV
  ),
  caption: [Resultados completos dos modelos MP com ordem dependente do atraso],
) <tab:resultados_completos_mp>
