* Encoding: UTF-8.


DATASET ACTIVATE DataSet1.

* Local cohesion training explanation.
GLM bias_local_osmosis_draft bias_local_osmosis_revision BY treatment
  /WSFACTOR=Text 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /PLOT=PROFILE(Text*treatment) TYPE=LINE ERRORBAR=NO MEANREFERENCE=NO YAXIS=AUTO
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Text
  /DESIGN=treatment.

* Local cohesion transfer explanation.
UNIANOVA bias_local_natural_selection_transfer BY treatment
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /INTERCEPT=INCLUDE
  /CRITERIA=ALPHA(0.05)
  /DESIGN=treatment.

* Global cohesion training explanation.
GLM bias_global_osmosis_draft bias_global_osmosis_revision BY treatment
  /WSFACTOR=Text 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /PLOT=PROFILE(Text*treatment) TYPE=LINE ERRORBAR=NO MEANREFERENCE=NO YAXIS=AUTO
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Text
  /DESIGN=treatment.

* Global cohesion - Transfer explanation.
UNIANOVA bias_global_natural_selection_transfer BY treatment
  /METHOD=SSTYPE(3)
  /PRINT=ETASQ
  /INTERCEPT=INCLUDE
  /CRITERIA=ALPHA(0.05)
  /DESIGN=treatment.
