
library(tidyverse)
library(magrittr)
library(survminer)
library(cmprsk)
library(scales)

# This is needed if you don't have the Jaeger_JHS project open
setwd("O:/Users/Jaeger")

fpath_events <- file.path(
  '..',
  '..',
  'REGARDS',
  'JHS',
  'Derived datasets',
  '07-01-2019',
  'data',
  'output',
  'events',
  'jhs_events.rds'
)

fpath_analysis <- file.path(
  "Datasets",
  "JHS_analysis",
  "analysis1.csv"
)

jhs_events <- read_rds(fpath_events) %>% 
  select(subjid, time = time_chd_stroke, status = status_chd_stroke_int)

jhs_analysis <- read_csv(fpath_analysis) %>% 
  select(subjid, sex, currentSmoker, BPmeds)

jhs <- left_join(jhs_events, jhs_analysis, by = 'subjid')

# compute cumulative incidence curves

cml_inc = cuminc(
  ftime   = jhs$time, 
  fstatus = jhs$status, 
  group   = jhs$sex
)

# ?ggcompetingrisks

# create dataset with cumulative incidence estimates
# ggcompetingrisks makes plots too, but I don't like them.
ggdat <- cml_inc %>% 
  ggcompetingrisks(conf.int = T) %>%
  use_series('data') %>% 
  as_tibble() %>% 
  select(
    time, 
    group, # same group as in cuminc(),
    est, # est is cumulative incidence, 
    std # std is the standard deviation of est
  ) 

# one figure, two groups, no SE

ggplot(ggdat, aes(x = time, y = est, col = group))+
  geom_line(size=0.9)+
  # This is the theme that Paul M. likes
  theme_bw()+
  theme(
    panel.grid = element_blank(),
    text = element_text(size = 13, color = 'black', face = 'bold')
  ) +
  scale_y_continuous(label=scales::percent) +
  labs(x='Time, years', y = 'Cumulative Incidence, stroke or CHD')

# two figures, two groups, Confidence intervals!
ggplot(ggdat, aes(x = time, y = est))+
  geom_ribbon(col = 'grey20', alpha = 0.10, 
    aes(ymin = est - 2*std, ymax = est + 2*std)) +
  geom_line(col = 'red') +
  facet_wrap(~group) +
  theme_bw()+
  theme(
    panel.grid = element_blank(),
    text = element_text(size = 13, color = 'black', face = 'bold')
  ) +
  scale_y_continuous(label=scales::percent) +
  labs(x='Time, years', y = 'Cumulative Incidence, stroke or CHD')
