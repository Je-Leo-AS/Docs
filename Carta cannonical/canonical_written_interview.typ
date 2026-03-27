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
// ────────────────────────────────────────────────────────────

== Performance & Security

=== Have you ever had to improve the performance of a software system?

// ── SUA RESPOSTA ────────────────────────────────────────────
Sim, um exemplo significativo foi a reestruturação do sistema de renderização de mapas, onde identifiquei que o processo de geração de mapas estava se tornando um gargalo critico à medida que o volume de dados aumentava. A solução envolveu a implementação de uma nova arquitetura baseada em tiles vetoriais, prototipando a solução inicialmente em Python para validar a abordagem e posteriormente reimplementando em C++ para maximizar a performance, que permitiu renderização eficiente mesmo com grandes volumes de dados. O resultado foi uma redução de 1 segundo para 2 milissegundos no tempo de renderização, melhorando significativamente a experiência do usuário e a escalabilidade do sistema. Essa experiência reforçou minha capacidade de análise de desempenho e implementação de soluções eficazes para otimizar sistemas complexos.
// ────────────────────────────────────────────────────────────

=== Have you ever had to identify and resolve a security exploit?

// ── SUA RESPOSTA ────────────────────────────────────────────
Não tive experiência direta com identificação e resolução de exploits de segurança em software. No contexto profissional, trabalhei com firmware em ambiente industrial onde a segurança era garantida principalmente pelo isolamento da rede CAN. No uso pessoal, mantenho um servidor doméstico acessado via VPN, o que me levou a aprender sobre práticas básicas de segurança de rede. Reconheço que segurança de software é uma área onde tenho muito a desenvolver, e é algo que pretendo aprofundar no contexto de kernel engineering.
// ────────────────────────────────────────────────────────────

== Programming Languages

=== C programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
Considero meu nível em C/C++ como pleno. Utilizei C extensivamente durante a graduação em projetos de firmware e sistemas embarcados incluindo um projeto de tranca automática IoT com protocolo MQTT e o desenvolvimento de firmware para o protótipo de mini baja na competição SAE Brasil. Profissionalmente desenvolvi firmware para dispositivos agrícolas utilizando C/C++, onde uma das experiências mais relevantes foi a implementação de módulos baseados na biblioteca AgIsoStack++ uma biblioteca open source C++ baseada no padrão ISOBUS/ISO-11783 que permitia enviar dados e se comunicar com o terminal virtual dos equipamentos agrícolas. Também fui responsável pelo módulo de renderização de mapas, onde reimplementei em C++ uma solução previamente prototipada em Python, reduzindo o tempo de renderização de 1 segundo para 2 milissegundos.
// ────────────────────────────────────────────────────────────

=== Python programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
Considero meu nível de Python entre pleno e sênior, com foco em análise de dados e prototipagem rápida. Comecei utilizando Python durante a graduação para scripts de cálculos complexos, como alternativa prática ao MATLAB, o que me permitiu ajudar colegas com análises do dia a dia. Com o tempo passei a utilizá-lo para tarefas mais robustas.
Durante o mestrado, Python se tornou a linguagem principal para análise de dados e modelagem matemática — utilizei numpy, scipy e matplotlib para simulação e validação do modelo de pré-distorção digital de amplificadores de potência de RF.
Na graduação, liderei o desenvolvimento de um classificador de fake news utilizando Python com NLTK para processamento de linguagem natural, atingindo 99% de acurácia nos dados de validação.
Profissionalmente utilizei pandas e geopandas para análise de dados geoespaciais, e FastAPI para desenvolvimento de microsserviços e APIs. Também prototipei o módulo de renderização de mapas em Python antes de reimplementá-lo em C++, o que reduziu o tempo de renderização de 1 segundo para 2 milissegundos. Em projetos pessoais, explorei bibliotecas como LangChain e CrewAI para experimentação com agentes de linguagem
// ────────────────────────────────────────────────────────────

=== Rust programming ability

