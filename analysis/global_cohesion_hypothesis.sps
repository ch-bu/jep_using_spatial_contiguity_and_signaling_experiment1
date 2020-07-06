* Encoding: UTF-8.
*1 = cmap
 2 = cmap_integrated
 3 = integrated
 4 = no_feedback. 

* Main hypothesis: Global cohesion training explanation.
UNIANOVA global_cohesion_revision BY treatment WITH global_cohesion_draft
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment)=special (1 3 - 2 -2 )
  /INTERCEPT=INCLUDE
  /PRINT=ETASQ
  /CRITERIA=ALPHA(0.05)
  /DESIGN=global_cohesion_draft treatment.


* Prediction global cohesion draft and revision.
UNIANOVA global_cohesion_revision BY treatment WITH global_cohesion_draft
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /CRITERIA=ALPHA(0.05)
  /DESIGN=global_cohesion_draft treatment.


* Pairwise comparison cmap-enhanced vs. no feedback.
TEMPORARY.
SELECT IF (treatment_numeric = 2 or treatment_numeric = 4).
UNIANOVA global_cohesion_revision  BY  treatment_numeric WITH global_cohesion_draft 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment_numeric)=special ( 1 -1 )
  /PLOT=PROFILE(treatment_numeric)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /DESIGN= treatment_numeric global_cohesion_draft.


* Pairwise comparison cmap-enhanced vs. spatially contiguous.
TEMPORARY.
SELECT IF (treatment_numeric = 2 or treatment_numeric = 3).
UNIANOVA global_cohesion_revision  BY  treatment_numeric WITH global_cohesion_draft 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment_numeric)=special ( 1 -1 )
  /PLOT=PROFILE(treatment_numeric)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /DESIGN= treatment_numeric global_cohesion_draft.


* Pairwise comparison cmap vs. no feedback.
TEMPORARY.
SELECT IF (treatment_numeric = 1 or treatment_numeric = 4).
UNIANOVA global_cohesion_revision  BY  treatment_numeric WITH global_cohesion_draft 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment_numeric)=special ( 1 -1 )
  /PLOT=PROFILE(treatment_numeric)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /DESIGN= treatment_numeric global_cohesion_draft.


* Pairwise comparison spatially contiguous vs. no feedback.
TEMPORARY.
SELECT IF (treatment_numeric = 3 or treatment_numeric = 4).
UNIANOVA global_cohesion_revision  BY  treatment_numeric WITH global_cohesion_draft 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment_numeric)=special ( 1 -1 )
  /PLOT=PROFILE(treatment_numeric)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /DESIGN= treatment_numeric global_cohesion_draft.


* Correlation analysis.
CORRELATIONS
  /VARIABLES=prior_knowledge_osmosis global_cohesion_draft global_cohesion_revision
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.


* Transfer explanation.
UNIANOVA global_cohesion_transfer BY treatment 
  /METHOD=SSTYPE(3)
  /CONTRAST (treatment)=special (1 3 - 2 -2 )
  /INTERCEPT=INCLUDE
  /PRINT=ETASQ
  /CRITERIA=ALPHA(0.05)
  /DESIGN= treatment.


* Transfer pairwise comparisons.
UNIANOVA global_cohesion_transfer BY treatment
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=treatment(TUKEY)
  /CRITERIA=ALPHA(0.05)
  /DESIGN=treatment.



