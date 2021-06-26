library(RaMS)
library(dplyr)
library(plotly)
files <- list.files("Data/", recursive = TRUE, full.names = TRUE, pattern=".mzML")
msdata1 <- grabMSdata(files)
msdata <- grabMSdata(files, mz = c(166.0862), ppm = 5, grab_what = "EIC", verbosity = 2)

#(1) TIC
TIC <- msdata1$TIC
TIC2 <- TIC %>%
  group_by(filename) %>%
  summarise(peakArea = sum(int)) %>%
  mutate(Mean = mean(peakArea),
         SD = sd(peakArea),
         CV = round(SD/Mean*100, 2))

p1 <- ggplot(TIC2, aes(x = filename, y = peakArea, group = 1)) +
  geom_bar(stat = "identity", aes(fill = filename), alpha = 0.5) +
  geom_hline(aes(yintercept = Mean + 1.96*SD), linetype="dashed", color = "grey60") +
  geom_hline(aes(yintercept = Mean - 1.96*SD), linetype="dashed", color = "grey60") +
  theme_bw()

p2 <- ggplot(TIC) +
  geom_line(aes(x = rt, y=int, color=filename)) +
  labs(x="Retention time (min)", y="Intensity", color="File name: ") +
  facet_wrap(~filename, scales = "free_y", ncol = 1) +
  theme(legend.position="top") +
  theme_bw()

ggplotly(p2)

#MS2
MS2 <- msdata1$MS2

## MS2 count
MS2count <- MS2 %>%
  group_by(filename) %>%
  summarise(MSMS = n_distinct(rt, premz))


## density of triggered MS/MS

MS2b <- MS2 %>%
  mutate(bin = ntile(premz,100))
p3 <- ggplot(MS2b, aes(x = bin, color=filename)) +
  facet_wrap(~ filename, scales = "free_y", ncol = 1) +
  geom_density() +
  theme_bw()
ggplotly(p3)


library(ggplot2)
library(plotly)
p1 <- ggplot(msdata$EIC) + geom_line(aes(x = rt, y=int, color=filename)) +
  facet_wrap(~filename, scales = "free_y", ncol = 1) +
  labs(x="Retention time (min)", y="Intensity", color="File name: ") +
  theme(legend.position="top") +
  theme_bw()
ggplotly(p1)

df1 <- msdata$EIC
library(tidyverse)
b <- df1 %>%
  group_by(filename) %>%
  summarise(peakArea = sum(int)) %>%
  mutate(Mean = mean(peakArea),
         SD = sd(peakArea),
         CV = round(SD/Mean*100, 2))





p2 <- ggplot(b, aes(x = filename, y = peakArea, group = 1)) +
  geom_point(alpha = 0.5, color = "grey50") +
  geom_bar(stat = "identity", aes(fill = filename), alpha = 0.5) +
  geom_hline(aes(yintercept = Mean + 1.96*SD), linetype="dashed", color = "grey50") +
  geom_hline(aes(yintercept = Mean - 1.96*SD), linetype="dashed", color = "grey50") +
  theme_bw()

ggplotly(p2)

## RT
c <- a %>%
  group_by(filename) %>%
  filter(int == max(int))

d <- c %>%
  mutate(means = mean(rt))


p3 <- ggplot(c, aes(x = filename, y = rt, group = 1)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_line(alpha = 0.5) +
  geom_hline(aes(yintercept = means + 1.96*stds), linetype="dashed", color = "red") +
  geom_hline(aes(yintercept = means - 1.96*stds), linetype="dashed", color = "red") +
  theme_bw()

ggplotly(p3)


ggplot(b) +
  geom_col(aes(x = filename, y = peakArea, fill = filename))
