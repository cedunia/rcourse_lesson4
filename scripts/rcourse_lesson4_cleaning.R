install.packages('purrr')

## LOAD PACKAGES ##
library(dplyr)
library(purrr)

## READ IN DATA ##
data <- list.files(path = 'data', full.names = TRUE) %>%
  map(read.table, header = TRUE, sep = "\t", na.strings = c("",NA)) %>%
  reduce(rbind)

## CLEAN DATA ##
data_clean <- data %>%
  filter(series != "tas") %>%
  mutate(series = factor(series)) %>%
  filter(alignment == 'foe' | alignment == 'friend') %>%
  mutate(alignment = factor(alignment)) %>%
  filter(!is.na(conservation)) %>%
  mutate(extinct = ifelse(conservation == "LC",0,1)) %>%
  group_by(series, alignment, alien) %>%
  arrange(episode) %>%
  filter(row_number() == 1) %>%
  ungroup()