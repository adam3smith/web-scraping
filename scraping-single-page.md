---
title: Scraping a Single Page
description: Starting with just one...
layout: default
---
* Let's begin by scraping information from a single page:
http://www.ohiohouse.gov/scott-wiggam
* Let's try to get the contact information, background, biography, and committee memberships
* We begin by loading the page:
`page <- read_html("http://www.ohiohouse.gov/scott-wiggam")`
* A good CSS selector for contact and background is `.contactModule .data`.
Using this with our R functions:
`contact <-page%>% html_nodes(".contactModule .data") %>% html_text(trim = TRUE)`

* We can look at this simply by using `contact`.
* It looks like we have text from two nodes, so how can we select one? R's command for this is a bit weird: `[[(1)` will select the first node, etc. So
```
contact <-page%>% html_nodes(".contactModule .data") %>% html_text(trim = TRUE) %>% `[[(1)`
```

will select the first of these and `[[(2)` the second.

## Exercise
Scrape the page by creating the following  variables
* address (with the contact info)
* background
* committees
* biography
  
   
  **[Go to the next page](/looping-multiple-pages)**
