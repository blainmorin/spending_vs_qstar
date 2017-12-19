pkg = "npar_1.0.tar.gz"
loc = "http://www.statmethods.net/RiA"
url = paste(loc, pkg, sep = "/")
download.file(url,pkg)
install.packages(pkg, repos = NULL, type = "source")

library(npar)

result = oneway(episode ~ as.factor(qstarrating), k12ReducedRG)

plot(result)


medians = k12ReducedRG %>%
  group_by(qstarrating) %>%
  summarise(med = median(episode), n = n())


k12ReducedRG %>%
  ggplot(aes(x = as.factor(qstarrating), y = episode)) +
  geom_boxplot(size = 1.2) +
  
  geom_text(aes(y = 39000, x = 1), label = medians$med[1]) +
  geom_text(aes(y = 37500, x = 1), label = medians$n[1]) +
  
  geom_text(aes(y = 39000, x = 2), label = medians$med[2]) +
  geom_text(aes(y = 37500, x = 2), label = medians$n[2]) +
  
  geom_text(aes(y = 39000, x = 3), label = medians$med[3]) +
  geom_text(aes(y = 37500, x = 3), label = medians$n[3]) +
  
  geom_text(aes(y = 39000, x = 4), label = medians$med[4]) +
  geom_text(aes(y = 37500, x = 4), label = medians$n[4]) +
  
  geom_text(aes(y = 39000, x = 5), label = medians$med[5]) +
  geom_text(aes(y = 37500, x = 5), label = medians$n[5]) +
  
  geom_text(aes(y = 39000, x = 6), label = medians$med[6]) +
  geom_text(aes(y = 37500, x = 6), label = medians$n[6]) +
  
  geom_hline(yintercept = median(k12ReducedRG$episode), color = "cyan3", size = 1.3, linetype="dashed") +
  
  theme_classic() +
  xlab("Quality Star Rating") +
  ylab("Average Spending ($)") +
  ggtitle("Star Rating vs Spending") +
  theme(plot.title = element_text(hjust = .5))
