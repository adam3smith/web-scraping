---
title: "Data munging" -- Cleaning up Your Import
description: From messy to tidy data
layout: default
---

## Cleaning Data
* We'll want to clean up our data a bit more and prepare it for analysis


## Regex Basics
* We'll use a little bit of  tool called "regular expressions" or "regex"
* Regular expressions turn you into a superhero:
![XKCD: Regular Expressions](https://imgs.xkcd.com/comics/regular_expressions.png)
* We will (again) only cover the basics. There's a cheatsheet e.g. here: https://www.cheatography.com/davechild/cheat-sheets/regular-expressions/

* A dot serves as a wildcard: t.p matches tip, top, tap, t3p, t-p, etc.
* A + means "repeat one or more time". So but+er matches buter, butter, buttter, etc.
  * The + operator stops matching at line breaks
  * You will often see `.+`, i.e. match everything until the end of the line
* `*` works almost like +, but matches *zero* or more times. So but*er matches buer, buter, butter, etc.
* \\d matches any digit
* \\s matches a space
* parentheses around parts of a regex let you select what's matched by the parentheses separately.
* `^` denotes the beginning of a line and $ it's end.

## Regex in R
* In R, regex are implemented in the `stringr` package. Most importantly the function `str_match(string, "regex")`. An analogus function is `str_remove(string, "regex")` which removes a pattern from a string.

* Let's go back to our individual pages and convert the range of first office holding into the year the representative first one office. We'll want to extract the first year from a string like "Jun 1987 - Mar 2015". We'll do this by finding four consecutive digits, and then picking the first of those:
```
firstElection <- str_match(firstElection, "\\d{4}" ) %>% `[[`(1)
```
We can use this to create a new variable called `tenure` to show how long they've been in parliament.

```
tenure <- 2019 - as.numeric(as.character(firstElection))
```
But this is just for a single value. The `dplyr` package has a terrific function for making our lives easier and apply this to the whole dataset:

```
mps <- mps %>% mutate(firstElection = str_match(firstElection, "\\d{4}") %>% `[[`(1))
mps <- mps %>% mutate(tenure = 2019 - as.numeric(as.character(firstElection)))
```

### Exercise
Can you remove the MP from the end of the names variable?
Some websites have three ... at the end. Can you remove those?


Finally, we'll want to add binary variables for whether an MP lists a Twitter account, website, and Facebook page. We can use a function called `ifelse(condition, valueIfTrue, valueIfFalse)`. Combined with mutate, this gives us:
```
mps <- mps %>% mutate(hasTwitter = ifelse(!is.na(twitter), "1", "0"))
```

### Exercise
Can you do the same for Facebook and websites?

## The Finished Code

There are, of course, many ways to do this. [Here is the finalized script](UK-commons.R)

## Analysis

What sorts of analyses could we run with this data?
