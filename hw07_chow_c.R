#scraping while moving through all pages in the Features section
#working code that implements the "next" button process implemented in reader
library(httr)
library(jsonlite)
library(xml2) #parsing
library(rvest)

#Part 1: seeing where code went wrong
#copying from reader
url = "https://theaggie.org/category/features/"
doc = read_html(url)

xml_find_all(doc, "//div[contains(@class, 'td_block_inner')]") #vague, in developer
#tools it just gives different blocks throughout the page (tdi 55, tdi 56, some 
#just random blocks on the page). Should be more specific in what we want to 
#scrape

div = xml_find_all(doc, "//div[@id = 'tdi_113']") #ERROR=TDI should be 74 instead of 
#113 since 74 is the body area that contains all the articles (excluding ads) 
#from using developer tools. so we'll be able to find the links within that body.
#Also div gives list of 0 when we use 113 since the website has changed 
links = xml_find_all(div, ".//a")
length(links) #gives 0 since the code is still looking at tdi_113 so it's just 
#looking at the bottom grey portion according to the developer tools. It shows
#up as the "advertising" text part on that grey portion. 

links = xml_find_all(div, ".//h3/a")
length(links) #Still getting 0 for now the titles; when looking on the actual 
#page, tdi_113 is the grey bottom portion so there is no links or titles to recognize

feature_urls = xml_attr(links, "href") #says character(empty) because it still
#sees there's 0 links

parse_article_links = function(page) {
  div = xml_find_all(page, "//div[@id = 'tdi_113']")
  links = xml_find_all(div, ".//h3/a")
  xml_attr(links, "href")
} #This function won't work in our case since it's still focusing on tdi_113.
#The links and xml attr parts work since it's looking at the specific a tags,
#h3 tag, and href in order to get the links, but it won't work since we are 
#telling it to use tdi_113 which doesn't contain any of the article links we
#want

sports = read_html("https://theaggie.org/category/sports")
sports_urls = parse_article_links(sports) #gives output of 0 still because
#if applying same function to Sports, it also leads to the same grey portion
#at the bottom of the website where there's no articles or links. The head shows
#character (0) too which shows that the function is running but we aren't giving
#it the right location so to say to look at
head(sports_urls)

nav = xml_find_all(doc, "//div[contains(@class, 'page-nav')]")
next_page = xml_find_all(nav, ".//a[contains(@aria-label, 'next-page')]")

parse_article_links = function(page) {
  # Get article URLs
  div = xml_find_all(page, "//div[@id = 'tdi_113']") #Error=still using tdi_113
  links = xml_find_all(div, ".//h3/a")
  urls = xml_attr(links, "href")
  
  # Get next page URL
  nav = xml_find_all(page, "//div[contains(@class, 'page-nav')]")
  next_page = xml_find_all(nav, ".//a[contains(@aria-label, 'next-page')]")
  next_url = xml_attr(next_page, "href")
  
  # Using a list allows us to return two objects
  list(urls = urls, next_url = next_url)
}

last_page = read_html("https://theaggie.org/category/features/page/187/")
parse_article_links(last_page) #urls gives output of character(0) so our code
#still isn't right since we should be getting 15. It also gives next url as 
#page 188 since the website has updated and there is now 200 pages on Features
#but regardless since we are still using tdi_113, it won't recognize the actual
#body of articles that we've seen from developer tools 

parse_article_links = function(page) {
  # Get article URLs
  div = xml_find_all(page, "//div[@id = 'tdi_113']") #still using wrong tdi #
  links = xml_find_all(div, ".//h3/a")
  urls = xml_attr(links, "href")
  
  # Get next page URL
  nav = xml_find_all(page, "//div[contains(@class, 'page-nav')]")
  next_page = xml_find_all(nav, ".//a[contains(@aria-label, 'next-page')]")
  if (length(next_page) == 0) {
    next_url = NA
  } else {
    next_url = xml_attr(next_page, "href")
  }
  
  # Using a list allows us to return two objects
  list(urls = urls, next_url = next_url)
}

url = "https://theaggie.org/category/features/"
article_urls = list()
i = 1

# On the last page, the next URL will be `NA`.
while (!is.na(url)) {
  # Download and parse the page.
  page = read_html(url)
  result = parse_article_links(page)
  
  # Save the article URLs in the `article_urls` list. The variable `i` is the
  # page number.
  article_urls[[i]] = result$url
  i = i + 1
  
  # Set the URL to the next URL.
  url = result$next_url
  
  # Sleep for 1/30th of a second so that we never make more than 30 requests
  # per second.
  Sys.sleep(1/30)
} 
#When I ran this portion of code, it was taking a while so after 3 minutes I 
#stopped it, but it gave me a list of 104 in my global environment, but when 
#I clicked on it to view them, all of them were character(0) since yes it is 
#going through each page and getting the links since we're doing a while loop
#with iterations, but it's still overall looking at the wrong ID attribute, 
#tdi_113. In the second part, I changed it to look at tdi_74 and the code was
#able to work. The code's breakage starts with looking at the wrong id and since
#we include it in our functions, it's scraping links from basically nonexistent 
#articles which is why we constantly get 0 for length or character(0) for values. 

-------------------------------------------------------------------------------
#Part 2: fixing the code #!na=not na not last page
url="https://theaggie.org/category/features/"
class(url)
page=read_html(url)
page

