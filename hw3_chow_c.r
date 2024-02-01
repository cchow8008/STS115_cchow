# This file contains homework questions for the lecture on 
# Control Structures and Functions.  Questions appear as comments 
# in the file.  Place your answers as executable code immediately 
# following the relevant question.


# QUESTION 1: Assign the value 3 to a variable "x" and write
# a conditional statement that test whether x is less than 5.  
# if it is, print "Yay!" to screen.

x <-3
if (x<5) {
  print("Yay!")
}

#keep everything in brackets to run

# QUESTION 2:  Create two variables "x" and "y" and assign 
# each a numeric value. Create a conditional statement that 
# tests whether the value of a variable "x" is equivalent 
# to the value of variable "y." If the values are equivalent, 
# print "The variables are equal" to screen. If they are not 
# equivalent, print "The variables are not equal" to screen.

x <- 8
y<-4

if (x==y) {
  print ("The variables are equal")
} else {
  print ("The variables are not equal")
}

#if x doesn't equal y, it goes to the else statement (not equal)

# QUESTION 3:  Duplicate the conditional code from above, but 
# change the logic of the conditional so that it tests for 
# conditions in which "x" IS NOT EQUIVALENT" to "y" and print 
# the appropriate message to screen accordingly.

x <- 8
y<-4

if (x!=y) {
  print ("The variables are not equivalent")
} else {
  print ("The variables are equivalent")
}

#!= means not equal 

# QUESTION 4:  Assign the boolean value TRUE to the variable "x", 
# and then create a conditional statement that tests whether the 
# value of a variable "x" is TRUE or FALSE. If the value is true, 
# print "X is true" to screen. If false print "X is false" to screen.

x<- TRUE

if (x){
  print ("X is true")
} else {
  print ("X is false")
}

#need to capitalize TRUE and FALSE for it to register correctly

# QUESTION 5: Write a "for" loop that iterates through the 
# values 1 to 10 and prints the iteration number to screen 
# during each loop.

for (i in 1:10) {
  print(i)
}

#print i means print the iteractions, so it'll print the 1:10

# Question 6: Assume that you want to create a loop that executes 
# exactly 10 times. Assign the value 1 to "x" and then write a "while" 
# loop that iterates based on a test of the value of "x" and for each 
# loop prints the value of "x" to the screen. 
#
# The printed output should look like:
#
# 1 2 3 4 5 6 7 8 9 10
#
# Note that depending on your browser the numbers may print to the same 
# line or each on a new line.

x <-1
while(x <= 10){
  print (x)
  x <- x +1
}

#need to add 1 so each time it'll add up to 10 in those 10 loops

# Question 7: Create a list or vector object that contains 
# the following values:
#
# Tesla, Nissan, Harley, Chevy, Indian, MG. 
# 
# Then write code that loops through each item in the list and
# prints the value to screen

y <-c("Tesla", "Nissan", "Harley", "Chevy", "Indian", "MG")
for (i in y){
  print (i)
}
  
#need to use print (i), it makes the iterations print separately
#i in y means iterations in those names


# Question 8: Write code that loops through each item in the list 
# object that you created for Question 3 above and, for each value,
# if the values is "Harley" or "Indian" print, "This is a motorcycle" 
# to screen. Otherwise print, "This is a car" to screen.

y <-c("Tesla", "Nissan", "Harley", "Chevy", "Indian", "MG")


for (i in y){
if (i=="Harley" | i=="Indian"){
  print ("This is a motorcycle")
} else {
  print ("This is a car")
}}

#need to do i== so it knows which ones you want, also need double brackets
#because of both if and else used

# Question 9: Assign the values 1-10 to a vector.  Then, loop through
# your vector and print each value to screen unless the value is 5.  (The
# final output of your process should be: 1 2 3 4 6 7 8 9 10)

v <- c(1,2,3,4,5,6,7,8,9,10)
for (i in v){
  if (i!=5)
  print (i)
}

#!= means doesn't equal 5, it'll take it out during the iteration

# QUESTION 10: Write a function that performs a simple math equation 
# with a variable. Run the function substituting the variable with 
# at least three different values by calling it in a loop. For 
# instance, if you write a function for a variable "x", Use a loop 
# call the function for at least three numbers as "x".

numbers <- c(4,15,1)

times3 <- function(n) {
  n*3}

for (i in numbers){
  print(times3 (i))
}

#order: i, times 3, print
#nesting--need to watch out for the order and which will start first