// ── SUA RESPOSTA ────────────────────────────────────────────
Considero meu nível em Rust como júnior. Ainda não tive oportunidade de utilizá-lo em contexto profissional ou acadêmico, mas estudei a linguagem por interesse próprio e me impressionei com o modelo de ownership e o sistema de tipos, que eliminam classes inteiras de bugs de memória comuns em C/C++. Durante meu período na empresa, havia planejado reimplementar em Rust o módulo de renderização de mapas que havia desenvolvido em C++, mas não tive oportunidade antes de sair. Minha experiência com C/C++ me dá uma base sólida para evoluir em Rust, especialmente no contexto de sistemas de baixo nível e kernel engineering.
// ────────────────────────────────────────────────────────────

=== Git proficiency

// ── SUA RESPOSTA ────────────────────────────────────────────
Acredito que meu nível de proficiência em Git é avançado. Utilizo Git diariamente para controle de versão em projetos acadêmicos e profissionais, incluindo gerenciamento de branches, resolução de conflitos, pull requests para revisão de código e worktrees para trabalhar em branches diferentes em paralelo. Tenho experiência com fluxos de trabalho colaborativos como Git Flow e GitHub Flow, e utilizo comandos avançados como rebase, cherry-pick e bisect para manutenção de histórico limpo e resolução eficiente de problemas.
Além do desenvolvimento de software, o Git faz parte do meu fluxo de trabalho pessoal e acadêmico minha dissertação de mestrado e minha monografia de graduação foram escritas em projetos open source (LaTeX e Typst) com versionamento completo no Git, o que tornou o processo mais organizado e seguro. Também utilizo Git para controle de despesas com Ledger e organização de notas em Markdown no Obsidian.
Essa integração do Git em diferentes áreas do meu dia a dia reflete não apenas familiaridade técnica com a ferramenta, mas uma cultura genuína de versionamento e organização.
// ────────────────────────────────────────────────────────────

== Kernel & Embedded Systems

=== Kernel source code development, maintenance, or debugging

// ── SUA RESPOSTA ────────────────────────────────────────────
Não tenho experiência direta com desenvolvimento ou modificação de código-fonte de kernel de sistema operacional. No entanto, trabalhei profissionalmente com FreeRTOS no desenvolvimento de firmware para dispositivos agrícolas, onde lidei com gerenciamento de memória, ponteiros, estruturas de dados e listas encadeadas no contexto de um sistema operacional de tempo real. Essa experiência me deu uma compreensão prática de como um RTOS gerencia recursos e escalonamento de tarefas, mesmo sem modificar o código interno do sistema.
// ────────────────────────────────────────────────────────────

=== Embedded system environments

// ── SUA RESPOSTA ────────────────────────────────────────────
Trabalhei com diversos ambientes de sistemas embarcados ao longo da minha carreira. Durante a graduação utilizei plataformas como Arduino Uno, Nano e ESP8266 em projetos acadêmicos, incluindo uma tranca automática IoT com protocolo MQTT. Na competição SAE Brasil, utilizei o microcontrolador TM4C123GH6PM da Texas Instruments (Tiva C Series) para telemetria via RF e coleta de dados de performance do veículo, incluindo testes de dinamômetro, aceleração lateral em curvas e temperatura do motor.
Profissionalmente trabalhei em um dispositivo embarcado desenvolvido e fabricado internamente, composto por três ESP32 que se comunicavam entre si via UART bridge na mesma placa. Dois desafios técnicos foram particularmente significativos:
O primeiro foi a sincronização de dados entre os ESP32 em um unico dispositivo. O ESP0 gerava eventos que precisavam estar sempre atualizados no ESP2, que era responsável por se comunicar com o terminal virtual do trator via ISOBUS. Qualquer desincronização resultava em dados incorretos exibidos ao operador, o que exigiu um cuidado especial no design da comunicação entre os dispositivos.
O segundo foi uma limitação severa de memória. O sistema precisava permitir que o operador selecionasse fabricante e modelo de máquinas agrícolas cuja a lista continha mais de 10.000 modelos. Carregar tudo em memória era inviável, e uma implementação com SQLite se mostrou impraticável devido à latência das consultas. A solução foi armazenar os dados em arquivos binários estruturados e implementar busca binária, carregando apenas um vetor de tamanho pré-estabelecido em memória, o que resolveu o problema de forma eficiente dentro das restrições do hardware.
// ────────────────────────────────────────────────────────────

