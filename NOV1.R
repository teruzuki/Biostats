#NOV1.R
#lab 11c: regression modeling

#data prep
dat.orig <- read.csv(file = "data_orig.csv")
dat.wk4.only <- dat.orig[,c("conc.AL", "ht.wk.4")]
names(dat.wk4.only)[2] <- "height"
dat.wk4.only$conc.AL.FAC <- factor(dat.wk4.only$conc.AL)

#Fake data creation
N <- dim(dat.wk4.only)[1]
dat.wk4.only$light <- runif(n = N, min = 80, max = 100)

#plot height
library(ggpubr)
ggscatter(y = "height",
          x = "conc.AL",
          data = dat.wk4.only,
          add = "loess")
#with regression line
ggscatter(y = "height",
          x = "conc.AL",
          data = dat.wk4.only,
          add = c("reg.line"),
          conf.int = TRUE)
#regression analysis 1: height~AL
model.null <- lm(height~1, 
                 data = dat.wk4.only)
model.alt <- lm(height~conc.AL,
                data = dat.wk4.only)
anova(model.null, model.alt)#ns F

#examine model param
summary(model.alt)
#model comparison with AIC
library(bbmle)
AICtab(model.null,
       model.alt,
       base = TRUE)
#multiple model comparison
model.light <- lm(height~light,
                  data = dat.wk4.only)
summary(model.light)
AICtab(model.null,
       model.alt,
       model.light)


#ANOVA analysis
anova.alt <- lm(height~conc.AL.FAC,
                data = dat.wk4.only)
anova.null <- lm(height~1,
                 data = dat.wk4.only)
summary(anova.alt)
anova(anova.null,
      anova.alt)
#tukeyHSD
aov.alt <- aov(height ~ conc.AL.FAC, 
               data = dat.wk4.only)
TukeyHSD(aov.alt)
