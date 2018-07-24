---
title: Looping through Multiple Pages
description: Now we're talking!
layout: default
---
## Getting the URLs
* Remember that we already found the CSS that gives us all the house representatives listed on https://www.legislature.ohio.gov/legislators/legislator-directory :
`#houseDirectory a`.
* We now load this page into R:
```
read_html("https://www.legislature.ohio.gov/legislators/legislator-directory")
```
* And then extract a list of a legislators.
```
leg_urls <- directory %>% html_nodes("#houseDirectory a")
```
### Exercise
We want the URL to their homepages, not their name. Can you figure out how to get that?

## Looping through URLs
* When you have a list with multiple elements, R allows you to easily loop through it using `for (element in list){}`. So in our case we want to use
```
for (url in leg_urls) {}
```
* Note those curly brackets? These go around all the code that we've previously written for a single page.
* This code will now cycle through all URLs and extract the same elements. But it won't actually write them down!

* For this we first create a table *outside* of our loop. Data tables in R are called data frames.
```
legislators <-data.frame(stringsAsFactors = F)
```
* This just creates an empty table called legislators. The bit in parentheses makes sure that what we scrape gets stored as regular text.
* The only thing left now is to write the values to this table every time we're at the end of the loop.
* There's a trick to this: first we convert the values to a table with just one row:
```
new_row <- data.frame(address, background, committees, biography)
```
* Then we use a command called `rbind` to add them to our existing table:
```
legislators <-  rbind(legislators, new_row))
```

## Troubleshooting

* Let's run this script... uh-oh that doesn't seem to work. What do you think is going wrong?

  **[Go to the next page](cleaning-data)**
