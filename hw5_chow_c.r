# Directions:

# This file contains homework questions for the lecture on data forensics
# and statistics. Questions appear as comments in the file. 

# The first four questions are narrative only, meaning you can just write an
# answer and do not need to write computer code. For other questions, please 
# see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################

# 1. What is a Frequency Distribution? [comprehension]

#A frequency distribution shows the frequencies, or numbers that occur more
#often, in a data set. Usually numbers that occur often are seen in a frequency
#distribution, and graphs like histograms can show that amount. 

# 2. What is a Relative Frequency Distribution? [comprehension]

#A relative frequency distribution is a subcategory of a frequency distribution,
#as instead of the frequency of numbers that occur more often, it shows the
#percentages. 

# 3. What is Deviation a measure of? [comprehension]

#A deviation is a measure of an observed value compared to another value.
#In the case of Standard Deviation, it's the mean but for Deviation it can
#just be any value in the data set. 

# 4. What is Standard Deviation? [comprehension]

#Standard Deviation is the average distance of a data point to the mean. 
#Usually there's a measure of being 3 SD's away from the mean. It shows how 
#dispersed the data can be toward or away the mean. 

# 5. Load the Craigslist data and then compute:

setwd("/Users/charlottechow/sts115_cchow")
craigslist <- read.csv ("cl_rentals.csv")
#
#     a. The number of rows and columns. [code completion + comprehension]
nrow(craigslist)
ncol(craigslist)

#lists number of rows and columns (only number--not name)

#     b. The names of the columns. [code completion + comprehension]
colnames(craigslist)

#lists the names of the columns, col alone won't tell the names in the console

#     c. A structural summary of the data. [code completion + comprehension]
str(craigslist)
#Str is a structural summary because it shows each column and what its specific
#type of structure is (number, character, vector, etc). It also gives some
#parts of the responses so it gives examples of how its formatted.

#     d. A statistical summary of the data. [code completion + comprehension]
summary(craigslist)
#This is a statistical summary because it gives the IQR summary, median, mean
#, max's, NA's, etc. It primarily gives us numbers based on each column and 
#it gives the summary for each one. 

# 6. The goal of this exercise is to compute the number of missing values in
#    every column of the Craigslist data.
#
#    a. Write a function called `count_na` that accepts a vector as input and
#       returns the number of missing values in the vector. Confirm that your
#       function works by testing it on a few vectors. 
#.      [code completion + comprehension]

  
count_na <- function(x){
  sum(is.na(x))
}

count_na(craigslist$city)
count_na(craigslist$parking)
count_na(craigslist$shp_city)
  
#don't need a for loop for the function, can just plug in the vector next

for (i in craigslist){
  print(count_na(i))
}
#attempt code^: gives the NA's for all the columns since it's going through 
#the entire set and finding. Not specific for the question

#    b. Test your function on the `pets` column from the Craigslist data. The
#       result should be 14. If you get an error or a different result, try
#       part a again.
#       [code completion + comprehension]
count_na(craigslist$pets)

#dollar sign specifies we want the pets column, returns 14 NA's

#    c. Use an apply function to apply your function to all of the columns in
#       the Craigslist data set. Include the result in your answer.
#       [code completion + comprehension]

lapply(craigslist, count_na)
#I used lapply since it applies the count_na function onto each element in the
#craigslist list so it goes through all the columns

#    d. Which columns have 0 missing values? [comprehension]
#Title, text, date_posted, deleted, laundry, parking, craigslist all have 0 
#missing values


# 7. What time period does this data cover? Hint: convert the `date_posted`
#    column to an appropriate data type, then use the `range` function.
#    [code completion + comprehension]
library(lubridate)
converted_time <- format(as.Date(craigslist$date_posted), "%Y-%m")
converted_time

range(converted_time)
#makes the format of the year-month, need as.Date to show if converted correctly
#range shows from when to when, so shows January 2021 to March 2021

