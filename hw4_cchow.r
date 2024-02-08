# Directions:

# This file contains homework questions for the lecture on working with files
# and data exploration. Questions appear as comments in the file. 

# Please see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################

# 1. Write out the file extension and explain what it means for the following
#    files: [comprehension]
#
#       a. `myscript.py`
#
#       b. `/home/arthur/images/selfie.jpg`
#
#       c. `~/Documents/data.csv`



#a. File extention: py (Python). This means myscript is a file that was written
#in Python
#b: File extension: jpeg (Joint photographic Experts group). This means selfie
#is a file in Arthur's images folder and it's an image file.
#c: File extension: csv (comma separated values). This means data is from 
#the person's documents and it's a file (comma separated values file)


# 2. Which command line utility can be used to determine the type of a file? 
# [code completion]

#file myscript.py
#file "file name" will give the file type, such as file dogs.csv will show that
#it's a csv file

# 3. Why is it a bad idea to explicitly call the `setwd` function within an R
#    script? [comprehension]

#It's a bad idea to call setwd in the R script because it can make your code
#difficult to understand and there are other easier ways to change the directory
#One way you can do it is with to do it at beginning of code with 
#session -> set working directory ->to source file location

# 4. List one advantage and one disadvantage for each of these formats:
# [comprehension]
#   
#     a. RDS files
#
#     b. CSV files

#RDS: One advantage is that RDS files take less disk space to save,
#but one disadvantage is that they can only be used in R, so 
#if you need to use the data elsewhere, you might have to retype it out
#or keep referring back to R.

#CSV: One advantage is that since CSV is plain text format, it can be used in 
#other formats and opened in other applications. One disadvantage is 
#CSV can only handle simple data and if you need to add complex data or 
#even images, it won't be able to work with CSV format. 


# 5. Why doesn't R automatically load every installed package when it starts?
# [comprehension]

#R doesn't load every isntalled package when it starts because it would probably
#make R run slower due to all the extra files and functions it needs to 
#run through. Also, it would make more sense to have the person coding load
#the specific packages they know they need to use. 

# 6. Load the dogs data from the `dogs.rds` file provided in lecture.

setwd("/Users/charlottechow/sts115_cchow/files_in_r/best_in_show")
list.files ("/Users/charlottechow/sts115_cchow/files_in_r/best_in_show")



write.csv (dogs, "dogs_new.csv", row.names=FALSE)
saveRDS(dogs,"dogs_new.rds")

dogs = readRDS('dogs.RDS')

class(dogs)
#
#     a. How many missing values are in the `height` column? 
#       [code completion + comprehension]


nrow(dogs[is.na(dogs$height),])
dim(dogs[is.na(dogs$height),])

sum(is.na(dogs$height))
#
#     b. Think of a strategy to check the number of missing values in every
#        column using no more than 3 lines of code. Hint: think about last
#        week's lecture. Explain your strategy in words. 
#       [code completion + comprehension]

for(i in 1:ncol(dogs)) {
  print(sum(is.na(dogs[i])))
}
  
  
  #for each column in the dogs dataframe from col 1 to total
  #columns
#add i so it's each of the columsn to go through

#
#     c. Which column has the most missing values? Try to solve this by
#        implementing your strategy from part b. If that doesn't work, you can
#        use the `summary` function to get the number of missing values in each
#        column as well as a lot of other information (we'll discuss this
#        function more next week).
#       [code completion + comprehension]

summary(dogs)
#the column with the most missing values is weight with 86 NA's

#colSums(is.na(dogs))

#for(i in 1:ncol(dogs)) {
  #print(is.na(max(dogs[i])))
#}


#for(i in 1:ncol(dogs)) {
 # print(amount_na < (dogs[i])
#}

#amount_na <- is.na(10)
#^These were my attempt codes for finding the max NA's, I ended up just using
#summary since I had a hard time trying to get the correct output. 


# 7. Use indexing to get the subset of the dogs data which only contains large
#    dogs that are good with kids (the category `high` in the `kids` column
#    means good with kids). [code completion + comprehension]

ncol(dogs)
head(dogs)
subset_kidfriendly_largesize <- dogs[dogs$kids=="high" & dogs$size=="large", ]
subset_kidfriendly_largesize


dogs[dogs$size=="large", ]
dogs[dogs$kids=="high", ]



#need size and kids columns, easier to assign to object to give results
#need the , to show which columns you want to look at

# 8. With the dogs data:
#
#     a. Write the condition to test which dogs need daily grooming (the result
#        should be a logical vector). Does it contain missing values? 
#       [code completion + comprehension]

dog_grooming <- dogs$grooming
for (i in dog_grooming){
  if (i=="daily")
    print (i)
}
#not correct code ^
table(dogs$grooming=="daily")
dogs[dogs$grooming=="daily",]

is.na(dogs$grooming=="daily")

#last code is the correct one
#shows logcial vector of TRUE or FALSE

#
#     b. Use the condition from part a to get the subset of all rows containing
#        dogs that need daily grooming. How many rows are there?
#       [code completion + comprehension]

dogs[dogs$grooming=="daily",]
daily_grooming <-dogs[dogs$grooming=="daily",]
daily_grooming
#in global environment it shows 83 obversations so 83 rows for daily grooming

#
#     c. Use the `table` function to compute the number of dogs in each
#        grooming category. You should see a different count than in part b for
#        daily grooming. What do you think is the reason for this difference?
#       [code completion + interpretation]

table(dogs$grooming)
#this table shows 23 for daily grooming, and I think the reason for this is
#maybe because the NA's are still counted? 

#
#     d. Enclose the condition from part a in a call to the `which` function,
#        and then use it to get the subset of all rows containing dogs that
#        need daily grooming. Now how many rows are there? Does the number of
#        rows agree with the count in part c?
#       [code completion + comprehension]
need_daily <- which (dogs$grooming=="daily")
need_daily
#There are now 23 rows which agrees with the count in part C (Rows 10,23,28,30,
#32,38,44,46,60,61,62,64,66,67,70,71,75,79,80,86,95,113,114)

# 9. Compute a table that shows the number of dogs in each grooming category
#    versus size. Does it seem like size is related to how often dogs need to
#    be groomed? Explain your reasoning. [code completion + interpretation]

table(dogs$grooming, dogs$size)

#It seems that size isn't really related to how often dogs need to be groomed.
#I say this because weekly has similar amounts for all sizes of dogs, so I 
#think that the it doesn't really depend on size. Maybe it relates more to the
#breed of dog due to their fur, rather than size. 

# 10. Compute the number of dogs in the `terrier` group in two different ways:
#
#     a. By making a table from the `group` column. 
#       [code completion + comprehension]

table(dogs$group=="terrier")
#28 is TRUE, meaning there's 28 that are true to be terriers in the group column
#FALSE means that 144 of them are not terriers
#
#     b. By getting a subset of only terriers and counting the rows.
#       [code completion + comprehension]

dogs[dogs$group=="terrier",]
terriers <- dogs[dogs$group=="terrier",]


#Number of rows is 28
#global environment shows 28 obvs of 18 variables


#
#     c. Computing the table is simpler (in terms of code) and provides more
#        information. In spite of that, when would indexing (approach b) be more
#        useful? [comprehension + interpretation]

#Indexing would be more useful if we wanted to see the specific data related 
#to terriers. The return information showed all the other columns so it'd be
#useful if we wanted to take a quick look at how all terriers behave from this 
#dataframe and if we can spot any quick similarities. 
