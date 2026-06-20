#import "@preview/touying-simpl-swufe:0.2.0": *

#show: swufe-theme.with(
  aspect-ratio: "16-9",
  lang: "en",

  config-info(
    title: [Power Amplifier Modeling Using Memory Polynomials],
    subtitle: [Delay-dependent polynomial orders for accurate and compact implementations],
    short-title: [Delay-dependent Memory Polynomials],
    authors: [Leonardo A. Santos, Loane M. Z. Sequinel, Sibilla B. L. França, and Eduardo G. Lima],
    author: [Santos et al.],
    date: [WCAS 2026],
    institution: [Universidade Federal do Parana],
    banner: image("ufpr.png"),
  ),

  config-colors(
    primary: rgb(1, 83, 139),
    primary-dark: rgb(0, 42, 70),
    secondary: rgb(255, 255, 255),
    neutral-lightest: rgb(255, 255, 255),
    neutral-darkest: rgb(0, 0, 0),
  ),
)

#let accent-box(body) = block(
  fill: rgb(238, 246, 251),
  stroke: (left: 4pt + rgb(1, 83, 139)),
  inset: 0.8em,
  radius: 0.25em,
  width: 100%,
  body,
)

#title-slide()

#slide(title: "Why PA Modeling Matters")[
  #set text(size: 0.88em)
  #grid(
    columns: (1.12fr, 0.88fr),
    gutter: 1.5em,
    [
      - RF power amplifiers (PAs) are most efficient near saturation
      - Near saturation, nonlinearities create in-band distortion and spectral regrowth
      - Broadband signals also expose electrical and thermal memory effects
      - Digital pre-distortion (DPD) needs an accurate behavioral model of the PA

      #v(0.8em)
      #accent-box[
        *Engineering challenge:* retain modeling accuracy while reducing the cost of a real-time digital implementation.
      ]
    ],
    [
      #align(center + horizon)[
        #block(fill: rgb(245, 245, 245), inset: 1.0em, radius: 0.5em)[
          #set text(size: 0.9em)
          #align(center)[
            *Efficiency* $arrow.r$ saturation \
            #v(0.7em)
            $arrow.b$ \
            #v(0.7em)
            *Nonlinearity + memory* \
            #v(0.7em)
            $arrow.b$ \
            #v(0.7em)
            *DPD model required*
          ]
        ]
      ]
    ],
  )
]

#slide(title: "The Limitation of the Classic MP")[
  #set text(size: 0.9em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5em,
    [
      *Classic Memory Polynomial*

      #block(fill: rgb(245, 245, 245), inset: 0.9em, radius: 0.4em)[
        $y(n) = sum_(m=0)^M sum_(p=1)^P h_(p,m) x(n-m) abs(x(n-m))^(p-1)$
      ]

      - Same maximum order $P$ at every delay
      - Linear in the coefficients
      - Accurate and easy to identify by least squares
    ],
    [
      *But memory branches are not equally relevant*

      #v(0.5em)
      - The current sample usually contains the strongest nonlinear contribution
      - Older samples often contribute less
      - A uniform order can add weak terms, operations, and registers

      #v(0.8em)
      #accent-box[*Research question:* can complexity follow the relevance of each delay?]
    ],
  )
]

#slide(title: "Delay-dependent Polynomial Orders")[
  #set text(size: 0.88em)
  #grid(
    columns: (1.05fr, 0.95fr),
    gutter: 1.4em,
    [
      #block(fill: rgb(245, 245, 245), inset: 1em, radius: 0.4em)[
        $y(n) = sum_(m=0)^M sum_(p=1)^(P_m) h_(p,m) x(n-m) abs(x(n-m))^(p-1)$
      ]

      - Each delay $m$ receives its own maximum order $P_m$
      - The classic MP is recovered when all $P_m$ are equal
      - The model remains linear in its coefficients
      - Coefficients are still estimated by least squares
    ],
    [
      #align(center)[*Expected order profile*]
      #v(0.7em)
      #table(
        columns: (1fr, 1fr, 1fr),
        align: center,
        inset: 10pt,
        stroke: rgb(210, 220, 228),
        table.header([Current], [Delay 1], [Delay 2]),
        [High order], [Medium], [Low order],
        [$P_0$], [$P_1$], [$P_2$],
      )
      #v(0.8em)
      #accent-box[
        Working hypothesis: $P_0 >= P_1 >= P_2$ captures most of the useful behavior with fewer terms.
      ]
    ],
  )
]

#slide(title: "Experimental Method")[
  #set text(size: 0.82em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,
    [
      *Datasets*
      - LDMOS PA: 4,500 complex samples for extraction and 4,500 for validation
      - Class-AB GaN HEMT PA
      - 900 MHz carrier, 3GPP WCDMA signal
      - 3.84 MHz bandwidth, sampled at 61.44 MS/s

      #v(0.6em)
      *Search space*
      - Memory depth: $M = 2$
      - $P_0, P_1, P_2 in {1, 2, 3, 4, 5}$
      - 125 independently estimated configurations
    ],
    [
      *Evaluation workflow*
      #enum(
        [Build the regression matrix],
        [Estimate coefficients by least squares],
        [Validate on independent samples],
        [Compare NMSE and coefficient count],
        [Validate fixed-point VHDL and synthesize with Yosys],
      )

      #v(0.6em)
      #block(fill: rgb(245, 245, 245), inset: 0.9em, radius: 0.4em)[
        $"NMSE" = 10 log_(10) (frac(sum abs(e(n))^2, sum abs(y_"measured"(n))^2))$

        #align(center)[More negative is better.]
      ]
    ],
  )
]

