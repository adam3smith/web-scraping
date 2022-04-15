---
title: Data munging – Combining Multiple data source
description: From messy to tidy data
layout: default
---

## Getting more data
* Something very important is missing! We can't actually tell the party of our Assembly Members. Let's find this information somewhere else: https://ballotpedia.org/New_York_State_Assembly

### Exercise
* Can you figure out how to get that table straight into R without having to scrape every row? Let's call this `bpTable`
  * Hint: check back into the [set of rvest commands](first-steps-r)

## Combining the data frames

We can now merge the two datasets. The best variable for this is going to be the district, but first we'll need to make sure it is the same in both data frames. For that, we need to
1. remove the "New York State " in front of the district and
2. Rename the variables

For 1), there's a nifty command `str_remove()` in the `stringr` package:
```
bpTable$Office <- bpTable$Office %>% str_remove("New York State ")
```

For 2), there are a ton of ways to do this. The `dplyr` package has a particular useful one, called `rename`. While we're using this, let's give the other variable useful names, too:
```
bpTable <-
  bpTable %>% rename(district = Office,
                     memberSince = `Date assumed office`,
                     party = Party)
```

We can now merge the two:
```
fullAssembly <- merge(assembly, bpTable, by = "district")
```

* We have an interesting variable `memberSince` that tells us when someone joined the Assembly. Can you get the average year people joined?
* Turns out we need to clean that column up for it to be useful. For this we turn to:

## Regex Basics
* We'll use a little bit of  tool called "regular expressions" or "regex" to further clean the data
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
* a number in curly brackets matches n times the preceding element, so `a{4}` matches aaaa.
* parentheses around parts of a regex let you select what's matched by the parentheses separately.
* `^` denotes the beginning of a line and $ it's end.

## Regex in R
* In R, regex are implemented in the `stringr` package. Most importantly the function `str_match(string, "regex")`. An analogous function is `str_remove(string, "regex")` (we've already used that) which removes a pattern from a string, and `str_extract(string, "regex")` which allows us to extract one part of a string quickly.

## Cleaning the memberSince variable
### Exercise
* We'll be OK with some loss of precision and simply extract the year from the memberSince column and turn it into a new variable, `yearSince`
How would you go about doing that?




## Analysis

What sorts of analyses could we run with this data?

**[Go to the next page](data analysis)**