# 8. Compute the mean price for each pets category. Based on the means, are
#    apartments that allow pets typically more expensive? Explain, being
#    careful to point out any subtleties in the result.
#    [code completion + comprehension + interpretation]

table(craigslist$pets)
class(craigslist$pets)
mean(craigslist$pets=="both", na.rm = TRUE)
both_pet = craigslist[craigslist$pets=="both",]
cats_pet = craigslist[craigslist$pets=="cats",]
dogs_pet = craigslist[craigslist$pets=="dogs",]
none_pet = craigslist[craigslist$pets=="none",]

mean(both_pet$price, na.rm=TRUE)
mean(cats_pet$price, na.rm=TRUE)
mean(dogs_pet$price, na.rm=TRUE)
mean(none_pet$price, na.rm=TRUE)

#correct but should try to use the apply function

#Based on the means, we can't really assume that apartments that allow pets are
#typically more expensive. No pets in apartments has a mean of $1740.128, but
#apartments that allow cats has a mean of $1531.63, so we can't assume allowing
#pets makes it more expensive since the cats mean is lower than the no pets. 

mean_pets <- function(x){
  mean(x,na.rm=TRUE)
}
mean_pets(craigslist$pets)

for (i in craigslist){
  print(mean_pets(i))
}
#not correct but attempts

# 9. The `sort` function sorts the elements of a vector. For instance, try
#    running this code:
#
    x = c(4, 5, 1)
    sort(x)
#    
#    Another way to sort vectors is by using the `order` function. The order
#    function returns the indices for the sorted values rather than the values
#    themselves:
#
    x = c(4, 5, 1)
    order(x)
#
#    These can be used to sort the vector by subsetting:
#
    x[order(x)]
#    
#    The key advantage of `order` over `sort` is that it can also be used to
#    sort one vector based on another, as long as the two vectors have the same
#    length.
#    
#    Create two vectors with the same length, and use one to sort the elements
#    of the other. Explain how it (should) work.
#    [code completion + comprehension]

z <-c(9,1,7)
y <-c(4,2,6)
z[order(y)]
#z is what orders, look at the outside

dataframe <- data.frame(
  z=c("a", "c", "b"),
  y=c("e", "g", "f")
)

dataframe[
  with(dataframe, order(z)),
]
#attempted code, not using letters though

# 10. Use the `order` function to sort the rows of the Craigslist data set
#     based on the `sqft` column. [code completion + comprehension]
#
#     a. Compute a data frame that contains the city, square footage, and price
#        for the 5 largest apartments. [code completion + comprehension]

#tails(craigslist[order(craigslist$sqft,na.last=FALSE), c("city", "sqft", "price")],n=5)

head(craigslist[order(-craigslist$sqft), c("city", "sqft", "price")],n=5)

#go through craigslist dataframe, sqft column, and sort NA's come last 
#largest sqft is sac at 88900 sqft for 1300 a month
#probably amazon warehouse size but prob isn't right
#highest value at bottom
#check data, create subset of craigsalist (sqft, city, price)
#see global environment shows same # of observations but diff columns
#or tails with no minus

cl_subset = craigslist[c("city", "sqft", "price")]
cl_subset

#orders
craigslist_ordered_sqft = order(craigslist$sqft, decreasing=TRUE)
craigslist_ordered_sqft
#     b. Do you think any of the 5 square footage values are outliers? Explain
#        your reasoning. [interpretation]
#I believe that the 1st response, Sacramento with 88900, is an outlier, as 
#that's incredibly large for an apartment and it won't make sense for that
#to be listed with such a large space. 


#     c. Do you think any of the 5 square footage values are erroneous
#        (incorrect in the data)? [interpretation]
#I think that the 2nd response, the Roseville with 8190 sqft, is erroneous,
#as although it's much smaller than the outleir, having an 8000 sqft apartment
#also doesn't make sense. Even if you look at the other 3 largest apartments, 
#they are in the 2000's range, so I think maybe it was mistyped as 8190 instead
#of may 1190 or 2190

