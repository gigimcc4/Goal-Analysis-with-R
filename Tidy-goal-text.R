


## Background


#SETUP

#load packages
library(readr)
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

soar_data1

library(vtree)
vtree(soar_data1, "Department", palette = 3, sortfill = TRUE)


#check out first Five rows of our data
head(soar_data1)


# use tidytext functions for tidying and tokenizing text.
#introduce functions from the stm package for processing text and transforming data frames 
#into new data structures required for topic modeling
# reference https://www.tidytextmining.com/tidytext.html

#tokenize soar_data1 using the unnest_tokens() and remove stop words
soardata1_df <- soar_data1 %>%
  unnest_tokens(output = word, input = Goal) %>%
  anti_join(stop_words, by = "word")


soardata1_df_counts <- soardata1_df
count(word, sort = TRUE)


soardata1_bigrams <- soar_data1 %>%
  unnest_tokens(output = word, input = Goal, token = "ngrams", n = 2) %>%
  anti_join(stop_words, by = "word")

soardata1_bigrams_counts <- soardata1_bigrams %>%
  count(word, sort = TRUE)

soardata1_bigrams_counts

#do a quick word count
soar_data_counts <- soardata1_df %>%
count(word, sort = TRUE)

wordcloud2(soar_data_counts)    

#Itried a word cloud here and was unable to get it to work.Does it need one here

#Let's look at a quick visualization of the most common words in the yearly goals
soarviz_1 <- soardata1_df %>%
  count(word, sort = TRUE) %>%
  filter(n > 10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col() +
  labs(y = NULL)

soarviz_1



#SENTIMENT ANALYSIS
#Let's conduct a Sentiment Analysis to get a better sense of students emotions from the goal they wrote

get_sentiments("afinn")

#DOCUMENT TERM MATRIX
#create a document term matrix
view(soardata1_tidy)

soar_dtm <- soardata1_tidy %>%
  count(Goal, word) %>%
  cast_dtm(Goal, word, n)







#STEMING
#field and students is an interesting in the word count let's look at this more closely in text with the gerp package
soar_quotes <- soar_data1 %>%
  select(Goal) %>% 
  filter(grepl('field', Goal))

view(soar_quotes)

sample_n(soar_quotes, 10)

#search for a word stem with goal
soar_quotes2 <- soar_data1 %>%
  select(Goal) %>% 
  filter(grepl('students*', Goal))

view(soar_quotes2)

sample_n(soar_quotes2, 10)

#from the gerp looks like students is associated with the broader theme of impact, influence. 
#I wonder how much though



#DATA VISUALIZATION



This is not top 10 words in each department. This is the 10 most common words and how many times they appear in each department

soarvizwordcount <- ggplot(soardata1_df_counts , aes(n, word, fill = Department)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~Department, ncol = 2, scales = "free_x")

soarvizwordcount 


Figure out this visualization

```{r}
library(LDAvis)
library('tsne')

svd_tsne <- function(x) t
tsne(svd(x)$u)
json <- createJSON(
  phi = ldaResult$beta,
  theta = ldaResult$theta,
  doc.length = rowSums(cast_dtm),
  vocab = colnames(cast_dtm),
  mds.method = svd_tsne,
  plot.ops = list(xlab = "", ylab="")
)
serVis(json)
```
```
