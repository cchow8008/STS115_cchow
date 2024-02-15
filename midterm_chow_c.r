################################################################
# This file contains questions for the midterm exam for        #
# IST008 Adventures in Data Science:  Social Science Edition,  #
# Quarter 1.  Winter Quarter, 2022.                            #
#                                                              #
# Questions appear as comments in the file.  Some questions    #
# require you to write computer code (R or Shell Script) as    #
# an answer and other questions ask you to provide text only   #
# explanations of computing and Data Science concepts.         #
# The phrase "[Text Answer]" appears immediately following     #
# each question that requires a tex only answer.               #
#                                                              #
# This is exam is designed to provide you with the chance      #
# to demonstrate your understanding of both the concepts       #
# and syntax of the methods deployed by Data Scientists.       #
# As such, even if you are unable to provide working code      #
# for questions that require you to code, we encourage you     #
# to provide pseudo code and/or a textual explanation of       #
# of your understanding of how one would approach the          #
# problem computationally, or even how the computer itself     #
# would approach the problem given you knowledge of how        #
# computers and programming languages work.                    #
#                                                              #
# Because problem solving is an essential part of being a      #
# Data Scientist, you are allowed to use any resources at      #
# your disposal to respond to the questions in this exam.      #
# This includes, but is not limited to, resources such as      #
# Google, Stack Overflow, the Course Reader, etc.  The only    #
# restriction is that you may not use live chat, messaging,    #
# email, discourse, Slack, or any other method of real-time    #
# communication with another member of the course or any       #
# other person to formulate your response.                     #
#                                                              #
# As with the homework assignments, place your answers to      #
# each question immediately following the question prompt.     #                                            #
################################################################


# Question 1. What is the command line symbol that provides 
# a shortcut to your "home" directory on your system.  For 
# example, what symbol would you use in place of "x" in the 
# command "cd x" if you wanted to use the cd command to move 
# into your home directory:

#You would use the ~ symbol to change directories (such as cd~ sts115_cchow)
#which would mean to change the directory to my home directory, sts115_cchow. 


# Question 2. Write R code to assign the value 7 to a variable "x":

x <- 7
x


# Question 3. Write R code that subtracts 3 from the variable "x" 
# and assigns the results to a variable "y":

y <- x-3
y


# Question 4. Assign the values 1, 23, 6, 2, 19, 7 to a vector:

question_4 <- c(1,23,6,2,19,7)
question_4
length(question_4)

# Question 5. Run the code `“four” < “five”`. Paste the output 
# from R into a comment and explain why you think it provided 
# that result: [Text Answer]

"four"<"five"
#The output is FALSE and I think it shows as False because R sees these as 
#characters since they're in quotes and still typed out letters. The double
#quotes make it seem like it's actual text (text strings), so it doesn't see
#it as 4<5 and therefore can't say it's TRUE, since it sees it only as characters
testttt <- c("four", "five")
class(testttt)

# Question 6. Write a for loop that loops through each element in
# the vector you created in your answer to Question 5 and prints
# each value to screen:

for (i in question_4){
  print(i)
}


# Question 7. Assign the value 3 to a variable "x" and write
# a conditional statement that test whether x is less than 5.  
# if it is, print "Yay!" to screen:


x <-3
if (x<5) {
  print("Yay!")
}

# Question 8. Download the "wine_enthusiast_rankings.csv" file from
# the "data" directory in the "Files" area of the course Canvas
# website and then write code to load into a variable called "wine_revs":

setwd("/Users/charlottechow/Downloads")
wine_revs <- read.csv("wine_enthusiast_rankings.csv")


# Question 9.  Write code to determine the class of the "wine_revs"
# data object you created in Question 8 above:

class(wine_revs)
str(wine_revs)
#class of wine_rev is a dataframe
#class of the columns are:
#Character: country, description, designiatiion, province, region 1 and 2, 
#taste name, taste twitter, title, variety, winery
#Numbers: price
#Integer: X and points

# Question 10. Write code that returns the column/variable
# names of the "wine_revs" object:

