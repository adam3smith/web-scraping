---
title: Scraping a Single Page
description: Starting with just one...
layout: default
---
* Let's begin by scraping information from a single page:
https://www.parliament.uk/biographies/commons/ms-diane-abbott/172
* Let's try to get the contact name, constituency, party, email, website and social media information, and when they were first elected.
* We begin by loading the page:
`page <- read_html("https://www.parliament.uk/biographies/commons/ms-diane-abbott/172")`
* We can use the selector gadget to find a good CSS selector for the name  `h1`.
Using this with our R functions:
`name <-page%>% html_nodes("h1") %>% html_text(trim = TRUE)`

* We can look at this simply by using `name`.

## Exercise
Scrape and create variables for:
* constituency
* party

If we look at the CSS selector for email using our gadget, that looks really messy! In those situations, it's often good to use "Inspect Element" in your browser and construct the CSS by hand.


  
   
  **[Go to the next page](looping-multiple-pages)**
