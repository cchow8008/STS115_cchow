# Directions:

# This file contains homework questions for the lecture on data visualization.
# Questions appear as comments in the file. 

# Please see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################


# Write an R code snippet that uses regular expressions to find all occurrences of 
# dates in the string variable text that are in the format "dd/mm/yyyy" and replace 
# them with the format "yyyy-mm-dd". The text variable contains multiple dates in 
# the "dd/mm/yyyy" format interspersed with other text. For example, if text is 
# "The event was held on 23/04/2021 and the next event will be on 05/10/2022.", 
# the output should be "The event was held on 2021-04-23 and the next 
# event will be on 2022-10-05.".

library(stringr)


sample_text <- c("this is a test. please convert the date 24/03/2024 and 31/01/2019.", "The event was held on 23/04/2021 and the next event will be on 05/10/2022.")


str_replace_all(sample_text, "(0[1-9]|[1-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/(\\d{4})",
                "\\3-\\2-\\1")
#\\d is regex for digits- the {} in this case means get the exact number
str_replace_all(sample_text, "([[:digit:]]+)/([[:digit:]]+)/([[:digit:]]+)", "\\3-\\2-\\1")
#another way to convert the dates
#the sort of "formula" is to first put your current dates you have, and after
#the comma you put what you want it to convert to 

# Ensure your code dynamically handles the text variable, meaning it should work 
# for any string input following the mentioned pattern. Use relevant functions from 
# the stringr package, any other package, or base R for your solution.





# Write an R code snippet that assigns the string "I am here.  Am I alive" to
# a variable "x" and uses an Escape Sequence to put a newline between the two
# sentences.

x <- ("I am here. Am I alive")
#tried assigning it all to x just to see how it showed up without \n
x <- "I am here. \nAm I alive"
cat(x)
#\n is the newline character


# Write an R code snippet that assings the following string to the variable "y:"
#
# She said, "Hi!"

y = "She said, \"Hi!\""
cat(y)
#Using the \ \ will allow what's inside it to show up in quotes. We escape
#the quote in the string this way, but have to remember \\ means literal
#backslash so have to have whatever word we want inbetween the two. ! also 
#goes before the last \ to make sure it's included in the quotation


# [TEXT ANSWER] Explain what a Text Encoding is:

#A Text Encoding is the process of turning characters we can read, into a format
#that our computers or other machines are able to read. UTF-8 is the encoding
#system that is used to represent text encoded for the Unicode standard and as
#mentioned in the course reader, Windows is the only modern operating system that
#doesn't use it as the default encoding. 



# Write an R code snippet that creates a vector of all containing the words in the string, 
# "He wanted to say hello but was afraid".  Then use the stringr library to locate any 
# occurences of the string "hello" in your vector.

x <- c("He wanted to say hello but was afraid")
str_detect(x)
str_detect("He wanted to say hello but was afraid")
#^ my first attempts at using str_detect. It doesn't run through since it says
#argument "pattern" is missing, since the entire sentence is in quotes. 
#Realized I needed quotes around each word so it can detect how many and which
#words are in the string. 

str_detect(c("He", "wanted", "to", "say", "hello", "but", "was", "afraid"), "hello")
#Runs fine now, and it says TRUE for when it gets to "hello"

# Section "15.8 Corpus Analytics" of the reader contains a tutorial on performing
# corpus analytics on a Document Term Matrix of 19th Century novels.  A Document Term
# Matrix is a matrix that contains information about the number of times that a work 
# appears in each text in a corpus.  In class, we calculated the word frequencies for
# the novel _Wuthering Heights_.  There "data" folder in the Files area of Canvas for 
# this course contains a file names dtm.rds which holds this type of count information
# for every normalized text in the collection of novels we worked with in class. 
# First, download that file to your couse working directory.   Then, recreate a working
# version of the code in section 15.8 of the reader below.  Note that before you can 
# use the code in that section you will need to read dtm.rds file into the dtm variable
# so that the data ih the DTM is available to the rest of the code.


#this is the code I ran from lab and it ran through fine. I copied it and 
#added comments per my question from office hours. I also didn't read in the 
#dtm.rds file as mentioned above since running all this code led to me
#making my own DTM file
setwd("/Users/charlottechow/Downloads")
manifest <- read.csv("C19_novels_manifest.csv", row.names = 1)
manifest

str(manifest)

manifest$genre <- as.factor(manifest$genre)
files = readRDS("C19_novels_raw.rds")

class(files)
head(files[[1]])

files <- lapply(files, paste, collapse = " ")


library(tm)
corpus <- Corpus(VectorSource(files))
corpus

str(corpus)

class(corpus)
length(corpus)

#str_sub(corpus[[6]]$content, start=1, end=500) ?
corpus[[6]]

library(stringr)

str_sub(corpus[[6]]$content, start = 1, end = 500)
#punctuation may or may not make difference