colnames(wine_revs)
nrow(wine_revs)

# Question 11. Write code to load all observations from the
# "price" column/variable of the "wine_revs" object into
# a vector called "wine_prices":

wine_prices <- data.frame(wine_revs$price)
ncol(wine_prices)

# Question 12. Subset the "wine_revs" object to create a new 
# data.frame named "wine_revs_truncated" that contains all 
# observations for only the numeric ID, Points, Price, Variety, 
# and Winery columns/variables in "wine_revs": 

#wine_revs_truncated <- wine_revs[,wine_revs$X & wine_revs$points & wine_revs$price & wine_revs$variety & wine_revs$winery]

wine_revs_truncated <- wine_revs[,c("X", "points", "price", "variety", "winery")]
ncol(wine_revs_truncated)

# Question 13. Save the "wine_revs_truncated" that you created 
# in Question 12 to your local "ist008_assignments" directory 
# as an RDS file named "wine_revs_truncated.rds":

setwd("/Users/charlottechow/sts115_cchow")
list.files ("/Users/charlottechow/sts115_cchow")


saveRDS(wine_revs_truncated, file="wine_revs_truncated.rds")
readRDS(file="wine_revs_truncated.rds")

# Question 14. Below is an R function that receives a single 
# argument (an integer) and returns the square root of that
# argument.  Write code (below the function) that calls the 
# function sending it the value 144 as its argument and assigns
# the returned result to a variable "z".  Note:  Be sure to run
# code of the function to load it into your environment before
# you try to call it in your answer or you won't be able to test
# your answer.

getSqrt <- function(argument_1) {
  retval <- sqrt(argument_1) 
  return(retval)
}

z <- getSqrt(144)
z
#Put the function and (144) so it knows to input 144, and assign it to Z
#so that way z gets the resutl (12)

# Question 15. Write code that you would use to install the "fortunes"
# package onto your local machine and then load it into the working
# R environment:

install.packages("fortunes")
library("fortunes")


# Question 16. Why doesn't R automatically load every installed package when 
# it starts: [Text Answer]

#R doesn't load every installed package when it starts due to the fact it would
#most likely make R run slower due to all the extra files and functions it 
#needs to run through/load. It would make more sense for the person coding to 
#load the specific packages they know they want or need to use. 



# Question 17. What is the git command to put a directory in your
# file system under git control (create a repository):

#The git command is git init, as it lets you turn your directory on your 
#computer into a Git repository. After that, you can do git remote add to 
#your origin and eventually branch and push it. 


# Question 18. List one advantage and one disadvantage for each of the
# following data file formats: [Text Answer]
#   
#     a. RDS files: One advantage is that RDS files take up less disk space
#when saving. One disadvantage is that they can only be used within R, so if 
#you needed to use the RDS file somewhere else, you would have to refer back to 
#R or even try to retype it out. 
#
#     b. CSV files: One advantage is that CSV is in plain text format, so it can
#be used in other applications and opened. One disadvantage is that CSV can only 
#handle simple data, so adding complex data or images won't be possible. 



# Question 19. Describe the Standard Deviation of a data set in
# your own words: [Text Answer]

#The Standard Deviation of a dataset is the average distance of a data point
#from the mean of the set. It can show how dispersed the data can be toward, or
#away the mean. Usually, there's a measure of being 3 Standard Deviation's 
#away from the mean. 



# Question 20. Discuss what statisticians mean when they talk about
# finding the "center" of a data set: [Text Answer]

#When statisticians talk about finding the "center" of a data set, they mean
#the location, which is a number that's near the middle of the data. They can
#measure this with the mean or median. Mean is the average of the data and 
#it can tell us where in the middle part is the dataset usually. The median
#is sorting the data in numerical order and finding the value in the middle,
#which can also help with finding the "center" of the dataset. 


# To submit your midterm, save this file to your local 
# "ist008_assignments" directory then stage and commit 
# this file and any other files you created as part of 
# the exam to your local repository.  Then push your
# changes to Github.
