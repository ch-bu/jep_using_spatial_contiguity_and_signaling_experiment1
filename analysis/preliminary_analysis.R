library(tidyverse)
library(jmv)

data_wide <- read_csv("data/cleaned/data_cleaned_wide.csv")

# Number of participants
nrow(data_wide)

# Mean and sd age
data_wide %>% 
  summarise(across(age, 
                   list(mean = mean, sd = sd)))
  
# Mean and sd number of semester
data_wide %>% 
  summarise(across(num_semester, 
                   list(mean = mean, sd = sd)))

# Participants per group
data_wide %>% 
  count(treatment)

# Difference in age
aov(age ~ treatment, data = data_wide) %>% summary

# Difference in number of semesters
aov(num_semester ~ treatment, data = data_wide) %>% summary

# Difference in gender
jmv::contTables(
  formula = ~ sex:treatment,
  data = data_wide)

# Mixed ANOVA prior knowledge and treatment
jmv::anovaRM(
  data = data_wide,
  rm = list(
    list(
      label="Prior knowledge",
      levels=c("osmosis", "natural selection"))),
  rmCells = list(
    list(
      measure="prior_knowledge_osmosis",
      cell="osmosis"),
    list(
      measure="prior_knowledge_natural_selection",
      cell="natural selection")),
  bs = treatment,
  effectSize = "partEta",
  rmTerms = ~ `Prior knowledge`,
  bsTerms = ~ treatment)


# Difference in reading skill - sentence verification
aov(elves_sf ~ treatment, data = data_wide) %>% summary

# Difference in reading skill - reading skill
aov(elves_tv ~ treatment, data = data_wide) %>% summary

# Difference in number of sentences in draft
aov(num_sentences_draft ~ treatment, data = data_wide) %>% summary

# Difference in local cohesion in draft
jmv::ANOVA(
  formula = num_non_coh_sentences_draft ~ treatment,
  data = data_wide,
  effectSize = "partEta")

# Difference in global cohesion in draft
jmv::ANOVA(
  formula = global_cohesion_draft ~ treatment,
  data = data_wide,
  effectSize = "partEta")