div = xml_find_all(page, "//div[@id = 'tdi_74']") #fixed to 74 so it's body of
#articles. When using developer tools (on the first page), it highlights all
#the articles and excludes the advertisements, so we are now looking at the right
#id. 
links = xml_find_all(div, ".//h3/a") #still looking at the a tag and then h3 tag
#in order to look at links and the titles, respectively. 
length(links) #shows 15 links now for first page since there's 15 articles per 
#page
featured_urls = xml_attr(links, "href") #looking at HREF since it's link to 
#another page, the article
head(featured_urls) #lists the first 6 links
length(featured_urls) #shows featured articles has a length of 15, as there is
#15 on the first page of Features

parse_article_links_corrected = function(page) {
  div = xml_find_all(page, "//div[@id = 'tdi_74']")
  links = xml_find_all(div, ".//h3/a")
  featured_urls = xml_attr(links, "href")
} #makes a downloaded page and output should be links according to reader. 
#adding the div looks at the developer tools section we found, the article bodies, 
#links looks at the a tags and subsequently the titles, then featured urls
#looks at the href attribute which when used with the previous links object
#and xml, gives us those 15 links for the 15 featured articles on the first page

sports = read_html("https://theaggie.org/category/sports/")
sports_urls = parse_article_links_corrected(sports)
length(sports_urls) #gives output of 15 so we know it's correct since first page
#of the sports category has 15 articles
head(sports_urls) #gives the first 6 links to the articles on the sports page
#and I looked at the actual Sports page and they match


#now get the next pages
nav = xml_find_all(doc, "//div[contains(@class, 'page-nav')]")
next_page = xml_find_all(nav, ".//a[contains(@aria-label, 'next-page')]")
#nav and next page are the process for using the next button. From developer 
#tools, when I hover over the button, it shows the little arrow itself
#contains "page-nav-icon", so we need to include that in the xml. We first
#make sure class page-nav is included then also the attribute of aria-label 
#in a div with that class, so the code knows we want to include the process
#of going to the next page within Features
if(length(next_page)==0){
  next_url=NA
} else {
  next_url=xml_attr(next_page,"href")
} #adding an if statement to the function to check if NA's are needed if the next
#page doesn't have any articles (last page) and we'd get NA for the next URL


parse_article_links_corrected = function(page) {
 div = xml_find_all(page, "//div[@id = 'tdi_74']") #still making sure we're 
 #using the correct tdi number to look at the articles
  links = xml_find_all(div, ".//h3/a")
  urls= xml_attr(links, "href") 
  nav=xml_find_all(page,"//div[contains(@class,'page-nav')]")
  next_page=xml_find_all(nav,".//a[contains(@aria-label,'next-page')]")
  if(length(next_page)==0){
    next_url=NA
  } else {
    next_url=xml_attr(next_page,"href")
  }
  
  # Using a list allows us to return two objects
  list(urls = urls, next_url = next_url)
}

last_page = read_html("https://theaggie.org/category/features/page/3/")
last_page #just testing my function works, I used page 3 
cat = parse_article_links_corrected(last_page)
cat #assigned to object in order to see the output
length(cat)

last_last_page=read_html("https://theaggie.org/category/features/page/200/")
test= parse_article_links_corrected(last_last_page)
test #testing it works for last page too. It gives us 9 links since page 200
#only has 9 articles and next_url returns as NA since there's no more pages
#in Features left to scrape




#Trying to get first 5 pages now: 
url = "https://theaggie.org/category/features/" 
url_with_page <- paste(url,"page/",sep="") #using paste because I saw that on
#the features page, the first page only has /features/ but pages 2,3,4,5 all have
#features/page/number so I wanted to make sure that was going to happen with 
#the pages that needed it
article_urls = list()
i = 1

while (i < 6){ #using i <6 because it'll count i=0,1,2,3,4,5 which is the first
  #5 pages 
 
  if (i > 1) { #I added an if loop because I want to make sure that the pages
    #besides the first all have the /page/number format. Since it's specifically
    #different for just the first page and I tried not using the loop but 
    #entering the URL into google gave me 404 errors since for pages 2,3,4,5 
    #it was missing the features/page/# needed
    new <- paste(url_with_page,i,sep="") #for pages 2,3,4,5 I want to add the 
    #/features/page/#
    page = read_html(new)
    print(new)
  } else { #for just the first page leave it alone as category/features/
    page = read_html(url)
    print(url)
  }
 
  # Download and parse the page.
  page = read_html(url)
  result = parse_article_links_corrected(page)
  
  # Save the article URLs in the `article_urls` list. The variable `i` is the
  # page number.
  ##   article_urls[i] = result$url
  #article_urls[1][2]
  #I added a for loop since for every url add it to article_urls
  #Also I added apend because I wanted to add the articules_url and link to 
  #the vector so that way articles_url is getting all 75 links. The issue before
  #was that articles_url kept saying only 5 and they were the first article on
  #each of the featured pages but it said [15] so it was as if the rest of the 
  #articles was "stuck" within those 5 "titles". Adding this allowed me to see
  #all 75 in the global environment (I used R Studiodocumentation.org to find/use
  #this function)
  for(link in result$url) {
    article_urls <- append(article_urls, link)
  }
  i = i+1 
 
  
  # Set the URL to the next URL.
  url = result$next_url

  Sys.sleep(1/30)
}

#I understand I used a lot of added functions not in the reader but I spent 4 hours
#trying to fix this section so I used a lot of past course readers + stack
#overflow trying to make it work. My problem at first was that article_urls
#kept giving me only 5 items, but each article_url [] contained the 15
#so it was somewhat hiding it? Or more so compressing it. So I had to add all
#these if, else, and for loops in order to break it up and show all 75. 

