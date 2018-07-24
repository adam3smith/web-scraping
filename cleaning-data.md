---
title: "Data munging" -- Cleaning up Your Import
description: From messy to tidy data
layout: default
---

## Cleaning Data
* The data as we have it now is not terribly appealing. It's in big blocks; there is a lot of "noise in it"
* We now take these blocks and extract cleaned-up data from it.
* For this we use a tool called "regular expressions" or "regex"
* Regular expressions turn you into a superhero:
![XKCD: Regular Expressions](https://imgs.xkcd.com/comics/regular_expressions.png)
* We will (again) only cover the basics. There's a cheatsheet e.g. here: https://www.cheatography.com/davechild/cheat-sheets/regular-expressions/

## Regex Basics
* A dot serves as a wildcard: t.p matches tip, top, tap, t3p, t-p, etc.
* A + means "repeat one or more time". So but+er matches buter, butter, buttter, etc.
  * The + operator stops matching at line breaks
  * You will often see `.+`, i.e. match everything until the end of the line
* `*` works almost like +, but matches *zero* or more times. So but*er matches buer, buter, butter, etc.
* \\d matches any digit
* \\s matches a space
* parentheses around parts of a regex let you select what's matched by the parentheses separately.
* `^` denotes the beginning of a line.  

## Regex in R
* In R, regex are implemented in the `stringr` package. Most importantly the function `str_match(string, "regex")`
* Let's go back to our individual pages and start with the contact information. It always starts with "Respresentative Name". We can use this:
```
name <- str_match(address, "Representative (.+)")
```
* Let's take a look at this using `name` -- OK, it appears we want the 2nd element. We know how to do this:
```
name <- name`[[`(2)
```
### Exercise
Can you do the same for District, Hometown, and Party?
Anything else you would like to scrape?

### Exercise
Can you turn this into a dataset?

## The Finished Code

There are, of course, many ways to do this. [Here is the finalized script](ohio-legislature.R) I came up with that creates two tables -- one very crude, one cleaned up -- with all 98 current house representatives.