=== Real-time systems (RTOS / Linux RT)

// ── SUA RESPOSTA ────────────────────────────────────────────
Tenho experiência com sistemas de tempo real utilizando FreeRTOS no desenvolvimento de firmware para dispositivos agrícolas embarcados. Trabalhei com os principais recursos do RTOS como tasks, queues, semáforos, mutexes e gerenciamento de memória, em um sistema com múltiplas tasks concorrentes acessando memória compartilhada.
O principal desafio foi a sincronização entre tasks. Dados compartilhados entre os três ESP32 precisavam estar sempre consistentes — por exemplo, eventos gerados no ESP0 precisavam estar atualizados no ESP2, que era responsável por exibir informações no terminal virtual do trator via ISOBUS. O uso incorreto de semáforos nessa memória compartilhada resultou em situações de deadlock, que exigiram uma revisão cuidadosa da ordem de aquisição de locks e da arquitetura de comunicação entre tasks.
Também enfrentei problemas com watchdog — tasks que bloqueavam por tempo excessivo aguardando recursos causavam reset do sistema. A solução envolveu revisar os timeouts de aquisição de semáforos e garantir que nenhuma task ficasse bloqueada indefinidamente, adicionando tratamento explícito para casos de timeout.
Essas experiências me deram uma compreensão prática de concorrência, sincronização e os desafios inerentes a sistemas de tempo real com recursos limitados.
// ────────────────────────────────────────────────────────────

== Packaging & Firmware

=== Packaging and container formats (Debian, Snap, etc.)

// ── SUA RESPOSTA ────────────────────────────────────────────
Não tenho experiência direta criando pacotes nos formatos debian, snap ou similares. No entanto, tenho experiência prática com Docker — criando e configurando Dockerfiles para ambientes de desenvolvimento e produção.
Um exemplo concreto surgiu quando o projeto rodava em produção dentro de um container com memória e espaço pré-definidos, mas os erros não se reproduziam quando rodava diretamente na minha máquina. Para investigar, criei um Dockerfile que replicava exatamente o ambiente de produção e mapeei o projeto dentro do container, o que me permitiu debugar o código C++ diretamente no mesmo ambiente onde os erros ocorriam.
Dessa forma consegui identificar e resolver problemas que eram invisíveis fora do container, incluindo overflow de memória, erros de lógica e problemas na interpretação dos dados recebidos, todos causados pelas restrições específicas do ambiente de produção.
Essa experiência me mostrou o valor de ambientes reproduzíveis e isolados para debugging, e despertou meu interesse em aprender mais sobre formatos de pacotes como debian e snap, especialmente no contexto de distribuições Linux.
// ────────────────────────────────────────────────────────────

=== EFI, ACPI and/or DeviceTree experience

// ── SUA RESPOSTA ────────────────────────────────────────────
Não tenho experiência profissional com EFI, ACPI ou DeviceTree, mas estou estudando essas tecnologias no meu Arch Linux como parte da minha preparação para kernel engineering.
// ────────────────────────────────────────────────────────────

== Open Source & Automation

=== Open source projects you have actively participated in

