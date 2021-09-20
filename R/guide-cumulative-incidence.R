

library(tidyverse)
library(magrittr)
library(survminer)
library(cmprsk)
library(scales)
library(survival)

head(flchain)

# compute cumulative incidence curves

cml_inc = cuminc(
  ftime   = flchain$futime,
  fstatus = flchain$death,
  group   = flchain$creatinine > 1
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
