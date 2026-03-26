// ============================================================
// Canonical – Lead Linux Kernel Engineer
// Written Interview Template
// ============================================================
// INSTRUÇÕES:
//   - NÃO coloque nome, email ou qualquer dado identificador
//   - Preencha cada resposta abaixo do respectivo comentário
//   - Compile com: typst compile canonical_written_interview.typ
// ============================================================

#set document(title: "Written Interview – Lead Linux Kernel Engineer")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
)
#set text(size: 11pt, lang: "en")
#set par(justify: true, leading: 0.75em)
#show heading.where(level: 1): it => {
  v(1.2em)
  block(
    fill: rgb("#1a1a2e"),
    inset: (x: 10pt, y: 7pt),
    radius: 4pt,
    width: 100%,
    text(fill: white, size: 13pt, weight: "bold", it.body)
  )
  v(0.4em)
}
#show heading.where(level: 2): it => {
  v(0.9em)
  text(size: 11.5pt, weight: "bold", fill: rgb("#1a1a2e"), it.body)
  v(0.1em)
  line(length: 100%, stroke: 0.5pt + rgb("#cccccc"))
  v(0.3em)
}
#show heading.where(level: 3): it => {
  v(0.5em)
  text(size: 10.5pt, weight: "bold", style: "italic", fill: rgb("#333333"), it.body)
  v(0.2em)
}

// ── Cabeçalho ───────────────────────────────────────────────
#align(center)[
  #v(0.5em)
  #text(size: 20pt, weight: "bold")[Written Interview]
  #v(0.3em)
  #text(size: 13pt, fill: rgb("#555555"))[Lead Linux Kernel Engineer – Ubuntu · Canonical]
  #v(0.5em)
  #line(length: 60%, stroke: 1pt + rgb("#1a1a2e"))
  #v(1.5em)
]

// ════════════════════════════════════════════════════════════
= Engineering Experience
// ════════════════════════════════════════════════════════════

== Technical Background

=== Please give a brief description of your technical background.

// ── SUA RESPOSTA ────────────────────────────────────────────
Tenho formação em Engenharia Elétrica, com foco em sistemas de baixo nível desde a graduação, onde desenvolvi projetos envolvendo hardware, firmware e sistemas embarcados. Ao longo desse período, utilizei software para resolver problemas práticos, incluindo cálculos numéricos, lógica de controle e tomada de decisão em tempo real. Atualmente estou finalizando meu mestrado, no qual proponho uma variação do modelo Memory Polynomial clássico para pré-distorção digital de amplificadores de potência de RF, utilizando Python e VHDL. O foco trabalho é eficiência computacional com viabilidade de implementação em hardware.
Profissionalmente atuei no desenvolvimento de firmware para dispositivos agrícolas, utilizando C/C++ com FreeRTOS em microcontroladores responsáveis pela coleta e processamento de dados via rede CAN, permitindo comunicação confiável entre diferentes equipamentos. Além disso desenvolvi micro-serviços em Python para análise de dados e renderização de mapas 2D.
Utilizo Arch Linux como sistema operacional principal, o que aprofundou meu entendimento sobre o funcionamento interno de sistemas Linux incluindo gerenciamento de pacotes, configuração de ambiente troubleshooting e reforçou meu interesse em trabalhar diretamente com o kernel Linux. 
// ────────────────────────────────────────────────────────────


== Leadership & Product Ownership

=== What has been your most senior role in a software engineering organisation?

// ── SUA RESPOSTA ────────────────────────────────────────────
Embora meu cargo formal mais sênior tenha sido de engenheiro software júnior, atuei com alto nível de autonomia sendo responsável por decisões técnicas e pela evolução de componentes criticos do sistema, como o modulo de renderização de mapas. Nesse contexto fui o principal responsável por analisar problemas de desempenho e propor soluções arquitarias e conduzir a implementação das melhorias, desde a prototipagem até a entrega em produção. Após a transição para modelo de trabalho remoto, passei a operar com ainda mais autonomia, organizando meu próprio fluxo de trabalho e garantindo entregas consistentes, sem necessidade de acompanhamento, oque reforçou minha capacidade de execução independente e responsabilidade sobre os resultados. Além da experiência profissional exerci liderança direta durante a graduação no Programa de Educação Tutorial (PET), onde liderei uma equipe de 5 pessoas por aproximadamente 3 anos em projetos distintos. Nessas iniciativas, fui responsável por organização do trabalho, definição de prioridades e coordenação técnica de entregas. Também atuei como monitor nas disciplinas de Eletrônica Digital e microeletrônica, conduzindo sessões regulares de apoio à alunos, o que desenvolvi minha capacidade em comunicação técnica e liderança em ambientes colaborativos.
// ────────────────────────────────────────────────────────────

=== What software products have you yourself led which shipped many releases to multiple customers?

// ── SUA RESPOSTA ────────────────────────────────────────────
Fui responsável por liderar a restruturação do sistema de renderização de mapas, utilizado por empresas do setor agrícola, incluindo grandes clientes como John Deere, Raízen e Agris. O sistema original apresentava limitações de desempenho ao lidar com grandes volume de dados por exemplo, a visualização de dados de múltiplas maquina ao longo de 30 dias resultava, em tempo de carregamento elevados e baixa responsividade no navegador. Identifiquei ineficiências na abordagem existente e propus uma nova arquitetura baseada em tiles vetoriais. Desenvolvi inicialmente um protótipo em python para validação da solução e posteriormente implementei a versão final em C++. Como resultado o tempo de renderização foi reduzido de aproximandamente 1 segundo para 2 milissegundos, melhorando significativamente a experiência do usuário e a escalabilidade do sistema. 

