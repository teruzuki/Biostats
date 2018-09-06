#pre-session test codes
library(devtools)
library(wildlifeR)
data("frogarms")
summary(frogarms)
make_my_data2L(dat = frogarms, my.code = "nlb24", cat.var = "sex")

#chapter 6 loading packages from CRAN

ls("package:base") #listed base packages
.libPaths("")
library()

#loading MASS library
library(MASS)

#loading CRABS
data(crabs)

#Plot data
plot(FL ~ RW, data = crabs)

#for external packages
#install packages, used personal library 
install.packages("ggplot2")

#see installed packages
installed.packages()

#load ggplot2
library(ggplot2)

#plot using qlot function
qplot(y = FL, x = RW, data = crabs)

#packages with dependencies
#installing ggpubr, A dependency of ggplot
install.packages("ggpubr", dependencies = TRUE)

#load
library(ggpubr)

#plot scatter plot
ggscatter(data = crabs, y = "FL", x = "RW")

#chanllenge: downloading COWPLOT
install.packages("cowplot", dependencies = TRUE)
#load cowplot
library(cowplot)
#plot with qplot
qplot(data = crabs, y = FL, x = RW)



#chapter 7 loading data into R from a package
#putting preloaded dataset iris into memory
data(iris)
#peek top of large dataset
head(iris)
#summerize dataset
summary(iris)
#display column name
names(iris)
#try view() command
View(iris)
#try pander:pander, didn't work
pander::pander(iris[1:10,])

#boxplots, plot petal length vs species
plot(Petal.Length ~ Species, data = iris)

#loding data from R packages
#in base R, load MASS
library(MASS)
#scatterplot
plot(FL ~ RW, data = crabs)


#learning about data in R
#to see what we have
ls()
#add new data, mean of 1, 2, 2
my.mean <- mean(c(1, 2, 2))
#list again
ls()
#to see what's in my.mean
my.mean
#to see what is my.mean
is(my.mean)
#assign letter to R objects, Char
my.abc <- c("a", "b", "c")
#to see what is my.abc
is(my.abc)
#list again
ls()
#define crabs
is(crabs)
#see structure
str(crabs)


#Load data from external R packages
#load ggplot2
library(ggplot2)
#load msleep, see column names
data(msleep)
names(msleep)
#view data
View(msleep)
#see dimention of the data frame
dim(msleep)
#plot using ggplot2. Define color based in IUCN status;
qplot(y = brainwt, x = bodywt, data = msleep, color = conservation)
#or use log of data for viewing sake
qplot(y = log(brainwt), x = log(bodywt), data = msleep, color = conservation)


#load data from script
#build R objects
year <- c(1980:2016)
#using NA for missing data
eagles <- c(3, NA, NA, NA, NA, NA, NA, NA, NA, NA, 7, 9, 15, 17, 19, 20, 20, 23, 29, 43, 51, 55, 64, 69, NA, 96, 100, NA, NA, NA, NA, NA, NA, NA, 252, 277, NA)
#merge these into one dataframe
eagle.df <- data.frame(year, eagles)
#define
is(eagle.df)
#summarize
summary(eagle.df)


#plot the eagle data
#load ggpubr
library(ggpubr)
ggscatter(data = eagle.df, y = "eagles", x = "year")



#chapter 8 loading from Github
#install devtools -> done
#load wildlifeR from Github -> done
#install_github(username/directory)
#load wildlifeR
library(wildlifeR)
#draw a scatter plot from this dataset
scatter.smooth(eggs$asymmetry, eggs$ellipticity)




#Chapter 10 loading data from CSV
#setting working directory with source file needed,check working directory
getwd()
#list files
list.files()
#read.csv() function
read.csv(file = "Medley1998.csv")
#assign data to R object med98
med98 <- read.csv(file = "Medley1998.csv")
#get to know more about what we have now
med98
ls()
dim(med98)
names(med98)
summary(med98)
#plot using ggpubr
library(ggpubr)
ggscatter(data = med98, y = "spp.div", x = "spp.rich")
ggscatter(data = med98, y = "spp.div", x = "spp.rich", color = "pH")
#challenge
read.csv(file = "Medley1998.txt")
#nope




