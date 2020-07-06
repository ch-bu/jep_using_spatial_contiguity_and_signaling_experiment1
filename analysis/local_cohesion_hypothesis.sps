* Encoding: UTF-8.
* Encoding: .
*1 = cmap-integrated
 2 = cmap
 3 = integrated
 4 = no_feedback. 

* Feedbackgruppe in numerischen Werte überführen.
DATASET ACTIVATE DataSet1.
RECODE treatment ('cmap'=1) ('cmap-integrated'=2) ('integrated'=3) ('control-group'=4) INTO 
    treatment_numeric.
EXECUTE.

* Main hypothesis: Local cohesion training explanation.
UNIANOVA num_non_coh_sentences_revision BY treatment WITH num_non_coh_sentences_draft
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment)=special (1 -1 3 -3 )
  /INTERCEPT=INCLUDE
  /PRINT=ETASQ
  /CRITERIA=ALPHA(0.05)
  /DESIGN=num_non_coh_sentences_draft treatment.


* Prediction local cohesion draft and revision.
UNIANOVA num_non_coh_sentences_revision BY treatment WITH num_non_coh_sentences_draft
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /CRITERIA=ALPHA(0.05)
  /DESIGN=num_non_coh_sentences_draft treatment.


* Pairwise comparison spatially contiguous vs. no feedback.
TEMPORARY.
SELECT IF (treatment_numeric = 3 or treatment_numeric = 4).
UNIANOVA num_non_coh_sentences_revision  BY  treatment_numeric WITH num_non_coh_sentences_draft 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment_numeric)=special ( 1 -1 )
  /PLOT=PROFILE(treatment_numeric)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /DESIGN= treatment_numeric num_non_coh_sentences_draft.


* Pairwise comparison cmap-enhanced vs. no feedback.
TEMPORARY.
SELECT IF (treatment_numeric = 2 or treatment_numeric = 4).
UNIANOVA num_non_coh_sentences_revision  BY  treatment_numeric WITH num_non_coh_sentences_draft 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment_numeric)=special ( 1 -1 )
  /PLOT=PROFILE(treatment_numeric)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /DESIGN= treatment_numeric num_non_coh_sentences_draft.


* Pairwise comparison cmap vs. no feedback.
TEMPORARY.
SELECT IF (treatment_numeric = 1 or treatment_numeric = 4).
UNIANOVA num_non_coh_sentences_revision  BY  treatment_numeric WITH num_non_coh_sentences_draft 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment_numeric)=special ( 1 -1 )
  /PLOT=PROFILE(treatment_numeric)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /DESIGN= treatment_numeric num_non_coh_sentences_draft.


* Transfer explanation.
UNIANOVA num_non_coh_sentences_transfer BY treatment 
  /METHOD=SSTYPE(3)
 /CONTRAST (treatment)=special (1 -1 3 -3 )
  /INTERCEPT=INCLUDE
  /PRINT=ETASQ
  /CRITERIA=ALPHA(0.05)
  /DESIGN= treatment.


* Transfer pairwise comparisons.
UNIANOVA num_non_coh_sentences_transfer BY treatment
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=treatment(TUKEY)
  /CRITERIA=ALPHA(0.05)
  /DESIGN=treatment.



