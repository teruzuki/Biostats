library(ggplot2)
library(ggpubr)
library(cowplot)
library(dplyr)

temp <- c(96.3,96.7,96.9,97,97.1,97.1,97.1,97.2,97.3,
          
          97.4,97.4,97.4,97.4,97.5,97.5,97.6,97.6,
          
          97.6,97.7,97.8,97.8,97.8,97.8,97.9,97.9,
          
          98,98,98,98,98,98,98.1,98.1,98.2,98.2,
          
          98.2,98.2,98.3,98.3,98.4,98.4,98.4,98.4,
          
          98.5,98.5,98.6,98.6,98.6,98.6,98.6,98.6,
          
          98.7,98.7,98.8,98.8,98.8,98.9,99,99,99,99.1,
          
          99.2,99.3,99.4,99.5,96.4,96.7,96.8,97.2,97.2,
          
          97.4,97.6,97.7,97.7,97.8,97.8,97.8,97.9,97.9,
          
          97.9,98,98,98,98,98,98.1,98.2,98.2,98.2,98.2,
          
          98.2,98.2,98.3,98.3,98.3,98.4,98.4,98.4,98.4,
          
          98.4,98.5,98.6,98.6,98.6,98.6,98.7,98.7,98.7,
          
          98.7,98.7,98.7,98.8,98.8,98.8,98.8,98.8,98.8,
          
          98.8,98.9,99,99,99.1,99.1,99.2,99.2,99.3,99.4,
          
          99.9,100,100.8)



sex <- c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
         
         1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
         
         1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
         
         2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
         
         2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
         
         2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2)



heartrate <- c(70,71,74,80,73,75,82,64,69,70,68,72,78,70,75,
               
               74,69,73,77,58,73,65,74,76,72,78,71,74,67,64,
               
               78,73,67,66,64,71,72,86,72,68,70,82,84,68,71,
               
               77,78,83,66,70,82,73,78,78,81,78,80,75,79,81,
               
               71,83,63,70,75,69,62,75,66,68,57,61,84,61,77,
               
               62,71,68,69,79,76,87,78,73,89,81,73,64,65,73,
               
               69,57,79,78,80,79,81,73,74,84,83,82,85,86,77,
               
               72,79,59,64,65,82,64,70,83,89,69,73,84,76,79,
               
               81,80,74,77,66,68,77,79,78,77)


bodytemp <- data.frame(temp = temp, sex = sex, heartrate = heartrate)

dim(bodytemp)
head(bodytemp)
summary(factor(bodytemp$sex))
bodytemp$sex <- bodytemp$sex %>% recode("1" = "male",
                                        "2" = "female")
summary(bodytemp$sex)

bodytemp$sex <- factor(bodytemp$sex)
summary(bodytemp$sex)
summary(bodytemp)
gghistogram(bodytemp, x = "temp", bins = 20, add ="mean") + geom_vline(xintercept = 98.6)

t.test(bodytemp$temp, mu = 98.6)
t.test(bodytemp$temp - 98.6, mu = 0)

lm.out <- lm(temp ~ heartrate, data = bodytemp)
temp.orig <- simulate(lm.out, seed = 100)
temp.stress <- simulate(lm.out, seed = 101) + 0.5 + rnorm(length(bodytemp), mean = 0, sd = sd(bodytemp$temp))
new.bodytemp <- data.frame(before = temp.orig$sim_1, stressed = temp.stress$sim_1)

difference1 <- new.bodytemp$before - new.bodytemp$stressed
new.bodytemp$difference1 <- difference1
new.bodytemp$difference2 <- new.bodytemp$stressed - new.bodytemp$before
gghistogram(new.bodytemp, x = "difference1", add = "mean")

t.test(new.bodytemp$difference2, mu = 0)

mean(new.bodytemp$difference1)
mean(new.bodytemp$difference2)
mean(abs(new.bodytemp$difference1))
mean(abs(new.bodytemp$difference2))
t.test(new.bodytemp$before,
       new.bodytemp$stressed,
       paired = TRUE)
ggscatter(y = "temp",
          x = "heartrate",
          data = bodytemp)


