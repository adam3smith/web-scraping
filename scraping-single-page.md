---
title: Scraping a Single Page
description: Starting with just one...
layout: default
---
* Let's begin by scraping information from a single page:
[https://www.parliament.uk/biographies/commons/ms-diane-abbott/172](https://www.parliament.uk/biographies/commons/ms-diane-abbott/172)
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

If we look at the CSS selector for email using our gadget, that looks really messy! In those situations, it's often good to use "Inspect Element" in your browser and construct the CSS by hand. If we do that, we see `data-generic-id="email-address"` one level up. That looks much better! How do we construct this into a CSS selector? We select by an attribute and its value using `[data-generic-id="email-address"]` so
We can paste this into the CSS selector gadget and hit return and it shows us the part of the page that is selected. That still includes the "Email:" label. If we look using "Inspect" again, we can see that the actual email is in a child element `a` if we add this to our selector we get `[data-generic-id="email-address"] a` -- that works perfectly!
`email <- page %>% html_nodes('[data-generic-id="email-address"] a') %>% html_text(trim = TRUE)`


## Exercise
Scrape and create variables for:
* website
* twitter
  
The last bit is a bit harder. Try and figure out how to get to just the first period she was in office, "Jun 1987 - Mar 2015".

This is quite hard! The approach that we take is to first find the table that contains the electoral history: `#electoral-history` within that table, we select the last row:
`#electoral-history tr:last-of-type` and within that row, we select the cell (`td`) with the class `biography-electoral-history-date`. So all together `#electoral-history tr:last-of-type td.biography-electoral-history-date`

`firstElection <- page %>% html_nodes('table#electoral-history tr:last-of-type td.biography-electoral-history-date') %>% html_text(trim = TRUE)
`
   
  **[Go to the next page](looping-multiple-pages)**
