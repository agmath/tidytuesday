library(tidyverse)
library(kableExtra)
library(patchwork)

detectors <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-07-18/detectors.csv")

detectors %>%
  head()

detectors %>%
  select(native, detector, model, .pred_AI) %>%
  mutate(type = ifelse(model == "Human", native, model)) %>%
  mutate(type = case_when(
    (type == "No") ~ "Non-Native",
    (type == "Yes") ~ "Native",
    TRUE ~ type
  )) %>%
  mutate(type = factor(type, levels = c("Native", "GPT3", "Non-Native", "GPT4"))) %>%
  ggplot() + 
  geom_boxplot(aes(x = .pred_AI,
                   y = detector,
                   fill = detector)) +
  facet_wrap(~ type) +
  labs(title = "AI Detector Performance on Writing Samples", 
       subtitle = "Native and Non-Native English Speakers (left), Machine-generated text (right)",
       x = "Predicted Probability of AI Generation",
       y = "",
       caption = "Caption. Four sets of side-by-side boxplots showing bias of AI detection algorithms against non-native English speakers.") +
  theme(legend.pos = "None")