// ────────────────────────────────────────────────────────────

=== What is your proudest success as an engineering leader?

// ── SUA RESPOSTA ──────────────────────────────────────────── 
Um dos projetos que mais me orgulho foi a reestruturação do sistema de renderização de mapas, onde consegui transformar um gargalo critico de desempenho em uma solução altamente eficiente, com impacto direto na experiência dos usuários e na viabilidade do produto em escala. Além disso destaco minha atuação no projeto PET3D durante a pandemia, onde liderei a organização da produção de suporte para mascara face shield utilizando impressão 3D, coordenei a equipe e a logística para garantir operação continua e eficiente, resultando na produção de milhares de unidades destinadas a hospitais. Essa experiência reforçou minha capacidade de liderança em situações de alta pressão e impacto real.
// ────────────────────────────────────────────────────────────

---

== Linux Distribution Experience

=== Describe any direct involvement with the release of a public Linux distribution.

// ── SUA RESPOSTA ────────────────────────────────────────────
Não tive direta no desenvolvimento ou release de uma distribuição Linux pública. No entanto, utilizo Arch Linux como sistema operacional principal, o que me proporcionou experiência pratica com instalação manual, configuração de sistemas, gerenciamento de pacotes com pacman e uso do ecosistema de AUR. Esse ambiente exige entendimento detalhado do funcionamento do sistema, resolução de problemas e controle sobre dependências e builds. Essa experiência foi fundamental para desenvolver meu interesse em trabalhar mais profundamente com o kernel Linux e com o ecosistema de distribuições.
// ────────────────────────────────────────────────────────────

== Documentation & Quality

=== Describe an experience with a good software documentation process.

// ── SUA RESPOSTA ────────────────────────────────────────────
Uma experiência marcante foi a necessidade de dar manutenção em um módulo critico que não possuía qualquer tipo de documentação. Isso tornou o processo lento e propenso a erros, exigindo tempo significativo apenas para o entendimento do funcionamento do código. A partir dessa experiência, passei a valorizar muito mais uma abordagem de documentação em duas camadas: 

- Documentação externa, como guias  e descrições arquiteturais, que facilitam o onboarding e uso.

- Documentação interna no código, que facilita manutenção e evolução.

Em projetos posteriores, utilizei ferramentas como doxeygen para gerar documentação estruturada a partir do código, garantindo consistência entre implementação e documentação. acredito que uma boa documentação não apenas melhora a manutenção, mas também reduz dependência de indivíduos específicos dentro da equipe.
// ────────────────────────────────────────────────────────────

=== Describe an experience with a good (or poor) software quality process.

// ── SUA RESPOSTA ────────────────────────────────────────────
Na empresa onde atuei, existiam praticas básicas de qualidade, como uso de github actions para automação de deploy e desenvolvimento de testes unitários antes do envio de código no entanto, não havia um processo estruturado de codereview o que resultava em código sendo integrado a produção sem validação de outros engenheiros. Isso levou a situações onde módulos criticos eram pouco compreendidos pela equipe, dificultando manutenção e evolução. Minha abordagem seria estabelecer codereview obrigatório como parte do fluxo de desenvolvimento, não apenas para identificar erros mas também para disseminar conhecimento, melhorar a qualidade do código e reduzir riscos operacionais. Além disso, ampliaria o uso de CI/CD para executar teste automatizados a cada commit garantindo maior confiabilidade e feedback rápido durante o desenvolvimento.
// ───────────────────────────────────────────────────────────

== Performance & Security

=== Have you ever had to improve the performance of a software system?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Have you ever had to identify and resolve a security exploit?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Programming Languages

=== C programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Python programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Rust programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Git proficiency

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Kernel & Embedded Systems

=== Kernel source code development, maintenance, or debugging

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Embedded system environments

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Real-time systems (RTOS / Linux RT)

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Packaging & Firmware

=== Packaging and container formats (Debian, Snap, etc.)

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== EFI, ACPI and/or DeviceTree experience

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Open Source & Automation

=== Open source projects you have actively participated in

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== CI/CD, workflow engines, and back-end process automation

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Machine Learning

=== Experience with machine learning, ANNs, and classification

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Fit for the Role

=== How have your prior experiences prepared you for a downstream kernel role (backporting, packaging, qualification)?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
= Education
// ════════════════════════════════════════════════════════════

== High School

=== Competitive ranking in maths and hard sciences

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Competitive ranking in languages and the arts

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== What kind of high school student were you? Interests and hobbies?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== University

=== Which university and degree did you choose? What others did you consider?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Did you do particularly well in any area of your degree?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Overall degree result and what it reflects about you

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Exceptional achievements in high school and university

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== Leadership roles during education

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
= Context
// ════════════════════════════════════════════════════════════

== Canonical's Mission

=== Your thoughts on Canonical's mission. What is most appealing? What seems risky or unappealing?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Competitive Landscape

=== Who are Canonical's key competitors, and how should Canonical set about winning?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

---

== Motivation

=== Why do you most want to work for Canonical?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== What would you most want to change about Canonical?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────

=== What gets you most excited about this role?

// ── SUA RESPOSTA ────────────────────────────────────────────
#lorem(0)
// ────────────────────────────────────────────────────────────
