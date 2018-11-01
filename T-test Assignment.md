---
title: "t-test questions"
author: "Yuefu Jiang"
date: "October 18, 2018"
output:
  html_document: default
  pdf_document: default
  word_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
```{R}
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
bodytemp$sex <- bodytemp$sex %>% recode("1" = "male",
                                        "2" = "female")

bodytemp$sex <- factor(bodytemp$sex)
```
The Code can be found in OCT11.R

## One Sample T-test
```{r}
t.test(bodytemp$temp, mu = 98.6)
```
```
One Sample t-test

data:  bodytemp$temp
t = -5.4548, df = 129, p-value = 2.411e-07
alternative hypothesis: true mean is not equal to 98.6
95 percent confidence interval:
 98.12200 98.37646
sample estimates:
mean of x 
 98.24923 
```
1. "mu" stands for the true mean of the population.
2. P-value interpretation: In this case, the p-value means that the probability of mu being 98.6 is 2.411e-07.
3. Ho in words is "the true mean of the population is equal to 98.6".
4. The 95% CI is centered on the mean of x: 98.24923.

## one Sample T-test: two Parameterizations.
A)
```{r}
t.test(bodytemp$temp, mu = 98.6) 
## this is a one sample t-test on the body temperature, with an null hyposisized true mean of 98.6.
```
```
One Sample t-test

data:  bodytemp$temp
#data source
t = -5.4548, df = 129, p-value = 2.411e-07
#test statistics , degrees of freedom, p-value displayed
alternative hypothesis: true mean is not equal to 98.6
#alternative hyposthesis listed
95 percent confidence interval:
 98.12200 98.37646
#95% confidence interval: that we are 95% sure the true mean of the population, mu will fall in this range.
sample estimates:
mean of x 
 98.24923 
```
B)
```{r}
t.test(bodytemp$temp - 98.6, mu = 0)
## this is a one sample t-test on the body temperature, with an null hyposisized difference between 98.6 and true mean being 0.
```
```
One Sample t-test

data:  bodytemp$temp - 98.6 #data source
t = -5.4548, df = 129, p-value = 2.411e-07
#test statistics , degrees of freedom, p-value displayed
alternative hypothesis: true mean is not equal to 0
#alternative hyposthesis listed
95 percent confidence interval:
 -0.4779971 -0.2235414
# that we are 95% sure that the difference between true mean of population, mu and 98.6 will fall in this range.
sample estimates:
 mean of x 
-0.3507692
```
1. While mathmatically the calculations were the same in these tests, the statistical meaning of them were different. When mu = 98.6, this test is a plain one-sample t-test that estimate the true mean of the population.
2. While the one with mu = 0 is a paired test, as a "treatment" occurs and we are interested in whether the difference measured is constantly away from 0.
3. In this case, these result did support the same conclusion mathmatically. However, the statistical question of (A) was whether not the true mean of the population was 98.6, while in (B) the questions becomes whether difference between true mean and 98.6 is 0, which measure the changes.
4. Like stated above, the question asked above were different. In some ways, these might be complementary.
5. Both of these outputs have information of raw effect size. 
## Two Sample t tests in R


```{r}
t.test(temp ~ sex,
       data = bodytemp)

t.test(temp ~ sex,
       data = bodytemp,
       paired = FALSE,
       var.equal = FALSE,
       conf.level = 0.95)
```

Output
```
data:  temp by sex
t = 2.2854, df = 127.51, p-value = 0.02394
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.03881298 0.53964856
sample estimates:
mean in group female   mean in group male 
            98.39385             98.10462 
```

1. This analysis showed significant difference between males and females in body temperature at the confidence level of 0.95.
2. The absolute effect size of this output is |98.39385-98.10462|=0.28923. 
3. The confidence interval is 
```
95 percent confidence interval:
 0.03881298 0.53964856
```
4. The degree of freedom showed here is a scaled number coming from both population. This is the result fo a 2 sample t-test.