// ── SUA RESPOSTA ────────────────────────────────────────────
Minha participação em projetos open source foi majoritariamente indireta, no sentido de utilizar, estudar e em alguns casos estender ferramentas existentes, mais do que contribuir diretamente com commits em repositórios públicos.
Um exemplo relevante foi o uso da biblioteca AgIsoStack++, uma implementação open source em C++ do padrão ISOBUS (ISO-11783), utilizada no desenvolvimento de firmware para dispositivos agrícolas. Trabalhei diretamente com essa biblioteca para implementar comunicação com o terminal virtual de tratores, o que exigiu leitura detalhada do código-fonte, entendimento da arquitetura e adaptação ao contexto específico do dispositivo embarcado. Embora não tenha contribuído diretamente com código upstream, essa experiência me deu familiaridade com leitura e integração de código open source complexo em sistemas de produção.
Além disso, utilizo extensivamente ferramentas open source no meu fluxo de trabalho diário, como Arch Linux, Git, LaTeX e Typst. Em particular, o uso do Arch Linux me expôs ao ecossistema de build e distribuição de software através do AUR, onde frequentemente analiso PKGBUILDs, entendo dependências e processos de build, o que contribuiu para uma compreensão mais prática de como software open source é estruturado e distribuído.
No contexto acadêmico e pessoal, meus projetos são desenvolvidos com base em ferramentas open source e versionados publicamente ou de forma privada com Git, seguindo práticas comuns da comunidade. Embora minha contribuição direta para projetos open source ainda seja limitada, tenho interesse em aumentar esse envolvimento, especialmente em áreas relacionadas a sistemas de baixo nível e kernel Linux, onde já venho direcionando meus estudos.
// ────────────────────────────────────────────────────────────

=== CI/CD, workflow engines, and back-end process automation

// ── SUA RESPOSTA ────────────────────────────────────────────
Tenho experiência prática com CI/CD principalmente utilizando GitHub Actions, tanto em contexto profissional quanto em projetos pessoais, com foco em automação de build, testes e geração de artefatos.
Em projetos pessoais, desenvolvi um workflow utilizando GitHub Actions para automatizar a geração do meu currículo em inglês a partir de uma versão em português escrita em Typst. A cada push na branch main, o pipeline era executado automaticamente, compilando o documento e gerando o PDF final como artefato. Esse processo eliminou etapas manuais e garantiu consistência entre versões, além de servir como um exemplo prático de automação aplicada a um fluxo simples, mas recorrente.
Também utilizei Docker como ferramenta complementar para garantir reprodutibilidade de ambiente, especialmente em situações onde erros ocorriam apenas em produção. Ao criar containers que replicavam fielmente o ambiente real, consegui integrar esse fluxo ao desenvolvimento, facilitando debugging e reduzindo inconsistências entre ambientes.
De forma geral, minha experiência com CI/CD está mais concentrada em integração contínua e automação de processos de build e entrega. Reconheço que ainda posso evoluir em pipelines mais complexos, como testes em múltiplas camadas e validações mais robustas, e esse é um ponto que tenho interesse em aprofundar, especialmente em ambientes mais próximos de sistemas críticos.
// ────────────────────────────────────────────────────────────

== Machine Learning

=== Experience with machine learning, ANNs, and classification

// ── SUA RESPOSTA ────────────────────────────────────────────
Tenho experiência prática com machine learning principalmente no contexto acadêmico, com foco em modelagem matemática, processamento de sinais e classificação.

Durante a graduação, tive uma base sólida em machine learning por meio de disciplinas específicas na área, onde estudei conceitos fundamentais como modelos de neurônios artificiais, funções de ativação e processos de treinamento. Como parte desses estudos, desenvolvi um controlador simples baseado em um único neurônio utilizando função de ativação tanh, onde os parâmetros de entrada eram o erro, sua soma e sua derivada, de forma análoga a um controlador PID (kp, ki, kd). Essa experiência me ajudou a entender, de forma prática, como modelos baseados em neurônios podem ser aplicados em problemas de controle.
Também durante a graduação, liderei o desenvolvimento de um classificador de fake news utilizando Python, aplicando técnicas de processamento de linguagem natural com a biblioteca NLTK. O modelo foi treinado e validado com um conjunto de dados rotulado, atingindo aproximadamente 99% de acurácia nos dados de validação. Esse projeto envolveu desde o pré-processamento dos dados até a escolha e avaliação do modelo de classificação.
No mestrado, minha experiência está mais voltada para modelagem de sistemas não lineares do que para classificação direta. Desenvolvi uma variação do modelo Memory Polynomial para pré-distorção digital de amplificadores de potência de RF, utilizando Python para simulação e validação. Embora não seja um modelo baseado em redes neurais, o problema envolve ajuste de parâmetros a partir de dados e otimização de desempenho, conceitos próximos de machine learning.
De forma geral, minha experiência com machine learning está mais direcionada para entendimento dos fundamentos e aplicação prática em problemas específicos do que para uso extensivo de frameworks modernos. Tenho interesse em aprofundar esse conhecimento, especialmente em aplicações que envolvam otimização, sistemas embarcados e integração com software de baixo nível.
// ────────────────────────────────────────────────────────────

