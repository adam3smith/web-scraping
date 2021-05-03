---
title: Scraping a Single Page
description: Starting with just one...
layout: default
---
* Let's begin by scraping information from a single page:
[https://nyassembly.gov/mem/Khaleel-M-Anderson](https://nyassembly.gov/mem/Khaleel-M-Anderson)
* Let's try to get the name, district, email, and biography
* We begin by loading the page:
`page <- read_html("https://nyassembly.gov/mem/Khaleel-M-Anderson")`
* We can use the selector gadget to find a good CSS selector for the name  `#head-mem-name`.
Using this with our R functions:
`name <-page%>% html_node("#head-mem-name") %>% html_text(trim = TRUE)`

* We can look at this simply by using `name` in R

## Exercise
Scrape and create variables for:
* district
* Think about how you'd get the email and biography. Make sure to look at multiple pages.

You'll have noticed that the bibliography isn't always on the front page, and the email never is, so we'll need to move somehwere else. Fortunately, it turns out that they always are on the same subpage, so we load those up and then scrape the information from there:

```
# Load contact page
contactUrl  <- paste0(url, "contact")
contactPage <- read_html(contactUrl)

# load bio page
bioUrl <- paste0(url, "bio")
bioPage <- read_html(bioUrl)
```

## Exercise
Scrape and create variables for:
* email
* bio
  

   
  **[Go to the next page](looping-multiple-pages)**
