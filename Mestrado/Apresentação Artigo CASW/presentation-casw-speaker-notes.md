# Speaker Notes - 15-minute Presentation

## Slide 1 - Title (0:30)

Good morning. This presentation discusses behavioral modeling of RF power amplifiers using memory polynomials with delay-dependent polynomial orders. The central idea is simple: different memory delays do not contribute equally to the amplifier response, so they should not necessarily receive the same model complexity. I will show how this idea affects modeling accuracy, spectral behavior, and digital hardware cost.

## Slide 2 - Why PA Modeling Matters (1:15)

The power amplifier is a critical component of a wireless transmitter. To improve energy efficiency, we would like to operate it close to saturation. Unfortunately, this is also the region where its nonlinear behavior becomes strongest. For broadband modulated signals, electrical and thermal memory effects make the response depend not only on the current sample but also on previous samples.

These effects generate in-band distortion and spectral regrowth, potentially interfering with adjacent channels. Digital pre-distortion is the standard way to compensate for this behavior, but it requires an accurate behavioral model of the amplifier. The practical challenge is therefore to achieve enough accuracy without making the real-time digital implementation unnecessarily expensive.

## Slide 3 - The Limitation of the Classic MP (1:15)

The classic memory polynomial, or MP, is widely used because it offers a good balance between representation capability and simple coefficient estimation. It sums nonlinear basis functions over several memory delays, and it remains linear in the unknown coefficients, so least squares can be used for identification.

However, the classic formulation assigns the same maximum polynomial order to every delay. That assumes that the current sample and all previous samples deserve the same nonlinear detail. In many amplifiers, this is not true: the strongest nonlinear contribution is concentrated at the current instant, while older delays have a weaker effect. A uniform order can therefore add coefficients, multiplications, and registers that contribute very little to accuracy.

## Slide 4 - Delay-dependent Polynomial Orders (1:30)

The proposed model replaces the single maximum order, P, with an order P sub m for each memory delay. This is the only structural change. If all these orders are equal, we recover the classic memory polynomial.

Importantly, the new model is still linear in the coefficients. We do not lose the convenient least-squares identification process. What changes is the size and composition of the regression matrix.

The working hypothesis is a decreasing profile: a high order for the current sample, a medium order for the first delay, and a lower order for the second delay. In shorthand, P zero is greater than or equal to P one, which is greater than or equal to P two. This allocates complexity according to the expected relevance of each branch rather than expanding every branch uniformly.

## Slide 5 - Experimental Method (1:30)

The evaluation used data from two different power amplifiers: an LDMOS device and a class-AB GaN HEMT device. The GaN amplifier was excited by a 900 megahertz carrier modulated with a 3GPP WCDMA signal of approximately 3.84 megahertz bandwidth and sampled at 61.44 megasamples per second. The LDMOS dataset contained separate extraction and validation partitions of 4,500 complex samples each.

We used a memory depth of two, meaning the current sample and two delayed samples. Each polynomial order varied independently from one to five, producing 125 configurations. Every configuration was estimated by least squares and evaluated on validation data. The primary metric was normalized mean squared error, or NMSE, where a more negative value indicates a better fit. Finally, selected structures were implemented in fixed-point VHDL, validated with GHDL, and synthesized with Yosys.

## Slide 6 - Sensitivity Is Concentrated at the Current Sample (1:30)

This sensitivity experiment isolates the effect of increasing the order of each branch. The result clearly supports the central hypothesis. Increasing P zero, the order of the current-sample branch, improves NMSE by 6.66 decibels. The corresponding gain is only 3.43 decibels for the first delay and 1.49 decibels for the second delay.

So, one additional unit of structural complexity does not have the same value everywhere. Complexity assigned to the current sample produces a much larger improvement than complexity assigned to an older sample. This hierarchy also agrees with the observed decay in coefficient energy across delays. The practical implication is that reducing older-delay orders should preserve most of the useful modeling capacity.

## Slide 7 - Accuracy with Fewer Coefficients (1:30)

The table compares representative order profiles on both datasets. The full five-five-five model uses 15 coefficients and gives the best absolute NMSE. However, intermediate decreasing-order models are very close with substantially fewer terms.

For the GaN amplifier, the four-three-two model uses nine coefficients, which is 40 percent fewer than the full model, while its NMSE is only 0.46 decibels worse. For the LDMOS amplifier, the five-three-two model uses ten coefficients, 33 percent fewer, and remains within 0.51 decibels of the full model.

The exact best profile can vary by device, but the broader result is stable: decreasing orders capture most of the available accuracy. Therefore, the best absolute NMSE is not necessarily the best engineering solution.

## Slide 8 - The Improvement Is Also Spectral (1:15)

NMSE is a time-domain metric, but for power-amplifier applications we also need to inspect the spectrum. This plot compares the measured signals and the modeling-error spectra for different configurations.

The spectral evidence follows the same trend. Models with appropriately increased order in the important branches reduce error around the main band and in adjacent spectral regions. In contrast, increasing the orders of older and less relevant delays gives comparatively modest gains. This matters because adjacent-band error is directly connected to the spectral-quality objectives that motivate digital pre-distortion.

## Slide 9 - Hardware Cost Follows Structural Complexity (1:30)

The next question is whether the mathematical reduction becomes a real implementation advantage. Fixed-point VHDL descriptions were compared after functional validation and logic synthesis.

Taking the full five-five-five architecture as 100 percent, the five-three-two implementation uses approximately 60 percent of the cells and registers. The four-three-two version is slightly smaller again, at about 58 percent. The reduction is not limited to coefficient storage. Lower orders remove partial products, shorten the addition structure, and reduce the need for intermediate registers.

For the five-three-two model, this is approximately a 40 percent reduction in the main synthesis resources while the LDMOS NMSE remains within 0.51 decibels of the full model. These are synthesis-level results; no target FPGA or place-and-route analysis was performed, so board-specific timing and power remain future work.

## Slide 10 - Pareto Frontier: The Design Decision (1:15)

The Pareto frontier makes the design trade-off explicit. A point is Pareto-optimal when accuracy cannot be improved without increasing complexity, or complexity cannot be reduced without sacrificing accuracy.

The useful region includes models such as four-three-two and five-three-two. Configurations that maintain high orders in older memory branches consume more resources without a proportional NMSE improvement. This leads to a practical initial design rule: begin with a relatively high order at the current sample and progressively reduce the orders across memory. The final profile should still be validated for the specific device and operating condition.

## Slide 11 - Takeaways (1:00)

There are three main conclusions. First, nonlinear relevance decays across the analyzed memory delays, with the current sample producing the greatest NMSE improvement. Second, delay-dependent orders retain most of the classic memory-polynomial accuracy across both GaN and LDMOS datasets. Third, the reduced structure translates into concrete hardware savings, with reductions of about 40 percent in the main synthesis metrics for selected configurations.

The main message is that polynomial complexity should be allocated according to delay relevance, not uniformly. This provides a direct route toward compact behavioral models for real-time digital pre-distortion.

## Slide 12 - Questions (0:30)

Thank you for your attention. I will be happy to answer your questions.

---

**Total planned time: 15:00**
