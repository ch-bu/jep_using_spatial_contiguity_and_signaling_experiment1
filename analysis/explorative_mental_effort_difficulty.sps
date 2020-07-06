* Encoding: UTF-8.

* Perceived mental effort.
UNIANOVA effort_revision BY treatment
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=ETASQ
  /CRITERIA=ALPHA(0.05)
  /DESIGN=treatment.


* Perceived difficulty.
UNIANOVA difficulty_revision BY treatment
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT=ETASQ
  /CRITERIA=ALPHA(0.05)
  /DESIGN=treatment.

