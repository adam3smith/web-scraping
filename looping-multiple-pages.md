---
title: Looping through Multiple Pages
description: Now we're talking!
layout: default
---
## Getting the URLs
* Let's first find the CSS to give us all the MPs from  https://www.parliament.uk/mps-lords-and-offices/mps/ : `td:nth-child(1) a`

Again, this turns out to be tricky, because we get the

* We now load this page into R:
```
directory <- read_html("https://www.parliament.uk/mps-lords-and-offices/mps/")
```
* And then extract a list of a legislators.
```
leg_urls <- directory %>% html_nodes("td:nth-child(1) a")
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
mps <-data.frame(stringsAsFactors = F)
```
* This just creates an empty table called `mps`. The bit in parentheses makes sure that what we scrape gets stored as regular text.
* The only thing left now is to write the values to this table every time we're at the end of the loop.
* There's a trick to this: first we convert the values to a table with just one row:
```
results <- data.frame(name, constituency, party, email, firstElection, website, twitter, facebook)
```
### Converting to a functions
We could just move our whole code for scraping an individual page into the loop we constructed, but that would make troubleshooting harder (e.g. if we want to test on a single page). Instead, we use an R `function` that we'll call scrape. It will take one "argument", namely a URL for an MP's webpage, and the return a one-row data frame with the MP's info.

```
scrape <- function(url) {}
```
We place all of our code into this function. At the end we need to say what the function "returns", i.e. our one-line data frame `results`: `return (results)`

```
scrape <- function (url) {
  page <- read_html(url)
  name <- page %>% html_nodes('h1') %>% html_text(trim = TRUE)
  constituency  <- page %>% html_nodes('#commons-constituency') %>% html_text(trim = TRUE)
  party <-  page %>% html_nodes('#commons-party') %>% html_text(trim = TRUE)
  email <-  page %>% html_nodes('[data-generic-id="email-address"] a') %>% html_text(trim = TRUE)
  website <-  page %>% html_nodes('[data-generic-id="website"] a') %>% html_text(trim = TRUE)
  twitter <-  page %>% html_nodes('[data-generic-id="twitter"] a') %>% html_text(trim = TRUE)
  facebook <- page %>% html_nodes('[data-generic-id="facebook"] a') %>% html_text(trim = TRUE)

  firstElection <- page %>% html_nodes('table#electoral-history tr:last-of-type td.biography-electoral-history-date') %>% html_text(trim = TRUE)

  results <-data.frame(name, constituency, party, email, firstElection, tenure, website, twitter, facebook)
  return (results)
  
}
```

* Then can plug this function into a command called `rbind` (that's for "row bind") to add them to our existing table:
```
mps <-  rbind(mps, scrape(url))
```

## Troubleshooting

* Let's run this script ... uh-oh that doesn't seem to work. What do you think is going wrong?

  **[Go to the next page](cleaning-data)**