#slide(title: "Sensitivity Is Concentrated at the Current Sample")[
  #set text(size: 0.79em)
  #grid(
    columns: (1.4fr, 0.6fr),
    gutter: 1.1em,
    [
      #figure(
        image("ev2_sensibilidade_nmse.png", width: 100%),
        caption: [LDMOS NMSE sensitivity when each branch order varies from 1 to 5.],
      )
    ],
    [
      #v(0.4em)
      *NMSE gain*
      #v(0.5em)
      #table(
        columns: (1fr, 1fr),
        align: center,
        inset: 8pt,
        table.header([Branch], [Gain]),
        [$P_0$], [*6.66 dB*],
        [$P_1$], [3.43 dB],
        [$P_2$], [1.49 dB],
      )
      #v(0.8em)
      Complexity added to $P_0$ is substantially more valuable than complexity added to older delays.
    ],
  )
]

#slide(title: "Accuracy with Fewer Coefficients")[
  #set text(size: 0.84em)
  #table(
    columns: (1.2fr, 0.8fr, 1fr, 1fr),
    align: center,
    inset: 8pt,
    stroke: rgb(210, 220, 228),
    table.header([*Orders*], [*Coefficients*], [*GaN NMSE*], [*LDMOS NMSE*]),
    [$(1,1,1)$], [3], [-21.66 dB], [-28.71 dB],
    [$(3,2,1)$], [6], [-25.53 dB], [-34.75 dB],
    [$(4,3,2)$], [9], [*-25.64 dB*], [-36.31 dB],
    [$(5,3,2)$], [10], [-25.49 dB], [*-37.00 dB*],
    [$(5,5,5)$], [15], [-26.10 dB], [-37.51 dB],
  )

  #v(0.8em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,
    [#accent-box[$(4,3,2)$ uses *40% fewer coefficients* and remains within 0.46 dB of the full GaN model.]],
    [#accent-box[$(5,3,2)$ uses *33% fewer coefficients* and remains within 0.51 dB of the full LDMOS model.]],
  )
]

#slide(title: "The Improvement Is Also Spectral")[
  #set text(size: 0.76em)
  #grid(
    columns: (1.45fr, 0.55fr),
    gutter: 1.1em,
    [
      #figure(
        image("ev_bonus_psd_completo.png", width: 100%),
        caption: [Measured spectrum and modeling-error spectra for selected configurations.],
      )
    ],
    [
      - Better time-domain NMSE is reflected in lower spectral error
      - Higher order in the important branches lowers error near the main and adjacent bands
      - Increasing older-delay orders yields comparatively modest improvement

      #v(0.7em)
      #accent-box[This is the behavior needed for DPD-oriented modeling.]
    ],
  )
]

#slide(title: "Hardware Cost Follows Structural Complexity")[
  #set text(size: 0.84em)
  #grid(
    columns: (1.05fr, 0.95fr),
    gutter: 1.3em,
    [
      #table(
        columns: (1.4fr, 0.7fr, 0.8fr, 0.8fr),
        align: center,
        inset: 8pt,
        stroke: rgb(210, 220, 228),
        table.header([*Architecture*], [*Coef.*], [*Cells*], [*Registers*]),
        [$(5,5,5)$], [15], [100%], [100%],
        [$(5,3,2)$], [10], [60%], [60%],
        [$(4,3,2)$], [9], [58%], [58%],
      )
    ],
    [
      - Fixed-point VHDL matched the Python reference behavior
      - GHDL was used for validation and Yosys for logic synthesis
      - Truncation removes partial products and reduces adder depth and register pressure
      - No target FPGA or place-and-route was used at this stage
    ],
  )

  #v(0.7em)
  #accent-box[The $(5,3,2)$ model reduces the main synthesis resources by about *40%* while keeping LDMOS NMSE within *0.51 dB* of the full model.]
]

#slide(title: "Pareto Frontier: The Design Decision")[
  #set text(size: 0.8em)
  #grid(
    columns: (0.95fr, 1.05fr),
    gutter: 1.2em,
    [
      - A Pareto-optimal model cannot improve accuracy without increasing complexity
      - Configurations such as $(4,3,2)$ and $(5,3,2)$ occupy the useful trade-off region
      - High orders at weak memory branches consume resources without proportional NMSE gains

      #v(0.8em)
      #accent-box[
        *Design rule:* begin with a high current-sample order and progressively lower the orders across memory.
      ]
    ],
    [
      #figure(
        image("fronteiradepareto.png", height: 61%),
        caption: [Complexity-performance trade-off across the candidate models.],
      )
    ],
  )
]

#slide(title: "Takeaways")[
  #set text(size: 0.9em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.4em,
    [
      *What the evidence shows*
      - Nonlinear relevance decays across the analyzed memory delays
      - Delay-dependent orders preserve most of the classic MP accuracy
      - The trend is consistent across GaN and LDMOS datasets
    ],
    [
      *Why it matters*
      - Fewer coefficients and arithmetic operations
      - About 40% lower main synthesis-resource counts for selected models
      - A practical path toward compact real-time DPD implementations
    ],
  )

  #v(1em)
  #accent-box[
    *Main message:* polynomial complexity should be allocated according to delay relevance, not uniformly.
  ]
]