== Fit for the Role

=== How have your prior experiences prepared you for a downstream kernel role (backporting, packaging, qualification)?

// ── SUA RESPOSTA ────────────────────────────────────────────
Minha experiência me preparou para esse tipo de função principalmente pela proximidade constante com sistemas de baixo nível, integração com hardware e necessidade de operar dentro de restrições reais de desempenho e recursos.
Ao longo da minha trajetória, trabalhei extensivamente com firmware e sistemas embarcados utilizando C/C++ e FreeRTOS, onde precisei lidar diretamente com gerenciamento de memória, concorrência, sincronização entre tarefas e comunicação entre dispositivos. Esse tipo de ambiente exige uma abordagem cuidadosa e determinística, muito próxima dos desafios encontrados no desenvolvimento e manutenção de componentes do kernel Linux.
Em particular, a experiência com sistemas embarcados me expôs a problemas clássicos de integração entre hardware e software, como comunicação via protocolos específicos, sincronização de dados entre múltiplos dispositivos e operação sob limitações severas de memória. Esses cenários são análogos ao trabalho de integração de drivers e suporte a dispositivos no kernel, onde a compreensão do comportamento do hardware e a confiabilidade do software são críticas.
Além disso, minha atuação em análise e otimização de desempenho, como no caso da reestruturação do sistema de renderização de mapas, reforçou minha capacidade de identificar gargalos, propor soluções arquiteturais e implementar melhorias significativas em sistemas existentes. Esse tipo de trabalho é diretamente aplicável ao contexto de manutenção e evolução de código downstream, onde frequentemente é necessário adaptar soluções para diferentes ambientes e requisitos.
Embora eu não tenha experiência direta com desenvolvimento upstream do kernel Linux ou com processos formais de backporting, tenho familiaridade com o ecossistema Linux através do uso intensivo de Arch Linux, além de experiência prática com ambientes reproduzíveis utilizando Docker e pipelines de CI/CD. Isso me dá uma base sólida para evoluir rapidamente em tarefas relacionadas a empacotamento, integração e qualificação de software.
De forma geral, acredito que minha combinação de experiência em sistemas embarcados, foco em desempenho, capacidade de trabalhar com restrições reais e forte autonomia me prepara bem para um papel focado em manutenção, integração e evolução do kernel Linux em um contexto downstream. Vejo essa oportunidade como uma evolução natural da minha trajetória em direção a sistemas ainda mais próximos do hardware e com maior impacto em larga escala.
// ────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
= Education
// ════════════════════════════════════════════════════════════

== High School

=== Competitive ranking in maths and hard sciences

// ── SUA RESPOSTA ────────────────────────────────────────────
Durante o ensino médio, tive um bom desempenho em matemática e física, que eram minhas áreas de maior interesse. Sempre tive facilidade com lógica e resolução de problemas, especialmente em matemática, e em física me interessava bastante pelas partes mais aplicadas, como eletricidade e sistemas. Esse interesse acabou influenciando diretamente minha decisão de seguir Engenharia Elétrica.Nunca
// ────────────────────────────────────────────────────────────

=== Competitive ranking in languages and the arts

// ── SUA RESPOSTA ────────────────────────────────────────────
Em linguagens e artes, meu desempenho foi mais dentro da média. Português e artes não eram áreas de maior interesse, mas sempre mantive um nível consistente. O inglês na escola não era muito forte, então busquei desenvolver isso por conta própria, fazendo curso após as aulas. Esse esforço acabou sendo importante mais tarde, principalmente para leitura de documentação técnica e conteúdos na área de tecnologia.
// ────────────────────────────────────────────────────────────

=== What kind of high school student were you? Interests and hobbies?

