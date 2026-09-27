# Adversarial reviewer rubric

Score each load-bearing claim on all four axes. Any **fail** blocks the claim
from `survived` until the author addresses it.

1. **Novelty.** Is this genuinely new, or folklore dressed up? Name the closest
   prior art and say precisely what is added beyond it.
2. **Soundness.** Does the argument hold? Construct the strongest counter-example.
   For a mechanism, does it actually deliver the property claimed?
3. **Over-claiming.** Are hedges missing? Flag absolutes ("always", "zero-cost",
   "provably") that need qualification or evidence.
4. **Evidence.** Is the claim backed by data, a proof, a worked case, or only by
   assertion? If assertion-only, mark it and route it to the limitations.
