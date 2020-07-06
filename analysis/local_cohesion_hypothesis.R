library(tidyverse)
library(jmv)
library(emmeans)
library(broom)


data_local <- read_csv("data/cleaned/data_cleaned_wide.csv") %>% 
  mutate(
    treatment = treatment %>% as_factor %>% 
      fct_relevel("integrated", "cmap-integrated",
                  "cmap", "control-group")
  )


# Main hypothesis
model <- aov(num_non_coh_sentences_revision ~ num_non_coh_sentences_draft + 
      treatment, data = data_local)

model %>% 
  emmeans("treatment") %>% 
  contrast(list(main_hypothesis   = c(3, 1, -1, -3))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Prediction local cohesion draft and revision
jmv::ancova(
  formula = num_non_coh_sentences_revision ~ treatment + 
            num_non_coh_sentences_draft,
  data = data_local,
  effectSize = "partEta")


# Pairwise comparison spatially contiguous vs. no feedback
model_spat_vs_no <- aov(num_non_coh_sentences_revision ~ num_non_coh_sentences_draft + 
               treatment, data = data_local %>% 
               filter(treatment %in% c("integrated", "control-group")) %>% droplevels())

model_spat_vs_no %>% 
  emmeans("treatment") %>% 
  contrast(list(spati_vs_no_feed  = c(1, -1))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Pairwise comparison cmap-enhanced vs. no feedback
model_cenhanced_vs_no <- aov(num_non_coh_sentences_revision ~ num_non_coh_sentences_draft + 
                          treatment, data = data_local %>% 
                          filter(treatment %in% c("cmap-integrated", "control-group")) %>% 
                          droplevels())

model_cenhanced_vs_no %>% 
  emmeans("treatment") %>% 
  contrast(list(cmap_enhanced_vs_no_feed  = c(1, -1))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Pairwise comparison cmap vs. no feedback
model_cmap_vs_no <- aov(num_non_coh_sentences_revision ~ num_non_coh_sentences_draft + 
                               treatment, data = data_local %>% 
                               filter(treatment %in% c("cmap", "control-group")) %>% 
                               droplevels())

model_cmap_vs_no %>% 
  emmeans("treatment") %>% 
  contrast(list(cmap_vs_no_feed  = c(1, -1))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Transfer explanation
model_transfer <- aov(num_non_coh_sentences_transfer ~ treatment, data = data_local)

model_transfer %>% 
  emmeans("treatment") %>% 
  contrast(list(main_hypothesis   = c(3, 1, -1, -3))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Transfer explanation with pairwise comparisons
jmv::ANOVA(
  formula = num_non_coh_sentences_transfer ~ treatment,
  data = data_local,
  effectSize = "partEta",
  postHoc = ~ treatment)
