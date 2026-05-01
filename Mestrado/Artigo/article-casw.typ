#set page(
  paper: "us-letter",
  margin: (top: 1.04in, bottom: 1.11in, left: 0.75in, right: 0.75in),
)

#set text(font: "Libertinus Serif", size: 9pt, lang: "en")
#set par(justify: true, leading: 0.56em)
#set heading(numbering: "1")
#set figure.caption(position: bottom)
#set math.equation(numbering: "(1)")

#set ref(supplement: it => {
  if it.func() == figure {
    "Fig. "
  } else if it.func() == table {
    "Table "
  } else {
    "Sec. "
  }
})

#let conference-short = "WCAS'26"
#let conference-long = "WCAS'26, August 24-28, 2026, São Paulo, SP, Brazil"
#let running-authors = "Anonymous Authors"
#let isbn = "Internal document"
#let doi = ""
#let title = "Power Amplifier Modeling Using Memory Polynomials with Delay-dependent Polynomial Orders"
#let subtitle = "Nonlinear modeling, power amplifier and VHDL implementation"

#let authors = (
  (
    name: "Author 1",
    note: "",
    dept: "Anonymous Department",
    inst: "Anonymous Institution",
    city: "Anonymous City, Country",
    email: "author1@example.com",
  ),
  (
    name: "Author 2",
    note: "",
    dept: "Anonymous Department",
    inst: "Anonymous Institution",
    city: "Anonymous City, Country",
    email: "author2@example.com",
  ),
  (
    name: "Author 3",
    note: "",
    dept: "Anonymous Department",
    inst: "Anonymous Institution",
    city: "Anonymous City, Country",
    email: "author3@example.com",
  ),
  (
    name: "Author 4",
    note: "",
    dept: "Anonymous Department",
    inst: "Anonymous Institution",
    city: "Anonymous City, Country",
    email: "author4@example.com",
  ),
)

#let title-block() = [
  #align(center)[
    #text(size: 17pt, weight: "bold")[#title]
    #v(0.3em)
    #text(size: 10pt)[#subtitle]
  ]
]

#let author-block(author) = [
  #align(center)[
    #text(size: 10.5pt, weight: "bold")[#author.name#author.note] \
    #text(size: 9.4pt)[#author.dept] \
    #text(size: 9.4pt)[#author.inst] \
    #text(size: 9.4pt)[#author.city] \
    #text(size: 9.4pt)[#link("mailto:" + author.email)[#author.email]]
  ]
]

#let acm-reference-format = [
  #text(weight: "bold")[ACM Reference Format:]
  Anonymous Authors. 2026.
  #title. WCAS, 5 pages.
]

#show heading.where(level: 1): it => {
  v(0.8em)
  if it.numbering != none {
    text(size: 11pt, weight: "bold")[#counter(heading).display(it.numbering) #h(0.35em) #it.body]
  } else {
    text(size: 11pt, weight: "bold")[#it.body]
  }
  v(0.35em)
}

#show heading.where(level: 2): it => {
  v(0.6em)
  if it.numbering != none {
    text(style: "italic", weight: "bold")[#counter(heading).display(it.numbering) #h(0.3em) #it.body]
  } else {
    text(style: "italic", weight: "bold")[#it.body]
  }
  h(0.3em)
}

#let first-page-body(body) = context {
  let page-num = counter(page).get().first()
  [
    #if page-num == 1 [
      #body
    ] else [
      #body
    ]
  ]
}

#set page(
  header: context {
    let page-num = counter(page).get().first()
    if page-num > 1 [
      #align(center)[
        #grid(
          columns: (1fr, 1fr),
          gutter: 1em,
          [#text(size: 8pt)[#conference-long]],
          [#align(right)[#text(size: 8pt)[#running-authors]]],
        )
      ]
    ]
  },
  // footer: context {
  //   let page-num = counter(page).get().first()
  //   if page-num == 1 [
  //     #grid(
  //       columns: (1fr, 1fr, 1fr, 0.5fr),
  //       gutter: 1em,
  //       [#text(size: 8pt)[#conference-short]],
  //       [#align(center)[#text(size: 8pt)[# title]]],
  //       [#align(right)[#text(size: 8pt)[#isbn]]],
  //       [#align(right)[#text(size: 8pt)[#page-num]]],
  //     )
  //   ] else [
  //     #align(center)[#text(size: 8pt)[#page-num]]
  //   ]
  // },
)

