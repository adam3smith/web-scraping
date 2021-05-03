---
title: Looping through Multiple Pages
description: Now we're talking!
layout: default
---
## Getting the URLs
* Let's first find the CSS to give us all the MPs from  https://assembly.state.ny.us/mem/ : `.mem-name a`

Again, we're lucky! This is very clean

* We now load this page into R:
```
directory <- read_html("https://assembly.state.ny.us/mem/")
```
* And then extract a list of a legislators.
```
leg_urls <- directory %>% html_nodes(".mem-name a")
```
Note that we use `html_nodes` (with nodes in the plural) here, since we want all 150 members.

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
assembly <-data.frame(stringsAsFactors = F)
```
* This just creates an empty table called `assembly`. The bit in parentheses makes sure that what we scrape gets stored as regular text.
* The only thing left now is to write the values to this table every time we're at the end of the loop.
* There's a trick to this: first we convert the values to a table with just one row:
```
results <- data.frame(name, district, email, biography)
```

### Converting to a functions
We could just move our whole code for scraping an individual page into the loop we constructed, but that would make troubleshooting harder (e.g. if we want to test on a single page). Instead, we use an R `function` that we'll call scrape. It will take one "argument", namely a URL for an Assembly Member's webpage, and the return a one-row data frame with the MP's info.

```
scrape <- function(url) {}
```
We place all of our code into this function. At the end we need to say what the function "returns", i.e. our one-line data frame `results`: `return (results)`

```
scrape <- function(url) {
  page <- read_html(url)

  name <-
    page %>% html_node('#head-mem-name') %>% html_text(trim = TRUE)
  district <-
    page %>% html_node('#head-mem-dist') %>% html_text(trim = TRUE)

  bioUrl <- paste0(url, "bio")
  bioPage <- read_html(bioUrl)
  biography <-
    bioPage %>% html_node('#biotext') %>% html_text(trim = TRUE)

  contactUrl  <- paste0(url, "contact")
  contactPage <- read_html(contactUrl)
  email <-
    contactPage %>% html_node('.member-email') %>% html_text(trim = TRUE)
  results <- data.frame(name, district, biography, email)
  return (results)
}
```

### Exercise
* Look at the second line of the function. What do you think is going on there?


* Then we can plug this function into a command called `rbind`
```
assembly <-  rbind(assembly, scrape(url))
```

## Troubleshooting

* Did this run on your first try? What could be going wrong? 

  **[Go to the next page](cleaning-data)**
