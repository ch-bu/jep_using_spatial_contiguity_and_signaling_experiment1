library(tidyverse)
library(jmv)
library(emmeans)
library(broom)


data_global <- read_csv("data/cleaned/data_cleaned_wide.csv") %>% 
  mutate(
    treatment = treatment %>% as_factor %>% 
      fct_relevel("cmap-integrated","cmap", 
                  "control-group", "integrated")
  )


# Main hypothesis
model <- aov(global_cohesion_revision ~ global_cohesion_draft + 
               treatment, data = data_global)

model %>% 
  emmeans("treatment") %>% 
  contrast(list(main_hypothesis   = c(3, 1, -2, -2))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Prediction global cohesion draft and revision
jmv::ancova(
  formula = global_cohesion_revision ~ treatment + 
    global_cohesion_draft,
  data = data_global,
  effectSize = "partEta")


# Pairwise comparison cmap-enhanced vs. no feedback
model_cenhanced_vs_no <- data_global %>% 
  filter(treatment %in% c("cmap-integrated", "control-group")) %>% 
  droplevels() %>% 
  aov(global_cohesion_revision ~ global_cohesion_draft + 
                            treatment, data = .)

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


# Pairwise comparison cmap-enhanced vs. spatially contiguous
model_cenhanced_vs_integrated <- data_global %>% 
  filter(treatment %in% c("cmap-integrated", "integrated")) %>% 
  droplevels() %>% 
  aov(global_cohesion_revision ~ global_cohesion_draft + 
        treatment, data = .)

model_cenhanced_vs_integrated %>% 
  emmeans("treatment") %>% 
  contrast(list(cmap_enhanced_vs_integrated  = c(1, -1))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Pairwise comparison cmap vs. no feedback
model_cmap_vs_no <- data_global %>% 
  filter(treatment %in% c("cmap", "control-group")) %>% 
  droplevels() %>% 
  aov(global_cohesion_revision ~ global_cohesion_draft + 
        treatment, data = .)

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


# Pairwise comparison spatially contiguous vs. no feedback
model_spat_vs_no <- data_global %>% 
  filter(treatment %in% c("integrated", "control-group")) %>% 
  droplevels() %>% 
  aov(global_cohesion_revision ~ global_cohesion_draft + 
        treatment, data = .)

model_spat_vs_no %>% 
  emmeans("treatment") %>% 
  contrast(list(spat_vs_no  = c(1, -1))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )

# Correlation analysis
cor.test(data_global$prior_knowledge_osmosis, data_global$global_cohesion_draft)
cor.test(data_global$prior_knowledge_osmosis, data_global$global_cohesion_revision)


# Transfer explanation
model_transfer <- aov(global_cohesion_transfer ~ treatment, data = data_global)

model_transfer %>% 
  emmeans("treatment") %>% 
  contrast(list(main_hypothesis   = c(3, 1, -2, -2))) %>% 
  tidy %>%
  mutate(
    F = statistic**2,
    p_corrected = p.value / 2,
    r = sqrt(statistic^2 / (statistic^2 + df)),
    g = (2 * statistic) / sqrt(100),
    d = g * sqrt(100 / 95)
  )


# Transfer pairwise comparisons
jmv::ANOVA(
  formula = global_cohesion_transfer ~ treatment,
  data = data_global,
  effectSize = "partEta",
  postHoc = ~ treatment)