#title-block()
#v(0.85em)

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 0.24in,
  ..authors.map(author => author-block(author)),
)

#v(1.15em)

#columns(2, gutter: 0.33in)[
#first-page-body[

#text(weight: "bold")[ABSTRACT]

This paper synthesizes an investigation into behavioral modeling of RF power amplifiers for digital pre-distortion. The work starts from the classic MP model and proposes a variation where the maximum polynomial order depends on the memory delay. The central hypothesis is that the largest portion of nonlinearity is concentrated in the current sample, while older delays can be represented with lower orders. The methodology was evaluated in software through least squares identification and validation with the NMSE metric, in addition to a fixed-point VHDL implementation for hardware feasibility analysis. The results indicate that the decreasing distribution of orders along memory preserves model accuracy, improves the performance-to-coefficient ratio, and reduces structural complexity, with gains also observed after logic synthesis. Together, the evidence shows that the selective adjustment of orders along memory constitutes a consistent strategy to approximate modeling performance and implementation efficiency.

#v(0.7em)

#text(weight: "bold")[KEYWORDS]

Nonlinear modeling, power amplifier, VHDL implementation

#v(0.7em)

// #acm-reference-format

= Introduction

PA operating near saturation exhibit pronounced nonlinearity and memory effects, which compromise the spectral quality of broadband signals. In modern wireless communication systems, this behavior becomes particularly critical, as spectral spreading and envelope distortion degrade transmission efficiency and hinder coexistence with adjacent channels #cite(<Yu2024>). In this scenario, digital pre-distortion relies on mathematical models capable of representing amplifier behavior with good accuracy and computational cost compatible with practical implementation.

Reference #cite(<Kim2001>) early showed that memory modeling is essential for pre-distortion of broadband signals. Later, #cite(<Pedro2005>) consolidated this line by discussing behavioral approaches for power-amplifier modeling from a comparative perspective. In a broader design perspective, #cite(<Cripps2006>) and #cite(<Kenington2000>) discuss how trade-offs between linearity, efficiency, and complexity condition the choice of mathematical model and implementation architecture.

Within this context, polynomial models derived from the memory-polynomial family have become particularly attractive for combining good representation capacity with relatively simple estimation #cite(<Morgan2006>). In practical applications, #cite(<Kwan2012>) shows the importance of viable models for FPGA implementation, while #cite(<Morgan2006>), #cite(<Talemwa2025>), and #cite(<Li2021>) explore polynomial and Volterra-inspired extensions to improve the behavioral description of power amplifiers.

Despite these advances, the traditional MP formulation adopts the same polynomial order for all memory branches, which may impose unnecessary operations when the contribution of older delays is already small. This work therefore investigates an alternative formulation in which the maximum order is defined individually for each delay, concentrating greater complexity only on the most relevant terms.

In addition to algorithmic interest, this issue is particularly important when the model needs to be transported to digital platforms with constraints on area, operating frequency, and power consumption. In such scenarios, the number of coefficients, the depth of the multiplication chain, and the volume of registers cease to be secondary details and directly influence the viability of the solution. Thus, a slightly simpler model may be preferable to another marginally more accurate when the loss in NMSE is small and the gain in implementation cost is expressive.

With this background, the objective of this paper is to gather the main theoretical, experimental, and hardware results associated with the delay-dependent order hypothesis. The central contribution is not restricted to the mathematical formulation of the model, but also includes a joint reading between identification performance, parametric sensitivity, and architectural impact. In this way, the analysis seeks to answer not only whether the model reduces error, but whether this reduction remains technically justifiable when observed from the digital implementation viewpoint.

= Proposed MP Model with Delay-dependent Polynomial Orders