// ── SUA RESPOSTA ────────────────────────────────────────────
No ensino médio eu era um aluno mediano, estudava o suficiente para cumprir minhas obrigações e passar nas disciplinas, sem me destacar academicamente. Apesar disso, sempre tive consciência do meu dever com o aprendizado e com minha família, o que me mantinha responsável e comprometido com o mínimo necessário.
Fora da escola era bastante ativo fisicamente, praticava futebol e academia com frequência, o que me ajudou a desenvolver disciplina e constância.
Minha vontade real de aprender surgiu na faculdade, quando entrei em contato com tecnologia e engenharia. Foi ali que me realizei academicamente — descobri uma área que me motivava genuinamente, o que transformou completamente minha relação com o aprendizado e o esforço
// ────────────────────────────────────────────────────────────

== University

=== Which university and degree did you choose? What others did you consider?

// ── SUA RESPOSTA ────────────────────────────────────────────
Escolhi Engenharia Elétrica pois sempre tive curiosidade para entender como hardware e circuitos elétricos funcionam. Escolhi a Universidade Federal do Paraná (UFPR) pois era a melhor universidade na minha cidade, com um programa de engenharia elétrica bem estruturado, reconhecido no mercado de trabalho, e um corpo docente com experiência em áreas do meu interesse como sistemas embarcados, processamento de sinais e controle. Prestei vestibular exclusivamente para a UFPR, pois era minha primeira e única opção. Considerei também Engenharia Mecânica, que é uma área muito interessante, mas optei pela Engenharia Elétrica por me identificar mais com o curso na época da escolha
// ────────────────────────────────────────────────────────────

=== Did you do particularly well in any area of your degree?

// ── SUA RESPOSTA ────────────────────────────────────────────
Sim, para contextualizar, o curso de Engenharia Elétrica não é muito focado em software — pelo contrário, foca quase exclusivamente em hardware, física e lógica booleana, sendo o nível mais baixo possível. Fui especialmente bem nas disciplinas de Eletrônica Digital, Firmware e Microeletrônica, onde tive a oportunidade de desenvolver projetos práticos com microcontroladores, sistemas embarcados e síntese de circuitos lógicos usando VHDL. Além disso, tive bom desempenho em disciplinas de controle e processamento de sinais, que foram fundamentais para minha formação e para o desenvolvimento do meu projeto de mestrado. Essas áreas me motivaram bastante e me deram uma base sólida para minha carreira em engenharia, especialmente em contextos próximos ao hardware
// ────────────────────────────────────────────────────────────

=== Overall degree result and what it reflects about you

// ── SUA RESPOSTA ────────────────────────────────────────────
Meu resultado geral na graduação foi um IRA de 0.8466, que considero um reflexo honesto da minha trajetória acadêmica. Durante a pandemia ficamos aproximadamente um ano sem aulas, e quando retornamos enfrentamos uma grade extremamente comprimida — seis semestres de conteúdo condensados em dois anos.
Optei conscientemente por fazer menos disciplinas por semestre em vez de acompanhar o ritmo acelerado, priorizando a qualidade do aprendizado em vez da velocidade de conclusão. Isso resultou em uma formatura mais tardia, mas me permitiu assimilar melhor o conteúdo e dedicar o último ano quase exclusivamente ao meu TCC, que era um projeto de alta complexidade técnica.
Acredito que essa decisão reflete minha forma de encarar o aprendizado — prefiro fazer menos e fazer bem do que acumular aprovações superficiais. O IRA de 0.8466 reflete essa consistência e comprometimento ao longo do curso.
// ────────────────────────────────────────────────────────────

=== Exceptional achievements in high school and university

// ── SUA RESPOSTA ────────────────────────────────────────────
No ensino médio recebi o prêmio de aluno destaque, concedido a estudantes que demonstravam evolução acadêmica consistente ao longo dos anos — o que refletiu meu comprometimento em melhorar progressivamente.
Na universidade, minhas conquistas mais expressivas foram na competição SAE Brasil com a equipe de mini baja. Fui responsável pela parte elétrica do veículo e nossa equipe conquistou o troféu de melhor projeto elétrico na regional Sul em dois anos consecutivos— 1º lugar no primeiro ano e 2º lugar no segundo além de alcançar o 7º lugar no campeonato nacional, uma melhora expressiva que refletiu o trabalho e evolução da equipe.
Também considero excepcional minha participação no PET durante a pandemia, onde coordenei a produção e logística de impressão de suportes para máscaras face shield doadas a hospitais uma entrega concreta com impacto humanitário real em um momento crítico.
No BigPET, liderei o desenvolvimento de um classificador de fake news em Python com NLTK que atingiu 99% de acurácia nos dados de validação, sendo meu principal projeto de machine learning na graduação.
// ────────────────────────────────────────────────────────────

