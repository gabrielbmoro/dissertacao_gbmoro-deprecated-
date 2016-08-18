library(dplyr);
df <- read.csv("threadAnalyseOutput.csv");
k <- df %>% select(thread,hardwareCounter,value) %>%
     group_by(thread,hardwareCounter) %>%
     as.data.frame();

library(ggplot2);
ggplot(k, aes(x=as.factor(thread), y=value, color=hardwareCounter)) +
  geom_line(aes(group=thread)) +
  theme_bw() + scale_y_log10() +
  facet_wrap(~hardwareCounter);