The proposed model is described by

$ y(n) = sum_(m=0)^(M) sum_(p=1)^(P_m) h_(p,m) x(n - m) |x(n - m)|^(p - 1) $

where $P_m$ represents the maximum order associated with delay $m$. The classic MP is recovered as a particular case when all orders are equal. The main advantage of this formulation is to preserve linearity in the parameters, allowing coefficient estimation by least squares with a potentially smaller regression matrix than the conventional model.

The central premise is that the most intense nonlinearity is in the current sample, so older delays can use lower orders. This hypothesis aligns with reported modeling results and complexity reduction strategies. Under this, the search for efficient configurations considers structural cost, using the Pareto frontier to identify better performance-complexity trade-offs.

This premise fits the physical interpretation of PAs with short memory, where thermal and electrical mechanisms leave a temporal signature that becomes less intense with delay. Employing identical orders in all delays overparameterizes the problem.

From identification, specific orders per delay reduce uninformative terms, containing collinearity and clarifying coefficient interpretation. Instead of expanding indiscriminately, the proposal organizes complexity by expected relevance.

= Methodology

To assess the benefits offered by the proposed model, this paper uses data collected from two PAs. Experimental datasets from an LDMOS PA and from a one-carrier GaN HEMT PA were considered. The GaN dataset corresponds to a class-AB amplifier excited by a 900 MHz carrier modulated by a 3GPP WCDMA signal with approximately 3.84 MHz bandwidth and sampled at 61.44 MSps. The LDMOS dataset is organized into extraction and validation partitions with 4,500 complex samples each. In both cases, the available data comprise complex input and output samples for model identification and validation.

For experimental evaluation, models with memory depth $M = 2$ and order combinations $(P_0, P_1, P_2)$ ranging from 1 to 5 were considered. This choice produces a sufficiently broad search space to evidence sensitivity trends, without compromising comparative analysis between configurations. The adopted strategy consisted of estimating each configuration independently, recording its accuracy by means of the NMSE #cite(<Muha1999>), and then relating this performance to the number of coefficients employed by the model. In this way, it was possible to observe not only which configuration offers the lowest error, but which ones remain competitive when incorporating structural cost into the analysis.

Performance was measured through NMSE #cite(<Muha1999>),

$ "NMSE" = 10 log_(10) lr(( frac(sum |e(n)|^2, sum |y_"real"(n)|^2) )) $

comparing the measured amplifier output with the model-estimated output. Since NMSE normalizes the error energy by the reference signal energy, it allows direct comparison of models with different numbers of terms and different parameterization strategies. More negative values indicate better adherence between the model and the observed amplifier behavior.

In addition to software evaluation, two architectures were described in VHDL: the original MP version and the truncated version with delay-dependent orders. In hardware implementation, the focus was to verify how selective order reduction impacts the main synthesis metrics. This step is important because the practical usefulness of a behavioral model does not depend only on its fitting quality, but also on the possibility of being implemented with predictable cost on reconfigurable or dedicated platforms.

In terms of workflow, the methodology can be summarized in four steps: definition of candidate order sets; coefficient estimation by least squares; performance evaluation via NMSE; and finally, comparison between algorithmic cost and implementation cost. This chaining allows the analysis to go beyond the purely numerical level and reach a design perspective, more appropriate for digital pre-distortion applications in real systems.

= Results

The experiments showed that model complexity should be concentrated in the current instant. In the analyzed LDMOS set, a complete model with $(P_0, P_1, P_2) = (5,5,5)$ reached NMSE of -38.47 dB, but the coefficient energy analysis indicated monotonic decay along delays. NMSE sensitivity confirmed this behavior, as illustrated in @fig:sensibilidade: when varying each branch individually between 1 and 5, the gain associated with $P_0$ was 6.66 dB, while $P_1$ and $P_2$ produced gains of 3.43 dB and 1.49 dB, respectively.

#figure(
  placement: bottom,
  image("./ev2_sensibilidade_nmse.png", width: 90%),
  caption: [NMSE sensitivity to orders $P_0$, $P_1$, and $P_2$ for the modeled LDMOS PA, highlighting the predominance of the current instant.],
) <fig:sensibilidade>