=== Leadership roles during education

// ── SUA RESPOSTA ────────────────────────────────────────────
Todos os meus papéis de liderança foram durante a graduação. No Programa de Educação Tutorial (PET), exerci liderança em dois projetos distintos por aproximadamente 3 anos, coordenando equipes de 5 pessoas em cada um.


No PET3D, durante a pandemia, coordenei a equipe e a logística de produção de suportes para máscaras face shield doadas a hospitais — o que exigiu organização de escalas para manter as impressoras 3D operando continuamente.
No BigPET, liderei o desenvolvimento de um classificador de fake news utilizando Python e NLTK, atingindo 99% de acurácia nos dados de validação.
Também atuei como monitor bolsista nas disciplinas de Eletrônica Digital, ministrando aulas online durante a pandemia, e Microeletrônica, conduzindo sessões presenciais duas vezes por semana para turmas de mais de 10 alunos
// ────────────────────────────────────────────────────────────


// ════════════════════════════════════════════════════════════
= Context
// ════════════════════════════════════════════════════════════

== Canonical's Mission

=== Your thoughts on Canonical's mission. What is most appealing? What seems risky or unappealing?

// ── SUA RESPOSTA ────────────────────────────────────────────
A missão da Canonical ressoa diretamente com meus valores pessoais. Sou um forte adepto do open source — foi inclusive um dos principais motivos que me levaram a migrar do Windows para o Linux. Acredito que o software livre é fundamental para criar uma alternativa real ao domínio das grandes empresas de tecnologia.
O que mais me atrai na Canonical é o potencial do Ubuntu como alternativa viável ao desktop doméstico. Apesar do Windows liderar o mercado, acredito que ele está estagnado — e o Linux está evoluindo rapidamente para preencher esse espaço. Um exemplo claro é o mercado gamer: apesar de muitos jogos ainda serem exclusivos do Windows, ferramentas como Proton e Wine estão contornando essa barreira de forma cada vez mais eficiente, e sistemas operacionais voltados para jogos como SteamOS e Bazzite mostram que o Linux está se tornando uma alternativa real também para esse público. Por ser a distribuição mais popular e com maior aceitação no mercado, o Ubuntu está em uma posição única para liderar essa transição.
Em termos de riscos, vejo a competição com grandes players como Microsoft e Red Hat como um desafio constante — especialmente no mercado enterprise, onde a migração para Linux ainda enfrenta resistência cultural e de ecossistema. Além disso, o fato de a vaga ser mais orientada para downstream — backporting, packaging e qualificação do kernel — do que para contribuição upstream pode ser visto como uma limitação para quem busca contribuir diretamente com o kernel Linux. No entanto, entendo que esse trabalho é igualmente essencial para garantir a qualidade e estabilidade do Ubuntu
// ────────────────────────────────────────────────────────────


== Competitive Landscape

=== Who are Canonical's key competitors, and how should Canonical set about winning?

