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


# 1. All of the questions in this homework use the Best in Show data set. 
#      The data is the file `dogs.rds`.
#   a. Load the data set and use R functions to inspect the number of 
#      columns, number of rows, names of columns, and column data types.
#      [code completion + comprehension]
setwd("/Users/charlottechow/sts115_cchow")
dogs = readRDS("dogs.rds")

ncol(dogs)
nrow(dogs)
colnames(dogs)
str(dogs)

#number of columns=ncol
#number of rows=nrow
#names of columns=colnames
#column data type=str
#str shows the type (num, factor, int, chr) for each column and it shows
#a preview of the first few observations. I was going to use class() but then 
#it just showed "dataframe" for dogs as a whole and not each columns. 

#   b. Make a scatter plot that shows the relationship between height and
#      weight. In 2-3 sentences, discuss any patterns you see in the plot.
#      [code completion + comprehension + interpretation]
library(ggplot2)
ggplot(dogs) +
  aes(x=height, y=weight)+
  geom_point()

#A pattern I see in the plot is a bit of a positive relationship--as height 
#increases, so does weight. The scatter points increase when height is at 20
#and weight is near 150. 

#   c. Set the color of the points in the scatter plot from part b to a single 
#      color of your choosing. (Tip: Choose a color from one of the sites 
#      shared in the lesson (e.g. https://coolors.co/palettes/trending))
#      [code completion + comprehension]
ggplot(dogs) +
  aes(x=height, y=weight)+
  geom_point(color="#a2d2ff")
#Put the color in geom_point instead of aes. If put in aes, then it makes it 
#a new column called a2d2ff and assigns it that color rather than making the
#points that specific color. 


# 2.
#   a. Make a bar plot that shows the number of dogs in each "group" of dogs.
#      [code completion + comprehension]
ggplot(dogs)+
  aes(x=group)+
  geom_bar()

table(dogs$group)
#Checking all the types of groups were included in the graph with the table 
#function
#Use geom_bar instead of point to make it a bar graph rather than scatter

#   b. Are any groups much larger or smaller than the others? Describe what your 
#       visualization shows.
#      [interpretation]
#The two groups that seem smaller than the others are nonsporting and toy, they 
#both seem to be the same amount in terms of height of bar and look below 20 count. 
#The two tallest seem to be sporting and terrier and have the same tallest height
#(Above above 20 and maybe around 25). 
#From this chart, I'm able to see that there are more sporting and terrier dogs
#in the group, while there are less of the non-sporting and toy.
#The bars all have the same width but looking at the heights let me see
#the results about non-sporting/toy and sporting/terrier.


#   c. Fill in the bars based on the size of the dog, and set the position 
#       argument of the bar geometry to the one you think best communicates the 
#       data. Explain why you chose this position.
#      [code completion + comprehension + interpretation]
ggplot(dogs)+
  aes(x=group)+
  geom_bar(aes(fill=size), position="identity")
#I kept the default position="identity" because I think the graph looks better
#with being stacked so it's easier to see. Using "dodge" made the graph more
#smushed and harder to read since there was so many bars right next to each
#other. In identity, I think it's easier to look at the legend and correspond
#the color to the stacked bars (and the legend of size also helps)  


# 3.
#   a. Which geometry function makes a histogram? Use the ggplot2 website or
#      cheat sheet to find out.
#      [code completion + comprehension]
#The geometry function that makes a histogram is geom_histogram().
ggplot(dogs) +
  aes(x=height)+
  geom_histogram()
#only one variable in the aes used

#   b. Make a histogram of longevity for the dogs data. How long do most dogs
#      typically live? Explain in 1-2 sentences.
#      [code completion + comprehension + interpretation]
ggplot(dogs)+
  aes(x=longevity)+
  geom_histogram(binwidth=1)
#Dogs typically live for about 12.5 years according to the histogram. The graph
#shows that 12.5 has the highest peak, which means that most of the dogs in 
#the data live for that amount. 

#   c. Inside the geometry function for histograms, play around with the bins
#      argument. (e.g. bins = 10, bins = 50). What do you think this is doing?
#      [code completion + comprehension]
ggplot(dogs)+
  aes(x=longevity)+
  geom_histogram(binwidth=30)
#When making the binwidths larger, it makes the width of each bin larger.
#Binwidth 30 makes it look like half of the chart is one giant rectangle. I 
#think that increasing the number makes it more difficult to see which 
#bin applies to the section of the x axis and therefore the longeivty's of the 
#dogs. 

# 4.
#   a. Modify your plot from Question 1 so that the shape of the points is
#      determined by the "group" of the dog. [code completion + comprehension]
ggplot(dogs) +
  aes(x=height, y=weight, shape=group)+
  scale_shape_manual(values=c(0,1,2,3,4,5,6))+
  geom_point()