This result is relevant because it shows that the best absolute performance does not necessarily coincide with the most efficient configuration. Although the complete configuration is still the reference for highest accuracy, the difference between it and well-chosen truncated models becomes relatively small when compared to the complexity reduction obtained. In other words, a significant portion of the modeling capacity is already captured by a reduced set of terms, as long as the order distribution respects the relative importance of each delay.

In addition to NMSE in the time domain, spectral analysis reinforces this interpretation. When observing the power spectral density of the signals involved, it is noted that configurations with better performance reduce modeling error also in regions adjacent to the main band, which is particularly relevant for digital pre-distortion applications, as shown in @fig:psd. The spectral evidence shows that increasing order in more important branches shifts the error to lower levels, while increments in less relevant delays produce comparatively modest gains.

#figure(
  placement: bottom,
  image("./ev_bonus_psd_completo.png", width: 90%),
  caption: [Spectral comparison between the input signal, the measured output, and the modeling errors for different order configurations of the modeled LDMOS PA.],
) <fig:psd>

#figure(
  kind: table,
  placement: bottom,

  caption: [Modeling performance for different order configurations and numbers of coefficients.],
  table(
    columns: (1.25fr, 0.8fr, 1fr, 1fr),
    align: center,
    inset: 4pt,
    table.header([*Configuration*], [*Coefficients*], [*NMSE GaN*], [*NMSE LDMOS*]),
    [$(1,1,1)$], [3], [$-21,66$ dB], [$-28,71$ dB],
    [$(3,2,1)$], [6], [$-25,53$ dB], [$-34,75$ dB],
    [$(4,3,2)$], [9], [$-25,64$ dB], [$-36,31$ dB],
    [$(5,3,2)$], [10], [$-25,49$ dB], [$-37,00$ dB],
    [$(5,5,5)$], [15], [$-26,10$ dB], [$-37,51$ dB],
  ),
) <tab:desempenho>

@tab:desempenho shows that a large part of the gain can be obtained with intermediate models, without the need to keep the maximum order at all delays. Configurations with decreasing orders preserve the observed trend and approach the performance of the complete model with a smaller number of coefficients.

In the exhaustive evaluation of 125 combinations, models such as $(3,2,1)$, $(4,3,2)$, and $(5,3,2)$ offered the best compromise between number of coefficients and performance, as shown in @tab:desempenho. In both GaN and LDMOS, the parameter $P_0$ was primarily responsible for the NMSE improvement, while older delays quickly saturated at lower orders.

Another important aspect of the analysis is that the ranking of the best solutions does not depend only on the device under consideration, since the global trend remains consistent across the evaluated datasets. This strengthens the interpretation that the delay-dependent order hypothesis is not a one-off adjustment to a specific experiment, but rather a structural regularity of the modeling problem. Even when the absolute NMSE values vary across technologies, the relevance hierarchy among the memory branches remains similar.

From a design perspective, this stability is particularly useful. If the optimal configuration changed abruptly across different datasets, the proposal would have limited value as a model synthesis guideline. However, the recurrence of solutions with decreasing orders indicates a robust practical directive: starting with a higher order at zero delay and progressively reducing complexity in subsequent delays tends to produce competitive solutions already in the first design iterations.

= Hardware Evaluation and Pareto Frontier

The VHDL synthesis evaluation compared the classic MP architecture with the truncated version with delay-dependent orders. The cell and register counts reported in this section were obtained from fixed-point VHDL descriptions validated with GHDL and synthesized with Yosys. At this stage, the analysis corresponds to behavioral logic synthesis only, without place-and-route, and no specific FPGA board was targeted. The $(5,3,2)$ configuration reduces by about 40% the main synthesis resources, maintaining NMSE close to the complete model, as shown in @tab:desempenho. This result reinforces that algorithmic simplification also translates into effective cost reduction in digital implementation.

