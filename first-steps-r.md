---
title: First Steps in R
description: Understanding the very, very basics
layout: default
---

## What is R?
* R is a powerful programming language mainly used for statistical analysis and other data-related tasks
* R is open source and free to use
* R-Studio is a development environment that makes using R much, much easier.
* R itself provides basic functionality. Its functionality can be expanded to do (almost) anything using "packages"
* To use a package, you first need to install it (`install.packages("package")`). You only need to do this once.
* In every script where you want to use elements of a package, you need to load it using `library("package")`

## Basic commands
* The most important command in R is the assignment arrow, `<-`. This allows you to set a value or set of values to a variable as in `x <- 5`.
* You can `use alt+-`as a shortcut for the assignment arrow
* Within R, we're going to be using a set of packages that are part of what is called the "tidyverse". For those packages, the symbol `%>%` is of particular importance: it effectively passes an argument on from left to right, serving as the first argument of the next function. A example will help make this clear:
In `2 + 3 %>%  + 7` the 5 before the `%>%` gets passed on as the x, so the total is 12
   * If this isn't completely clear, don't worry about it. The example later on make this very intuitive.
  
## R's webscraping commands
* Within R, webscraping is best done with a package called `rvest`
* Here are the functions you need to know:
  * `read_html(url)` will read a webpage into memory from the given url
  * `html_node(page, css selector)` will return the *first* node of a given page matched by the CSS selector.
  * `html_nodes(page, css selector)` works identically to `html_node` but selects *all* nodes matched by the css selector
  * `html_text(node)` extracts all text from a nodes
  * `html_attr(node, attr)` extracts the content of a given attribute from a node.
  
  **[Go to the next page](scraping-single-page)**