#   b. Do height and weight effectively separate the different groups of dogs?
#      In other words, are there clear boundaries between the groups in the
#      plot (as opposed to being mixed together)? Are some groups better
#      separated than others?
#      [interpretation]
#I think that the shapes effectively separate the different groups. We can 
#especially see the working dogs closer to the highest weight and height, since
#the upside down triangles are more spread out. I think that it's a bit harder
#to read the toy and non-sporting dogs though, as they're closer to the same
#height and weight areas in the plot so you have to look close to see which
#shapes are in those areas. Overall, I think it's helpful to have the groups
#correspond to specific shapes as it lets us read the graph and take a glance
#at that group's specific height and weight areas from the data. 

#   c. How might you improve the readability of this graph in order to visualize
#      this potential relationship more clearly?
#      [interpretation]
#I would also include color=group, just to help distinguish which is which 
#group easier. I tried it earlier and it helped make the shapes stand out
#and I was able to scan the graph easier with both color and shapes involved.

# 5. In a paragraph, answer the following questions for the “Best in Show” 
#    visualization (https://informationisbeautiful.net/visualizations/best-in-show-whats-the-top-data-dog/) 
#    that was built using the dogs dataset.
#    a. Who do you think is the intended audience for this data visualization? 
#        How do you think that could influence data collection, metrics calculations, 
#        and graphics choices?
#       [interpretation]
#I think the intended audience is for those who are maybe interested in getting
#a dog and want to know quick pros and cons for each type. At the top it shows intelligence
#and size, so people can quickly scan for dogs they are maybe interested in getting.
#It can also just be for people who are dog enthusiasts, since there's 4 
#categories of overrated, ignored, overlooked treasures, and hot dogs which 
#people may agree or disagree with. 

#    b. Who/what is included in this data visualization and who is left out? 
#        What do you think the impact of that decision could be on conclusions drawn
#        from viewers of the data visualization? 
#       [interpretation]
#In this data visualization, there are many types of dogs included. Those that
#are categorized as dumb, clever, small, medium, large, herding, hound, 
#non-sporting, sporting, terrier, toy, or working dogs. Those that are left out
#are maybe dogs who aren't part of those 7 last categories. I think there's also
#price left out, which would add more to this information to give readers more
#information about what each dog type is like. I think price being left out
#might cause readers to conclude maybe these dogs are all the same price since
#there's no differentiation listed. 

#    c. What could the potential impact of this visualization be on those 
#       who are left-out? [interpretation]
#The potential impact of this visuzliation on those who are left is that readers
#won't know there's even more dog types avaialble and that they have different 
#prices too. 


# 6. Select your favorite data visualization from https://viz.wtf/ 
# (that was not featured during class or in the reader). 
#   a. Type the direct url to the viz you selected here:
#https://viz.wtf/post/639589038118125568

#   b. Describe in a few sentences the "data story" you think that this visualization 
#       is trying to tell.
#I think the story that the visualization is trying to tell is the frequency
#of shoe colors among a certain population. 

#   c. In a paragraph, what makes this a "bad" visualization? Evaluate the visualization 
#       based on the visualization principles and perception rules discussed in class 
#       (i.e., Gestalt principles, plot type, accessibility, critical reading, etc.), 
#       and suggest a few changes to improve the graphic.
#This is a "bad" visualization because although it is a histogram that lets us 
#see that black is the most frequently worn shoe color in this population,
#the colors that the creator use are contradictory. All the colors they used 
#don't correspond to the color in the text, which can make it confusing to 
#viewers if they are quickly glancing at only the graph bars. 

#   d. Describe in 1-2 sentences one thing that this visualization actually already does well.
#One thing is visualization does well at is the binwidth of the bars. I'm able
#to clearly see which bin goes with which category on the x axis and can clearly
#tell that black shoe color is most frequent. 


# 7. Look at the plot posted with this assignment on Canvas.
#    a. Identify the marks and channels in this plot. Write them out for this answer
#scatterplot, geom_point; 
#Marks: the points of each different type of dog (0d)
#Channels: the visual variables such as the color of each point, the sizes,
#the 6 different shapes, and the vertical orientation of the graph. 

#    b. Write the code to generate this plot. (Hint: start with identifying the 
#        variables on each axis, then think about the types of channels).
ggplot(dogs)+
  aes(x=longevity, y=lifetime_cost, shape=group, color=group)+
  labs(title="Dogs")+
  xlab("Longevity (years)")+
  geom_point()

#    c. Propose 4 improvements to the plot based on best practices.
#1. Change the y label to match the x one (meaning we can change it to Lifetime
#Cost) rather than keeping that _ in
#2. Add the scale shape manual to make sure the working group has its own shape
#3. Change background and theme to make it less grey (theme_minimal)
#4. Can also change the title to explain more what the graph is visualizing--
#dogs is a bit too general

#    d. Modify the code to implement at least two of those changes.
ggplot(dogs)+
  aes(x=longevity, y=lifetime_cost, shape=group, color=group)+
  scale_shape_manual(values=c(0,1,2,3,4,5,6))+
  labs(title="Dogs")+
  xlab("Longevity (years)")+
  ylab("Lifetime Cost (in dollars)")+
  geom_point()