From an architectural viewpoint, this reduction should not be interpreted only as savings in stored coefficients. The order reduction in less relevant branches implies fewer partial products, lower adder depth, and lower pressure on intermediate registers. In practice, this contributes to simplifying the data path and may facilitate timing closure in more aggressive frequency implementations.

@tab:hardware shows the comparison of hardware resources between the complete MP architecture and truncated versions.

#figure(
  kind: table,
  caption: [Comparison of hardware resources between the complete MP architecture and truncated versions.],
  table(
    columns: (1.75fr, 0.7fr, 1fr, 0.9fr, 1fr),
    align: center,
    inset: 4pt,
    table.header([*Architecture*], [*Coef.*], [*Reduction*], [*Cells*], [*Registers*]),
    [MP complete $(5,5,5)$], [15], [--], [100%], [100%],
    [MP truncated $(5,3,2)$], [10], [40%], [60%], [60%],
    [MP truncated $(4,3,2)$], [9], [40%], [58%], [58%],
  ),
) <tab:hardware>

The Pareto frontier between hardware complexity and NMSE performance reveals that $(4,3,2)$ and $(5,3,2)$ dominate the solution space, as seen in @fig:pareto. Configurations with higher orders in less relevant delays require more resources without proportional gains. Thus, selective polynomial order reduction preserves the useful model performance while favoring more compact architectures.

The Pareto frontier represents the set of non-dominated solutions in the multi-objective optimization space, where no point can be improved in one criterion without worsening in the other. In this work's context, it highlights that configurations with orders decreasing along memory delays offer the best balance between modeling accuracy and structural efficiency, avoiding unnecessary overparameterizations.

#figure(
  placement: top,
  image("fronteiradepareto.png", width: 90%),
  caption: [Pareto frontier illustrating the trade-off between model complexity (number of coefficients) and modeling performance (NMSE) for different polynomial order configurations.],
) <fig:pareto>

In the VHDL implementation, the truncated version maintained functional equivalence with the Python reference model and presented reductions close to 40% in main synthesis metrics, including wires, wire bits, cells, and registers. These results show that reducing polynomial order in older delays does not represent only algorithmic savings, but also concrete digital architecture simplification.

This result has direct practical implications for embedded systems and transmitters with resource constraints. In many cases, a small NMSE loss is acceptable as long as the model continues to satisfy the system's linearization requirements and allows a more compact and energy-efficient implementation. The Pareto frontier helps precisely formalize this decision, replacing intuitive choices with a quantitative comparison criterion between performance and cost.

= Discussion

The results allow interpreting the proposal from modeling and implementation perspectives. The delay-dependent order model reorganizes complexity coherently with observed relevance. By reducing low-contribution terms, it transforms conceptual gain into measurable hardware savings.

The work does not claim all amplifiers should use the same profile. The results suggest a guideline: polynomial order need not be uniform, and assuming uniformity may mask efficient solutions. As memory depth grows, this becomes more valuable to avoid indiscriminate expansion.

The joint analysis reinforces model choice as an engineering compromise, interpreting fitting quality alongside constraints. The proposed model internalizes this in the behavioral structure design.

= Conclusion

The study confirms that the MP model with delay-dependent polynomial order is an efficient alternative for behavioral modeling of power amplifiers. The proposal preserves the accuracy of the classic MP, reduces the number of necessary terms, and favors more compact digital implementations. Sensitivity results showed that the greatest contribution to NMSE improvement is concentrated in the branch associated with the current instant, while older delays can be represented with lower orders without proportional performance loss.

From the implementation viewpoint, the VHDL analysis demonstrated that this complexity reorganization is not only a mathematical simplification, but a concrete architectural advantage. Configurations such as $(4,3,2)$ and $(5,3,2)$ stood out for combining good modeling performance with expressive synthesis resource reduction, making them particularly attractive for practical digital pre-distortion applications. As a consequence, the work offers a promising basis for applications with area and consumption constraints, maintaining consistency both in software evaluation and hardware validation.

= References

#set text(size: 7.5pt)
#set par(leading: 0.42em)
#bibliography("Referencias.bib", title: none)
]
]
