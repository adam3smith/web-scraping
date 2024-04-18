---
title: Our R environment – the tidyverse
description: Ceci n'est pas une pipe
layout: default
---

## The tidyverse
* Within R, we're going to be using a set of packages that are part of what is called the "tidyverse". These used to be distinguished by a special symbol called a "pipe": `%>%`. The tidyverse pipe was so successful that the same functionality is now available in "base R" -- it just looks slightly differently: `|>`.
How does the pipe work? It passes whetever is on the left side of the pipe as the first argument to the right side of the pipe:
- If we want to combine two strings, we can use `paste0("Data", "Science)`. With a pipe, we can write the same thing as `"Data" |> paste0("Science")`
   * If this isn't completely clear, don't worry about it. The example later on make this very intuitive.

## Setting up our R environment
Let's load up some helpful packages:

```
library(rvest) # the basic scraping library
library(dplyr) # a key part of the "tidyverse" that helps us manipulate Data
library(stringr) # a useful library that helps us clean up scraped text
```

You might need to install these packages if you don't have them.
  
## R's webscraping commands
* Within R, webscraping is best done with a package called `rvest`
* Here are the functions you need to know:
  * `read_html(url)` will read a webpage into memory from the given url
  * `html_node(page, css selector)` will return the *first* node of a given page matched by the CSS selector.
  * `html_nodes(page, css selector)` works identically to `html_node` but selects *all* nodes matched by the css selector
  * `html_text(node)` extracts all text from a nodes
  * `html_attr(node, attr)` extracts the content of a given attribute from a node.
  * `html_table(node)` extracts an entire table into an R data frame
  
  **[Go to the next page](scraping-single-page)**
