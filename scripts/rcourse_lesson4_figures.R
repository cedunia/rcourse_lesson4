## READ IN DATA ##
source("scripts/rcourse_lesson4_cleaning.R")

## LOAD PACKAGES ##
library(ggplot2)

## ORGANIZE DATA ##
data_figs <- data_clean %>%
  mutate(series = factor(series,levels = c("tos","tng"),
                         labels = c("The Original Series","The Next Generation")))

# Summarise data by series and alignment
data_figs_sum = data_figs %>%
  group_by(series, alignment) %>%
  summarise(perc_extinct = mean(extinct)*100) %>%
  ungroup()

## MAKE FIGURES ##
extinct.plot <- ggplot(data_figs_sum, aes(x = series, 
                                          y = perc_extinct, 
                                          fill = alignment)) +
  geom_bar(stat = "identity", position = "dodge") +
  ylim(0,100) +
  geom_hline(yintercept = 50) +
  scale_fill_manual(values = c('red','yellow'))

pdf("./figures/extinct.pdf")
extinct.plot
dev.off()


  