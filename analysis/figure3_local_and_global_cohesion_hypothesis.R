library(tidyverse)
library(cowplot)
library(hrbrthemes)

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
    geom_col(fill = "#8b8b8b", color = "black") + 
    geom_errorbar(aes(ymin = empirical - se,
                      ymax = empirical + se),
                  color = "#22292F",
                  width = .1) +  
    scale_y_continuous(limits = c(0, 6.3), breaks = seq(0, 8, by = 1),
                       expand = c(0, 0)) +
    theme_ipsum_tw() +
    guides(color = FALSE) +
    theme(
      plot.margin = unit(rep(2, 4), "cm"),
      axis.text = element_text(size = 26, angle = 0,
                               hjust = 0.5, color = "black"),
      axis.text.x = element_text(size = 16, margin = margin(t = 10)),
      axis.title.y = element_text(margin = margin(r = 30), hjust = 0.5, face = "bold",
                                  size = 18, color = "#000000"),
      axis.text.y = element_text(size = 16, margin = margin(r = 10)),
      panel.grid.major.y = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.y = element_blank(),
      panel.grid.minor.x = element_blank(),
      axis.line = element_line(color = "black"),
      axis.ticks.x = element_line(color = "black"),
      axis.ticks.y = element_line(color = "black")
    ) +
    scale_color_grey(start = 0, end = 0.7) +
    labs(
      x = "",
      y = "Local cohesion\n(number of unconnected\nadjacent sentences)"
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
    geom_col(fill = "#8b8b8b", color = "black") + 
    geom_errorbar(aes(ymin = empirical - se,
                      ymax = empirical + se),
                  color = "#22292F",
                  width = .1) +
    scale_y_continuous(limits = c(0, 3.4),
                       breaks = seq(0, 4, by = 1),
                       expand = c(0, 0)) +
    theme_ipsum_tw() +
    guides(color = FALSE) +
    theme(
      plot.margin = unit(rep(2, 4), "cm"),
      axis.text = element_text(size = 26, angle = 0,
                               hjust = 0.5, color = "black"),
      axis.text.x = element_text(size = 16, margin = margin(t = 10)),
      axis.title.y = element_text(margin = margin(r = 30), hjust = 0.5, face = "bold",
                                  size = 18, color = "#000000"),
      axis.text.y = element_text(size = 16, margin = margin(r = 10)),
      panel.grid.major.y = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.y = element_blank(),
      panel.grid.minor.x = element_blank(),
      axis.line = element_line(color = "black"),
      axis.ticks.x = element_line(color = "black"),
      axis.ticks.y = element_line(color = "black")
    ) +
    scale_color_grey(start = 0, end = 0.7) +
    labs(
      x = "",
      y = "Global cohesion"
    ))

plot_grid(local_cohesion_plot, global_cohesion_plot,
          labels = c("Local-cohesion-hypothesis", "Global-cohesion-hypothesis"),
          ncol = 1, align = "v", axis = "b")


ggsave("manuscript/figures/figure3.png", width = 39, height = 47, unit = "cm")

