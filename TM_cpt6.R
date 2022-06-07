
#SETUP

#load readr package to view the CSV file
library(readr)



#add packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidytext)
library(SnowballC)
library(topicmodels)
library(stm)
library(ldatuning)
library(knitr)
library(LDAvis)

#WRANGLE

#pull csv soar goal file into the console
#use the col_types = argument to change the column types from numeric to characters.
soar_data1 <- read_csv("file/Soar-resposes.csv")
col_types = cols(Department = col_character(),
                 Goal = col_character(), 
)

#check out first Five rows of our data
head(soar_data1)
