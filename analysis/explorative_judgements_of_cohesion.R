library(tidyverse)
library(jmv)

data_wide <- read_csv("data/cleaned/data_cleaned_wide.csv")

# Local cohesion - Training explanation
jmv::anovaRM(
  data = data_wide,
  rm = list(
    list(
      label="text",
      levels=c("osmosis", "natural selection"))),
  rmCells = list(
    list(
      measure="bias_local_osmosis_draft",
      cell="osmosis"),
    list(
      measure="bias_local_osmosis_revision",
      cell="natural selection")),
  bs = treatment,
  effectSize = "partEta",
  rmTerms = ~ text,
  bsTerms = ~ treatment,
  emMeans = ~ text:treatment)


# Local cohesion - Transfer explanation
jmv::ANOVA(
  formula = bias_local_natural_selection_transfer ~ treatment,
  data = data_wide,
  effectSize = "partEta")


# Global cohesion - Training explanation
jmv::anovaRM(
  data = data_wide,
  rm = list(
    list(
      label="text",
      levels=c("osmosis", "natural selection"))),
  rmCells = list(
    list(
      measure="bias_global_osmosis_draft",
      cell="osmosis"),
    list(
      measure="bias_global_osmosis_revision",
      cell="natural selection")),
  bs = treatment,
  effectSize = "partEta",
  rmTerms = ~ text,
  bsTerms = ~ treatment,
  emMeans = ~ text:treatment)


# Global cohesion - Transfer explanation
jmv::ANOVA(
  formula = bias_global_natural_selection_transfer ~ treatment,
  data = data_wide,
  effectSize = "partEta")