ggscatter(y = "temp",
          x = "heartrate",
          data = bodytemp,
          color = "sex",
          shape = "sex",
          add = "reg.line" )
`

install.packages("effsize")
library(effsize)
library(ggbeeswarm)
ggboxplot(data = bodytemp,
          y = "temp",
          x = "sex")
ggboxplot(data = bodytemp,
          y = "temp",
          x = "sex",
          fill = "sex",
          xlab = "Gender",
          ylab = "Body Temperature") + geom_beeswarm()

t.test(temp ~ sex,
       data = bodytemp)

t.test(temp ~ sex,
       data = bodytemp,
       paired = FALSE,
       var.equal = TRUE,
       conf.level = 0.95)

lm.0 <- lm(98.6 - temp ~1, data = bodytemp)
lm.1 <- lm(temp ~ sex, data = bodytemp)
lm.2 <- lm(temp ~ -1 + sex, data = bodytemp)
summary(lm.0)
summary(lm.1)
summary(lm.2)
confint(lm.2)

ggboxplot(
  data = bodytemp,
  y = "temp",
  x = "sex",
  label.x.npc = "left",
  fill = "sex",
  xlab = "Gender",
  ylab = "Body Temperature"
) + stat_compare_means(method = "t.test")

ggboxplot(
  data = bodytemp,
  y = "temp",
  x = "sex",
  label.x.npc = "left",
  fill = "sex",
  xlab = "Gender",
  ylab = "Body Temperature"
) + ylim(96, 102) + stat_compare_means(method = "t.test")

ggerrorplot(data = bodytemp,
            desc_stat = "mean_ci",
            y = "temp",
            x = "sex") + stat_compare_means(method = "t.test",
                                            label.y = 98)

ggerrorplot(data = bodytemp,
            desc_stat = "mean_ci",
            y = "temp",
            x = "sex",
            add = "dotplot")
ggerrorplot(data = bodytemp,
            desc_stat = "mean_ci",
            y = "temp",
            x = "sex",
            add = "mean_sd")
t.out <- t.test(temp~sex,
                data = bodytemp)
t.out$estimate
t.out$estimate[[1]]
t.diff <- t.out$estimate[[1]] - t.out$estimate[[2]]
t.out$conf.int

ci.lo <- t.out$estimate[[1]]
ci.up <- t.out$estimate[[2]]
t.df <- data.frame(difference = t.diff,
                   dummy.x = "",
                   ci.lo,
                   ci.up)
ggplot(data = t.df,
       aes(y = t.diff,
           x = dummy.x)) + geom_point()

ggplot(data = t.df,
       aes(y = t.diff,
           x = dummy.x)) + 
  geom_point() + geom_errorbar(aes(ymin = ci.lo,
                               ymax = ci.up),
                               width = 0)

ggplot(data = t.df,
       aes(y = t.diff,
           x = dummy.x)) + 
  geom_point() + 
  geom_errorbar(aes(ymin = ci.lo,
                    ymax = ci.up),
                width = 0) + 
  geom_hline(yintercept = 0)

ggplot(data = t.df,
       aes(y = t.diff,
           x = dummy.x)
       ) + 
  geom_point(size = 5) + 
  geom_errorbar(aes(ymin = ci.lo,
                    ymax = ci.up),
                width = 0,
                size = 2) + 
  geom_hline(yintercept = 0,
             linetype = 2) +
  xlab("") +
  ylab("Difference\n(degrees C)")
  #+ylim()

gg.means <- ggerrorplot(data = bodytemp,
            desc_stat = "mean_ci",
            y = "temp",
            x = "sex") + stat_compare_means(method = "t.test",
                                            label.y = 98)
gg.diffs <- ggplot(data = t.df,
                   aes(y = t.diff,
                       x = dummy.x)) + 
  geom_point(size = 5) + 
  geom_errorbar(aes(ymin = ci.lo,
                    ymax = ci.up),
                width = 0,
                size = 2) + 
  geom_hline(yintercept = 0,
             linetype = 2) +
  xlab("") +
  ylab("Difference\n(degrees C)")


cowplot :: plot_grid(
  gg.means,
  gg.diffs,
  rel_widths = c(2, 1.5)
)

cohen.d (temp ~sex,
         data = bodytemp)
