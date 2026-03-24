# Typst — Tutorial do Básico ao Avançado

> Typst é uma linguagem de composição tipográfica moderna, compilada e programável. É uma alternativa ao LaTeX com sintaxe muito mais limpa, erros legíveis e tempo de compilação praticamente instantâneo.

---

## Índice

1. [Instalação e primeiros passos](#1-instalação-e-primeiros-passos)
2. [Markup básico](#2-markup-básico)
3. [Configuração de página e texto](#3-configuração-de-página-e-texto)
4. [Elementos estruturais](#4-elementos-estruturais)
5. [Equações matemáticas](#5-equações-matemáticas)
6. [Funções e scripting](#6-funções-e-scripting)
7. [Set e show rules](#7-set-e-show-rules)
8. [Layouts e posicionamento](#8-layouts-e-posicionamento)
9. [Templates e projetos multi-arquivo](#9-templates-e-projetos-multi-arquivo)
10. [Pacotes da comunidade](#10-pacotes-da-comunidade)
11. [Referências e dicas avançadas](#11-referências-e-dicas-avançadas)

---

## 1. Instalação e primeiros passos

### Instalar o Typst

```bash
# Arch Linux
sudo pacman -S typst

# Via cargo
cargo install typst-cli

# Binário direto (GitHub Releases)
# https://github.com/typst/typst/releases
```

### Compilar um documento

```bash
typst compile main.typ            # gera main.pdf
typst compile main.typ saida.pdf  # nome personalizado
typst watch main.typ              # recompila ao salvar (live preview)
```

### Estrutura mínima de um arquivo `.typ`

```typst
= Meu Primeiro Documento

Olá, mundo! Este é um parágrafo normal.
```

Isso já gera um PDF válido. Sem preâmbulo obrigatório, sem `\begin{document}`.

---

## 2. Markup básico

### Texto e formatação inline

```typst
Texto normal, *negrito*, _itálico_, *_negrito itálico_*.

`código inline` com acento grave.

Subscrito: H#sub[2]O — Sobrescrito: E = mc#super[2]

Linha\ separada por barra invertida (quebra de linha forçada).

Parágrafo separado por linha em branco.
```

### Headings

```typst
= Nível 1 (H1)
== Nível 2 (H2)
=== Nível 3 (H3)
==== Nível 4 (H4)
```

### Listas

```typst
// Lista não ordenada
- Item A
- Item B
  - Sub-item (2 espaços de indentação)
  - Outro sub-item
- Item C

// Lista ordenada
+ Primeiro
+ Segundo
  + Sub-item
+ Terceiro

// Lista de definições (term list)
/ Termo: Definição do termo aqui.
/ Outro termo: Outra definição.
```

### Links e referências

```typst
Veja #link("https://typst.app")[a documentação oficial].

// Ou simplesmente o URL (vira link automático)
https://typst.app
```

### Comentários

```typst
// Comentário de linha única

/* Comentário
   de múltiplas linhas */
```

### Caracteres especiais e escape

```typst
\* — asterisco literal (não negrito)
\_ — underline literal
\= — sinal de igual literal
\  — espaço não-quebrável (barra + espaço)
```

---

## 3. Configuração de página e texto

### `#set page()`

```typst
#set page(
  paper: "a4",            // "us-letter", "a3", "a5", etc.
  margin: (
    top: 3cm,
    bottom: 2.5cm,
    left: 3cm,
    right: 2.5cm,
  ),
  // Ou margem uniforme:
  // margin: 2.5cm,
  
  numbering: "1",         // numeração de páginas
  number-align: center,   // alinhamento do número
  
  header: [               // cabeçalho personalizado
    #set text(size: 9pt)
    #h(1fr) Meu Documento
    #line(length: 100%)
  ],
  
  footer: [               // rodapé personalizado
    #line(length: 100%)
    #set text(size: 9pt)
    #counter(page).display() #h(1fr) Autor
  ],
)
```

### `#set text()`

```typst
#set text(
  font: "New Computer Modern",   // família de fonte
  // font: ("Linux Libertine", "Libertinus Serif"),  // fallback
  size: 11pt,
  lang: "pt",            // idioma (afeta hifenização)
  region: "BR",          // região
  weight: "regular",     // "bold", "light", 400, 700, etc.
  style: "normal",       // "italic", "oblique"
  fill: black,           // cor do texto
  hyphenate: true,       // hifenização automática
)
```

### `#set par()`

```typst
#set par(
  justify: true,         // texto justificado
  leading: 0.65em,       // espaçamento entre linhas
  spacing: 1.2em,        // espaçamento entre parágrafos
  first-line-indent: 1.5em,  // indentação da primeira linha
)
```

### Verificar fontes disponíveis

```bash
typst fonts           # lista todas as fontes disponíveis no sistema
typst fonts --variants  # com variantes (bold, italic, etc.)
```

---

## 4. Elementos estruturais

### Figuras e imagens

```typst
#figure(
  image("caminho/para/imagem.png", width: 80%),
  caption: [Legenda da figura aqui.],
  placement: auto,       // auto, top, bottom, none
) <fig-minha-figura>     // label para referência cruzada

// Referenciar depois:
Como mostrado na @fig-minha-figura...
```

### Tabelas

```typst
#figure(
  table(
    columns: (auto, 1fr, 1fr),   // larguras: auto, fracional, fixo (ex: 3cm)
    align: (left, center, right),
    stroke: 0.5pt,
    
    // Cabeçalho (negrito)
    table.header(
      [*Parâmetro*], [*Valor*], [*Unidade*],
    ),
    
    [Frequência], [2.4], [GHz],
    [Potência],   [20],  [dBm],
    [Ganho],      [15],  [dB],
  ),
  caption: [Parâmetros do sistema.],
) <tab-parametros>
```

### Blocos de código

```typst
// Inline
Use a função `printf()` para imprimir.

// Bloco (com syntax highlighting)
```python
def soma(a, b):
    return a + b
```

// Especificando linguagem
#raw(lang: "vhdl", block: true,
  "signal clk : std_logic := '0';"
)
```

### Citações e notas de rodapé

```typst
// Nota de rodapé
Afirmação importante.#footnote[Referência ou explicação adicional aqui.]

// Citação em bloco
#quote(attribution: [Albert Einstein], block: true)[
  A imaginação é mais importante que o conhecimento.
]
```

### Sumário automático

```typst
#outline(
  depth: 3,           // nível máximo de headings incluídos
  indent: true,       // indentação por nível
  fill: repeat[.],   // preenchimento com pontos
)
```

### Referências bibliográficas (Hayagriva)

Crie um arquivo `refs.bib` (BibTeX) ou `refs.yml` (Hayagriva):

```yaml
# refs.yml (formato Hayagriva)
silva2023:
  type: article
  title: "Título do Artigo"
  author: Silva, João
  date: 2023
  journal: "Nome do Periódico"
  volume: 10
  issue: 2
  page-range: 45-60
```

No documento:

```typst
#bibliography("refs.yml", style: "ieee")

// Citar no texto:
Conforme demonstrado em @silva2023...
```

---

## 5. Equações matemáticas

Typst usa sua própria sintaxe matemática — diferente do LaTeX, mas igualmente poderosa.

### Modo matemático

```typst
// Inline: cifrão simples
A área é $A = pi r^2$.

// Bloco: cifrão duplo
$ A = pi r^2 $

// Com numeração:
$ sum_(i=0)^n i = (n(n+1))/2 $ <eq-gauss>

Ver @eq-gauss para a fórmula de Gauss.
```

### Sintaxe matemática essencial

```typst
// Frações
$ x/y $          // fração simples
$ (a + b)/c $    // numerador composto: parênteses viram fração
$ frac(a, b) $   // forma explícita

// Índices e expoentes
$ x_i $          // subscrito
$ x^2 $          // sobrescrito
$ x_i^2 $        // ambos
$ x_(i,j) $      // subscrito composto

// Raízes
$ sqrt(x) $
$ root(3, x) $   // raiz cúbica

// Somatório e integral
$ sum_(i=1)^n x_i $
$ integral_0^1 f(x) dif x $
$ integral.double $

// Letras gregas (sem backslash!)
$ alpha, beta, gamma, delta, epsilon $
$ mu, sigma, tau, omega, Omega $
$ pi, Pi, phi, Phi, psi, Psi $

// Operadores
$ a dot b $       // produto escalar
$ a times b $     // produto vetorial / ×
$ a plus.minus b $ // ±
$ a != b $        // ≠
$ a <= b $        // ≤
$ a >= b $        // ≥
$ a approx b $    // ≈
$ a in A $        // ∈
$ forall x $      // ∀
$ exists x $      // ∃

// Vetores e normas
$ bold(v) = vec(x, y, z) $
$ norm(bold(v)) $

// Matrizes
$ mat(1, 0; 0, 1) $         // matriz 2x2 identidade
$ mat(a, b, c; d, e, f) $   // 2x3

// Casos (piecewise)
$ f(x) = cases(
  x   &"se" x >= 0,
  -x  &"se" x < 0,
) $

// Alinhamento em equações multi-linha
$ a &= b + c \
    &= d + e $
```

### Funções matemáticas

```typst
$ sin(x), cos(x), tan(x) $
$ ln(x), log(x), exp(x) $
$ lim_(x -> 0) sin(x)/x = 1 $
$ max(a, b), min(a, b) $
```

---

## 6. Funções e scripting

O modo de código no Typst usa `#` para sair do modo markup e entrar em expressões.

### Variáveis e expressões

```typst
#let nome = "Leonardo"
#let ano = 2025
#let pi-aprox = 3.14159

Olá, #nome! O ano é #ano.

// Expressão inline
O dobro de pi é aproximadamente #(2 * pi-aprox).
```

### Tipos de dados

```typst
#let inteiro = 42
#let flutuante = 3.14
#let texto = "string"
#let booleano = true
#let array = (1, 2, 3, "quatro")
#let dicionario = (nome: "Leo", idade: 28)

// Acessar elementos
#array.at(0)          // 1
#dicionario.nome      // "Leo"
#array.len()          // 4
```

### Condicionais

```typst
#let nota = 8.5

#if nota >= 7.0 {
  [Aprovado com nota #nota.]
} else if nota >= 5.0 {
  [Recuperação.]
} else {
  [Reprovado.]
}
```

### Loops

```typst
// Loop em array
#for item in ("A", "B", "C") {
  [- Item #item \ ]
}

// Loop com range
#for i in range(1, 6) {
  [Linha #i \ ]
}

// while
#let x = 0
#while x < 3 {
  x = x + 1
  [Iteração #x \ ]
}
```

### Funções customizadas (`#let`)

```typst
// Função simples
#let destaque(conteudo) = {
  text(weight: "bold", fill: red, conteudo)
}

Palavra #destaque[importante] no texto.

// Função com parâmetros nomeados e padrão
#let caixa(conteudo, cor: blue, padding: 8pt) = {
  block(
    fill: cor.lighten(80%),
    stroke: cor,
    inset: padding,
    radius: 4pt,
    conteudo
  )
}

#caixa[Nota padrão azul]
#caixa(cor: green)[Nota verde]
#caixa(cor: red, padding: 12pt)[Alerta vermelho com mais padding]
```

### Content como parâmetro

```typst
// Conteúdo passado com colchetes []
#let nota-importante(titulo, corpo) = {
  block(
    stroke: orange + 1pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    *#titulo* \
    #corpo
  ]
}

#nota-importante("Atenção")[
  Este é o corpo da nota com _formatação_ normal.
]
```

---

## 7. Set e show rules

Esta é a parte mais poderosa do Typst — onde você define estilos sistemáticos.

### `#set` — alterar parâmetros padrão

```typst
// Set afeta TODOS os elementos daquele tipo daqui em diante
#set text(size: 12pt)
#set par(justify: true)

// Set com seletor (afeta apenas um nível de heading)
#set heading(numbering: "1.1")
```

### `#show` — redefinir como elementos são renderizados

```typst
// Redefinir headings nível 1
#show heading.where(level: 1): it => {
  set text(size: 18pt, weight: "bold", fill: navy)
  block(above: 2em, below: 0.8em)[
    #it.body
    #line(length: 100%, stroke: 0.5pt + navy)
  ]
}

// Redefinir heading nível 2
#show heading.where(level: 2): it => {
  set text(size: 14pt, weight: "bold")
  block(above: 1.2em, below: 0.5em, it)
}

// Redefinir blocos de código
#show raw.where(block: true): it => {
  block(
    fill: luma(245),
    stroke: luma(200),
    inset: (x: 16pt, y: 10pt),
    radius: 4pt,
    width: 100%,
    text(font: "JetBrains Mono", size: 9pt, it)
  )
}

// Redefinir inline code
#show raw.where(block: false): it => {
  box(
    fill: luma(240),
    inset: (x: 3pt, y: 1pt),
    radius: 2pt,
    text(font: "JetBrains Mono", size: 9pt, it)
  )
}

// Substituição de string
#show "LaTeX": [L#super[A]T#sub[E]X]   // toda ocorrência de "LaTeX" vira o logo

// Redefinir figuras
#show figure.where(kind: image): it => {
  it
  v(0.5em)
}

// Redefinir links
#show link: it => {
  set text(fill: blue)
  underline(it)
}
```

### Seletores avançados

```typst
// Combinando seletores
#show heading.where(level: 1).or(heading.where(level: 2)): set text(fill: darkblue)

// Por label
#show <importante>: set text(fill: red)

Texto comum. #[Texto vermelho] <importante>
```

---

## 8. Layouts e posicionamento

### Colunas

```typst
// Documento inteiro em 2 colunas
#set page(columns: 2)

// Trecho em colunas
#columns(2, gutter: 1.5em)[
  Coluna da esquerda com bastante texto aqui...
  
  #colbreak()
  
  Coluna da direita começa aqui...
]
```

### Alinhamento

```typst
#align(center)[Centralizado]
#align(right)[À direita]
#align(left)[À esquerda]
#align(center + horizon)[Centralizado horizontal e vertical]
```

### Espaçamento

```typst
// Espaço horizontal
Antes #h(2cm) Depois
#h(1fr)   // ocupa todo o espaço disponível (push para a direita)

// Espaço vertical
#v(1cm)
#v(1fr)   // empurra conteúdo para o fundo da página

// Exemplo: título e data na mesma linha
#block[
  *Relatório Técnico* #h(1fr) #datetime.today().display()
]
```

### Grid e Stack

```typst
// Grid (layout em grade)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  
  [Célula 1],
  [Célula 2],
  [Célula 3],
  [Célula 4],
  [Célula 5],
  [Célula 6],
)

// Stack (empilhar elementos)
#stack(
  dir: ltr,      // ltr, rtl, ttb, btt
  spacing: 1em,
  
  rect(width: 60pt, height: 30pt, fill: red),
  rect(width: 60pt, height: 30pt, fill: green),
  rect(width: 60pt, height: 30pt, fill: blue),
)
```

### Box e Block

```typst
// box: inline, não quebra fluxo
#box(
  fill: yellow,
  inset: 4pt,
  radius: 2pt,
)[conteúdo inline]

// block: nível de bloco, aceita width/height
#block(
  fill: luma(240),
  stroke: gray,
  inset: 12pt,
  radius: 6pt,
  width: 100%,
)[
  Conteúdo do bloco com formatação própria.
]
```

### Place (posicionamento absoluto)

```typst
// Posicionar elemento no topo da página (fora do fluxo)
#place(
  top + right,
  dx: -1cm,
  dy: 1cm,
)[
  #text(size: 8pt, fill: gray)[Rascunho]
]

// Marca d'água
#place(
  center + horizon,
  rotate(-45deg, text(60pt, fill: luma(230))[RASCUNHO])
)
```

---

## 9. Templates e projetos multi-arquivo

### Estrutura de diretório recomendada

```
projeto/
├── main.typ
├── template.typ
├── capitulos/
│   ├── 01-introducao.typ
│   ├── 02-fundamentacao.typ
│   └── 03-metodologia.typ
├── assets/
│   ├── figuras/
│   └── tabelas/
└── refs.yml
```

### Criando um template

```typst
// template.typ

// Função principal do template
#let dissertacao(
  titulo: "Título da Dissertação",
  autor: "Autor",
  orientador: "Orientador",
  programa: "Programa de Pós-Graduação",
  data: datetime.today(),
  resumo: [],
  palavras-chave: (),
  body,          // <-- último parâmetro sem padrão = conteúdo do documento
) = {
  
  // Configurações globais
  set document(author: autor, title: titulo)
  
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm),
    numbering: "1",
    number-align: right,
  )
  
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: "pt",
    region: "BR",
  )
  
  set par(justify: true, leading: 0.65em)
  
  // Heading styles
  set heading(numbering: "1.1")
  
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(above: 0pt, below: 1.5em)[
      #set text(size: 16pt, weight: "bold")
      #counter(heading).display() #it.body
      #v(0.3em)
      #line(length: 100%, stroke: 0.5pt)
    ]
  }
  
  // === CAPA ===
  page(margin: 2.5cm)[
    #align(center)[
      #v(2cm)
      #image("assets/logo.png", width: 4cm)
      #v(1cm)
      #text(12pt)[*Universidade Federal do Paraná*] \
      #text(11pt)[#programa]
      #v(3cm)
      #text(16pt, weight: "bold")[#titulo]
      #v(2cm)
      #text(12pt)[#autor]
      #v(1fr)
      #text(11pt)[
        Orientador: #orientador \
        #data.display("[year]")
      ]
    ]
  ]
  
  // === RESUMO ===
  if resumo != [] {
    page[
      #heading(numbering: none, outlined: false)[Resumo]
      #resumo
      #if palavras-chave.len() > 0 {
        v(1em)
        [*Palavras-chave:* #palavras-chave.join(", ").]
      }
    ]
  }
  
  // === SUMÁRIO ===
  {
    show outline.entry.where(level: 1): set text(weight: "bold")
    outline(depth: 3, indent: true)
  }
  pagebreak()
  
  // === CONTEÚDO ===
  body
  
  // === REFERÊNCIAS ===
  bibliography("refs.yml", style: "ieee", title: "Referências")
}
```

### Usando o template

```typst
// main.typ
#import "template.typ": dissertacao

#show: dissertacao.with(
  titulo: "Implementação de Modelos de Memória Polinomial em VHDL",
  autor: "Leonardo",
  orientador: "Prof. Dr. Eduardo Lima",
  programa: "PPGEE — Engenharia Elétrica",
  resumo: [
    Este trabalho apresenta a implementação em VHDL de modelos
    de memória polinomial para linearização de amplificadores...
  ],
  palavras-chave: ("VHDL", "Memória Polinomial", "Linearização", "FPGA"),
)

#include "capitulos/01-introducao.typ"
#include "capitulos/02-fundamentacao.typ"
#include "capitulos/03-metodologia.typ"
```

### Capítulo externo

```typst
// capitulos/01-introducao.typ

= Introdução

Este capítulo apresenta a motivação e os objetivos do trabalho.

== Motivação

A linearização de amplificadores de potência é fundamental...

== Objetivos

=== Objetivo Geral

Desenvolver uma implementação em VHDL...

=== Objetivos Específicos

+ Modelar matematicamente o amplificador
+ Implementar o modelo em VHDL sintetizável
+ Validar via simulação e hardware
```

### Contadores e numeração customizada

```typst
// Criar contador personalizado
#let teorema-counter = counter("teorema")

#let teorema(corpo) = {
  teorema-counter.step()
  block(
    stroke: blue + 0.5pt,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    *Teorema #teorema-counter.display()* \
    #corpo
  ]
}

#teorema[
  Para todo $x in RR$, temos que $x^2 >= 0$.
]

#teorema[
  Segundo teorema aqui...
]
```

---

## 10. Pacotes da comunidade

Typst tem um repositório de pacotes em [typst.app/universe](https://typst.app/universe).

### Usar um pacote

```typst
// Importar da Typst Universe
#import "@preview/nome-pacote:versao": funcao1, funcao2

// Exemplos reais:
#import "@preview/min-resume:0.1.0": *
#import "@preview/cetz:0.3.2": canvas, draw
#import "@preview/codly:1.2.0": *
#import "@preview/fletcher:0.5.5": diagram, node, edge
#import "@preview/lovelace:0.3.0": pseudocode-list
```

### Pacotes úteis por categoria

| Categoria | Pacote | Descrição |
|-----------|--------|-----------|
| Diagramas | `cetz` | Desenho vetorial (tipo TikZ) |
| Diagramas | `fletcher` | Diagramas de fluxo e grafos |
| Código | `codly` | Blocos de código estilizados com numeração |
| Algoritmos | `lovelace` | Pseudocódigo formatado |
| Currículos | `min-resume` | Template de currículo minimalista |
| Slides | `polylux` | Apresentações (tipo Beamer) |
| Gráficos | `plotst` | Gráficos de função simples |
| Glossário | `glossarium` | Gerenciamento de glossário |

### Exemplo com `cetz` (diagramas)

```typst
#import "@preview/cetz:0.3.2": canvas, draw

#canvas({
  import draw: *
  
  circle((0, 0), radius: 1, fill: blue.lighten(70%))
  content((0, 0), [Centro])
  
  line((1, 0), (3, 0), mark: (end: "straight"))
  content((2, 0.3), [Seta])
  
  rect((3, -0.5), (5, 0.5), fill: red.lighten(70%))
  content((4, 0), [Rect])
})
```

### Exemplo com `codly` (código com ícone de linguagem)

```typst
#import "@preview/codly:1.2.0": *
#show: codly-init.with()

#codly(languages: (
  python: (name: "Python", icon: "🐍", color: rgb("#3572A5")),
  vhdl: (name: "VHDL", icon: "⚡", color: rgb("#ad901d")),
))

```python
def modelo_polinomial(x, coefs):
    return sum(c * x**i for i, c in enumerate(coefs))
```
```

---

## 11. Referências e dicas avançadas

### Estados (variáveis mutáveis entre páginas)

```typst
// Estado global (persiste entre locais no documento)
#let chapter-name = state("chapter", "")

// Atualizar o estado
#chapter-name.update("Introdução")

// Ler o estado
#locate(loc => chapter-name.at(loc))

// Uso prático: nome do capítulo no cabeçalho
#set page(header: context [
  #h(1fr)
  #chapter-name.get()
])
```

### Queries (consultar conteúdo do documento)

```typst
// Contar figuras no documento
#locate(loc => {
  let figs = query(<figure>, loc)
  [Total de figuras: #figs.len()]
})
```

### Cores

```typst
// Cores nomeadas
red, blue, green, black, white, gray, navy, orange, purple

// RGB
rgb("#FF5733")
rgb(255, 87, 51)
rgb(255, 87, 51, 128)   // com alpha

// HSL
hsl(10deg, 100%, 50%)

// Luma (escala de cinza)
luma(128)    // cinza médio
luma(0)      // preto
luma(255)    // branco

// Operações com cores
blue.lighten(50%)   // mais clara
blue.darken(30%)    // mais escura
blue.saturate(20%)  // mais saturada
color.mix(red, blue, space: oklch)  // mistura
```

### Comprimentos e medidas

```typst
// Absolutas
10pt, 1cm, 25mm, 1in, 96px

// Relativas ao pai
50%         // 50% da largura disponível

// Relativas à fonte
1em         // largura do "M" na fonte atual
0.65em      // altura x da fonte
1fr         // fração do espaço disponível (em grid/h/v)
```

### Datas

```typst
#datetime.today().display()                     // ex: "2025-08-15"
#datetime.today().display("[day]/[month]/[year]")  // ex: "15/08/2025"
#datetime(year: 2025, month: 8, day: 15).display("[month repr:long] de [year]")
// ex: "agosto de 2025"
```

### Quebra de página

```typst
#pagebreak()                  // quebra de página incondicional
#pagebreak(weak: true)        // só quebra se não estiver já no início de página
#colbreak()                   // quebra de coluna (em layout multi-coluna)
```

### Metadados do PDF

```typst
#set document(
  title: "Título do Documento",
  author: "Nome do Autor",
  keywords: ("typst", "tutorial", "pdf"),
  date: datetime.today(),
)
```

### Numerar equações seletivamente

```typst
// Sem numeração (padrão)
$ a^2 + b^2 = c^2 $

// Com numeração (adicionar label)
$ a^2 + b^2 = c^2 $ <eq-pitagoras>

// No set de heading para equações:
#set math.equation(numbering: "(1)")
```

### Dicas de debugging

```bash
# Ver erros detalhados
typst compile main.typ 2>&1

# Fontes disponíveis
typst fonts

# Verificar versão
typst --version
```

```typst
// Inspecionar valor de variável (tipo repr)
#repr(minha-variavel)

// Forçar erro com mensagem
#panic("Erro: variável x não pode ser zero")

// Asserção
#assert(x > 0, message: "x deve ser positivo")
```

---

## Referência rápida — Cheatsheet

### Markup

| Sintaxe | Resultado |
|---------|-----------|
| `*texto*` | **negrito** |
| `_texto_` | _itálico_ |
| `` `código` `` | `código inline` |
| `= Título` | Heading nível 1 |
| `- item` | Lista não ordenada |
| `+ item` | Lista ordenada |
| `\ ` | Quebra de linha |

### Funções de layout

| Função | Uso |
|--------|-----|
| `#align(center)[...]` | Alinhar conteúdo |
| `#h(1fr)` | Espaço horizontal elástico |
| `#v(1cm)` | Espaço vertical fixo |
| `#box[...]` | Container inline |
| `#block[...]` | Container bloco |
| `#columns(2)[...]` | Layout em colunas |
| `#grid(columns: 2)[...]` | Layout em grade |

### Matemática

| Sintaxe | Resultado |
|---------|-----------|
| `$x^2$` | x² |
| `$x_i$` | xᵢ |
| `$sqrt(x)$` | √x |
| `$sum_(i=0)^n$` | Σ com limites |
| `$integral_a^b$` | ∫ com limites |
| `$mat(a,b;c,d)$` | Matriz 2×2 |
| `$vec(x,y,z)$` | Vetor coluna |
| `$bold(A)$` | Negrito (vetor/matriz) |

---

## Recursos

- **Documentação oficial:** https://typst.app/docs
- **Typst Universe (pacotes):** https://typst.app/universe
- **Typst App (editor online):** https://typst.app
- **Fórum da comunidade:** https://forum.typst.app
- **GitHub:** https://github.com/typst/typst
- **Discord:** https://discord.gg/2uDybryKPe