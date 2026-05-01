// Apêndice A - Resultados completos dos modelos MP com ordem dependente do atraso
// Le automaticamente o arquivo CSV gerado pelo Python/pandas
//
// O CSV deve ter este cabeçalho (primeira linha):
//   num_coef,nmse_in_out_SBRT2_direto,P0,P1,P2,nmse_data_LDMOS_formatted_4500p,diferenca_nmse_data_LDMOS_formatted_4500p_menos_in_out_SBRT2_direto
#import "../../src/lib.typ": abnt-table
#let dados = csv("comparacao_nmse_in_out_SBRT2_direto_vs_data_LDMOS_formatted_4500p.csv")
#let cel(valor) = text(str(valor))
#let linhas = (
  dados
  .slice(1)
  .sorted(key: linha => (
    int(linha.at(0)),
    int(linha.at(2)),
    int(linha.at(3)),
    int(linha.at(4)),
  ))
  .map(linha => (
    cel(linha.at(0)),
    cel(linha.at(2)),
    cel(linha.at(3)),
    cel(linha.at(4)),
    cel(calc.round(float(linha.at(1)) * 100) / 100),
    cel(calc.round(float(linha.at(5)) * 100) / 100),
  ))
  .flatten()
)

// Cabeçalhos com formatação matemática para P0, P1, P2
#let cabecalho = (
  [*Nº Coef.*],
  [$bold(P_0)$],
  [$bold(P_1)$],
  [$bold(P_2)$],
  [*NMSE SBRT2 (dB)*],
  [*NMSE LDMOS (dB)*],
)
#show figure: set block(breakable: true)
#figure(
  abnt-table(
    columns: ( auto, auto, auto, auto, auto, auto),
    align: center,
    table.header(..cabecalho),
    ..linhas
  ),
  caption: [Resultados completos dos modelos MP com ordem dependente do atraso],
) <tab:resultados_completos_mp>