// ── SUA RESPOSTA ────────────────────────────────────────────
Os principais competidores da Canonical variam dependendo do segmento de mercado. No desktop doméstico, o Windows é o líder absoluto e o principal concorrente — no entanto, acredito que o Windows está estagnado, abrindo espaço para o Ubuntu crescer. Uma estratégia interessante seria tornar a experiência do Ubuntu mais familiar para usuários Windows, aproximando a interface do que eles já conhecem — como fazem distribuições como o Zorin OS. Isso reduziria a barreira de adoção para usuários comuns.
No mercado enterprise, o Red Hat é o principal concorrente, sendo historicamente mais popular nesse segmento. Para ganhar terreno, a Canonical precisa continuar investindo em suporte profissional, certificações e integrações com as principais plataformas de cloud — onde o Ubuntu já tem boa presença.
Entre entusiastas de Linux, o Debian e o Fedora são referências fortes, mas o Ubuntu já é o líder de mercado nesse segmento, o que é uma vantagem significativa.
De forma geral, acredito que a maior oportunidade da Canonical está no desktop doméstico — especialmente à medida que ferramentas como Proton e Wine quebram a barreira dos jogos exclusivos do Windows, e distribuições voltadas para jogos como SteamOS e Bazzite mostram que o Linux está se tornando uma alternativa viável também para o público gamer.
// ────────────────────────────────────────────────────────────

---

== Motivation

=== Why do you most want to work for Canonical?

// ── SUA RESPOSTA ────────────────────────────────────────────
O que mais me atrai na Canonical é a oportunidade de trabalhar diretamente com o kernel Linux. Sou usuário de Linux por convicção — migrei do Windows para o Arch Linux por acreditar no open source — e poder contribuir profissionalmente para a estabilidade e evolução do kernel do Ubuntu, uma distribuição usada por milhões de pessoas, é algo que me motiva profundamente. Mesmo que o trabalho seja predominantemente downstream — backporting, packaging e qualificação — entendo que é exatamente esse trabalho que garante a qualidade e confiabilidade do Ubuntu para seus usuários. Além disso, o modelo de trabalho 100% remoto da Canonical se alinha perfeitamente com minha situação atual, morando na Austrália
// ────────────────────────────────────────────────────────────

=== What would you most want to change about Canonical?

// ── SUA RESPOSTA ────────────────────────────────────────────
O que eu mais mudaria na Canonical é a abordagem em relação ao formato Snap. Apesar de entender a motivação técnica por trás da sua criação — resolver a fragmentação do ecossistema Linux e facilitar a distribuição de software multiplataforma — o modelo centralizado da Snapstore vai diretamente contra os princípios de transparência e descentralização que fundamentam o open source. Ter um repositório fechado e controlado exclusivamente pela Canonical cria uma dependência que contradiz a própria filosofia que a empresa defende, o que naturalmente gera desconfiança na comunidade e questiona a credibilidade da empresa como defensora do software livre.
Nesse sentido, substituiria o Snap pelo Flatpak — ou pelo menos adotaria uma abordagem similar, com um repositório aberto e descentralizado onde qualquer pessoa ou organização pudesse hospedar seus próprios pacotes. Isso manteria os benefícios técnicos de um formato universal de empacotamento sem sacrificar os valores que tornam o Linux e o open source tão importantes para a comunidade
// ─────────────────────────────────────────────────

=== What gets you most excited about this role?

// ── SUA RESPOSTA ────────────────────────────────────────────
O que mais me empolga nessa vaga é a oportunidade de contribuir ativamente para o ecossistema open source em um nível que ainda não explorei profissionalmente. Ao longo da minha carreira trabalhei próximo ao hardware firmware, microcontroladores, sistemas embarcados mas sempre com uma camada de abstração entre o meu trabalho e o sistema operacional. Essa vaga representa a chance de cruzar essa fronteira e aprender de forma profunda como o kernel Linux funciona internamente backporting, packaging, qualificação — trabalho que é invisível para a maioria dos usuários mas essencial para que o Ubuntu funcione de forma estável e confiável em milhões de dispositivos.

Também me empolga muito o crescimento do RISC-V como uma arquitetura genuinamente open source e gratuita. Acredito que o RISC-V tem potencial para se tornar a arquitetura dominante na computação doméstica e embarcada no futuro, e poder contribuir para que o Ubuntu seja uma referência nessa arquitetura desde cedo é uma oportunidade única.
Por fim, o que me motiva de forma mais profunda é poder contribuir para melhorar a experiência do usuário final do Linux e ajudar a tornar as distribuições Linux o sistema operacional mais popular do mundo. Acredito que esse é o caminho natural da computação — aberta, colaborativa e acessível a todos — e quero fazer parte dessa transformação.
// ────────────────────────────────────────────────────────────
