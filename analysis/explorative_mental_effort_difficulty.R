library(tidyverse)
library(jmv)

data_wide <- read_csv("data/cleaned/data_cleaned_wide.csv")


# Perceived mental effort
jmv::ANOVA(
  formula = effort_revision ~ treatment,
  data = data_wide,
  effectSize = "partEta")


# Perceived difficulty
jmv::ANOVA(
  formula = difficulty_revision ~ treatment,
  data = data_wide,
  effectSize = "partEta")