frankenstein <- corpus[[6]]$content
frankenstein <- str_replace_all(frankenstein, pattern = "[^A-Za-z]", replacement = " ")
#pattern is regex and A to Z uppercase or lowercase
#should appear are upper or lower case A thorugh Z's 
#antyhing that isn't that is replaced iwth blank psace


frankenstein <- str_split(frankenstein, " ")
frankenstein <- lapply(frankenstein, function(x) x[x != ""])
length(frankenstein[[1]])

frankenstein[[1]][1:9]

frankenstein[[1]][188:191]

head(stopwords("SMART"), 100)
cat(str_sub(corpus[[1]]$content, start = 1, end = 1000))
library(tokenizers)
cleaned_corpus <- tm_map(
  corpus,
  tokenize_words,
  stopwords = stopwords('SMART'),
  lowercase = TRUE,
  strip_punct = TRUE,
  strip_numeric = TRUE
)

list(
  untokenized = frankenstein[[1]][1:9], 
  tokenized = cleaned_corpus[[6]]$content[1:5]
)

library(tidyverse)

wuthering_heights <- table(cleaned_corpus[[9]]$content)
wuthering_heights <- data.frame(
  word=names(wuthering_heights),
  count=as.numeric(wuthering_heights)
)
wuthering_heights <- arrange(wuthering_heights, desc(count))

head(wuthering_heights, 30)

wuthering_heights$term_frequency <- sapply(
  wuthering_heights$count,
  function(x)
    (x/sum(wuthering_heights$count))
)
head(wuthering_heights, 30)


cleaned_corpus <- lapply(cleaned_corpus, paste, collapse = " ")
cleaned_corpus <- Corpus(VectorSource(cleaned_corpus))
saveRDS(cleaned_corpus, "C19_novels_cleaned.rds")
cleaned_corpus <- readRDS("C19_novels_cleaned.rds")
dtm <- DocumentTermMatrix(cleaned_corpus) #creating my own DTM file here. 
dtm$ncol #34925
dtm$nrow #18
dtm$dimnames$Docs
dtm$dimnames$Docs <- manifest$title
dtm$dimnames$Docs #gives the list of the 18 titles
inspect(dtm)
findFreqTerms(dtm, 1000)
findAssocs(dtm, "boat", .85)

writing <- findAssocs(dtm, "writing", .85)
writing[[1]][1:15]

term_counts <- as.matrix(dtm)
term_counts <- data.frame(sort(colSums(term_counts), decreasing = TRUE))
term_counts <- cbind(newColName = rownames(term_counts), term_counts)
colnames(term_counts) <- c("term", "count")

ggplot(
  data = term_counts[1:50, ], 
  aes(
    x = fct_reorder(term, -count), 
    y = count)
) +
  geom_bar(stat = "identity") + 
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  ) + 
  labs(
    title = "Top 50 words in 18 Nineteenth-Century Novels", 
    x = "Word", 
    y = "Count"
  )

dtm_tfidf <- DocumentTermMatrix(
  cleaned_corpus,
  control = list(weighting = weightTfIdf)
) #implementing the TF-IDF scores which increases proportionally to the number
#of times a word apperas in the doc but is offset by the number of docs in the 
#courpus that have that term. The name is short for "term frequency-inverse
#document frequency". 
dtm_tfidf$dimnames$Docs <- manifest$title

tfidf_counts <- as.matrix(dtm_tfidf)
tfidf_counts <- data.frame(sort(colSums(tfidf_counts), decreasing = TRUE))
tfidf_counts <- cbind(newColName = rownames(tfidf_counts), tfidf_counts)
colnames(tfidf_counts) <- c("term", "tfidf")


ggplot(
  data = tfidf_counts[1:50, ], 
  aes(
    x = fct_reorder(term, -tfidf), 
    y = tfidf)
) +
  geom_bar(stat = "identity") + 
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  ) + 
  labs(
    title = "Words with the 50-highest tf--idf scores in 18 Nineteenth-Century Novels", 
    x = "Word", 
    y = "TF-IDF"
  )

findAssocs(dtm_tfidf, terms = "boat", corlimit = .85)

findAssocs(dtm_tfidf, terms = "writing", corlimit = .85)
tfidf_df <- as.matrix(dtm_tfidf)
tfidf_df <- as.data.frame(t(tfidf_df))
colnames(tfidf_df) <- manifest$title

rownames(tfidf_df[order(tfidf_df$Dracula, decreasing = TRUE)[1:50], ]) #gives
#the top most unique terms in the novel. and since we wrote 1:50, it'll give us
#the top 50 words
cleaned_corpus <- tm_map(cleaned_corpus, str_remove_all, pattern = "\\'s", replacement = " ")

rownames(tfidf_df[order(tfidf_df$Frankenstein, decreasing = TRUE)[1:50], ])
rownames(tfidf_df[order(tfidf_df$SenseandSensibility, decreasing = TRUE)[1:50], ])