### Reporting t-test in paper
A paired-samples t-test was conducted to compare difference in body temperature among different sexes; at a confidence level of 95%, the test resulted a test statitics of  2.2854 along with a a p-value of 0.02394, the test has suggested a significant difference between male and female populations in body temperature. By analysis, female population has a body temperature 0.28923 F higher than that of male population on average.

## Two Sample t tests in R: Equal Variance

```{r}
t.test(temp ~ sex,
       data = bodytemp,
       var.equal = TRUE)
```
```
Two Sample t-test

data:  temp by sex
t = 2.2854, df = 128, p-value = 0.02393 #test statistics
alternative hypothesis: true difference in means is not equal to 0 #Ha
95 percent confidence interval: #CI
 0.03882216 0.53963938
sample estimates: #sample estimates of groups
mean in group female   mean in group male 
            98.39385             98.10462 
```
1. This test assumed same variance upon two populations.
2. In this case, the degree freedom is calculated by just the #observations - 2, as we assumed equal varience.
3. The p-value has changed. 

## One sample t-test as Linear Model
```{R}
lm.0 <- lm(98.6-temp~1, data = bodytemp)
summary(lm.0)
```
```
Call:
lm(formula = 98.6 - temp ~ 1, data = bodytemp)

Residuals: 
     Min       1Q   Median       3Q      Max 
-2.55077 -0.45077 -0.05077  0.44923  1.94923 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   0.3508     0.0643   5.455 2.41e-07 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.7332 on 129 degrees of freedom
```
1. This linear model calculate the difference 98.6 - bodytemp, which are simillar.
2. t.test(bodytemp$temp - 98.6, mu = 0)
3. Although the result suggests the same conclusion, the t-test has opposite signs as the t-test above was calculated as temp - 98.6, as in this linear model is calculated as 98.6 - temp. 
4. The estimate and standard error of that. This gives the estimated value of (98.6 - temp) as well as the SE of it.

## Two sample t-test as Linear Model(effect)
```{R}
lm.1 <- lm(temp~sex, data = bodytemp)
summary(lm.1)
```
```
Call:
lm(formula = temp ~ sex, data = bodytemp)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.99385 -0.47154  0.00615  0.40615  2.40615 

Coefficients:
            Estimate Std. Error  t value Pr(>|t|)    
(Intercept) 98.39385    0.08949 1099.530   <2e-16 ***
sexmale     -0.28923    0.12655   -2.285   0.0239 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.7215 on 128 degrees of freedom
Multiple R-squared:  0.03921,	Adjusted R-squared:  0.0317 
F-statistic: 5.223 on 1 and 128 DF,  p-value: 0.02393
```
1. The formulation of t test: temp ~ sex; The formulation of linear model: temp ~ sex.
The formulations were the same.
2. The numbers were't different, as the mathmatical procedures are the same.
3. This line suggests how different the male population differs from the other population. 
4. The male mean body temperature could be calculated by 98.39385(intercept) + -0.28923 (sexmale). The female data is just 98.39385(intercept).
5. sqrt(F) = 2.28538. it has the same absolute value as the t-value. 

### CI
```{R}
confint(lm.1)
```
```
                2.5 %      97.5 %
(Intercept) 98.2167805 98.57091178
sexmale     -0.5396394 -0.03882216
```
1. It's from 2.5%th to 97.5%th , which the interval is 95%.
2. The cinfidence interval matches (in absolute values).

## Two sample t-test as Linear Model(means)
```{R}
lm.2 <- lm(temp~ -1 + sex, data = bodytemp)
summary(lm.2)
```
```
Call:
lm(formula = temp ~ -1 + sex, data = bodytemp)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.99385 -0.47154  0.00615  0.40615  2.40615 

Coefficients:
          Estimate Std. Error t value Pr(>|t|)    
sexfemale 98.39385    0.08949    1100   <2e-16 ***
sexmale   98.10462    0.08949    1096   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.7215 on 128 degrees of freedom
Multiple R-squared:  0.9999,	Adjusted R-squared:  0.9999 
F-statistic: 1.205e+06 on 2 and 128 DF,  p-value: < 2.2e-16
```
This linear model was different than all previous t-tests. This test suggests independently the male and the female population while having a F test evaluating the difference, which came out significantly different.

