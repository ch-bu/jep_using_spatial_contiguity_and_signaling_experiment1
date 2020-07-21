library(tidyverse)
library(cowplot)
library(hrbrthemes)

base_theme <- theme(
  plot.margin = unit(rep(1, 4), "cm"),
  axis.text = element_text(size = 9, angle = 0,
                           hjust = 0.5, color = "black"),
  axis.text.x = element_text(size = 9, margin = margin(t = 5)),
  axis.title.y = element_text(margin = margin(r = 10), hjust = 0.5, 
                              face = "bold",
                              size = 9, color = "black"),
  axis.text.y = element_text(size = 9, margin = margin(r = 5)),
  panel.grid.major.y = element_line(color = "#b1b1b2", size = 0.4),
  panel.grid.major.x = element_blank(),
  panel.grid.minor.y = element_blank(),
  panel.grid.minor.x = element_blank(),
  axis.line = element_line(color = "black", size = 0.3),
  axis.ticks.x = element_line(color = "black"),
  axis.ticks.y = element_line(color = "black")
) 

set_base_theme <- function() {
  theme_set(theme_ipsum_tw(base_size = 12) +
              base_theme)
}

set_base_theme()

cohesion_data <- tibble(
  feedback = c("spatially contiguous\nfeedback",
               "correspondence-enhanced\nconcept-map feedback",
               "conventional concept-\nmap feedback",
               "no feedback",
               "spatially contiguous\nfeedback",
               "correspondence-enhanced\nconcept-map feedback",
               "conventional concept-\nmap feedback",
               "no feedback"),
  treatment = c(rep("local", 4), rep("global", 4)),
  se = c(0.416, 0.424, 0.453, 0.418, 0.112, 0.119, 0.112, 0.111),
  empirical = c(4.76, 5.28, 5.50, 5.69, 2.43, 2.87, 2.53, 2.51),
  descriptive = c("(4.42)", "(5.08)", "(6.65)", "(5.12)",
                  "(2.60)", "(2.82)", "(2.33)", "(2.58)")
)

(local_cohesion_plot <- cohesion_data %>% 
    filter(treatment == "local") %>% 
    mutate(
      feedback = fct_relevel(feedback, "spatially contiguous\nfeedback",
                             "correspondence-enhanced\nconcept-map feedback",
                             "conventional concept-\nmap feedback",
                             "no feedback")
    ) %>% 
    ggplot(aes(feedback, empirical, group = 1)) +
    geom_col(fill = "#727272", color = "black", width = .8, 
             alpha = .9, size = 0.3) + 
    geom_errorbar(aes(ymin = empirical - se,
                      ymax = empirical + se),
                  color = "#22292F",
                  size = 0.3,
                  width = .1) +  
    scale_y_continuous(limits = c(0, 7), breaks = seq(0, 7, by = 1),
                       expand = c(0, 0)) +
    guides(color = FALSE) +
    labs(
      x = "",
      y = "Local cohesion"
    ))

(global_cohesion_plot <- cohesion_data %>% 
    filter(treatment == "global") %>% 
    mutate(
      feedback = fct_relevel(feedback, "correspondence-enhanced\nconcept-map feedback",
                             "conventional concept-\nmap feedback",
                             "spatially contiguous\nfeedback",
                             "no feedback")
    ) %>% 
    ggplot(aes(feedback, empirical, group = 1)) +
    geom_col(fill = "#727272", color = "black", width = .8, 
             alpha = .9, size = 0.3) + 
    geom_errorbar(aes(ymin = empirical - se,
                      ymax = empirical + se),
                  color = "#22292F",
                  size = 0.3,
                  width = .1) +
    scale_y_continuous(limits = c(0, 3.5),
                       breaks = seq(0, 3.5, by = 0.5),
                       expand = c(0, 0)) +
    guides(color = FALSE) +
    labs(
      x = "",
      y = "Global cohesion"
    ))

plot_grid(local_cohesion_plot, global_cohesion_plot,
          labels = c("Local-cohesion-hypothesis", "Global-cohesion-hypothesis"),
          ncol = 1, align = "v", axis = "b",
          label_size = 12)


ggsave("figures/figure3b.png", width = 19, height = 24, unit = "cm")

