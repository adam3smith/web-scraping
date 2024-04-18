---
title: Introduction
description: What you will learn -- and what you won't
layout: default
---
## Goals

### What You Will Learn
* Why use screensraping?
* The structure of a webpage
* Selecting html nodes using CSS selectors
* Using R's `rvest` package for scraping content
* A tiny bit about tidyverse-style R coding
* A little about using R's `stringr` package to clean up imported web data

### What You Will _Not_ Learn
* Web crawling
* Getting data from APIs ("Application Programming Interfaces")
* Writing great R code, or really much about coding in R; I'll focus on the webscraping and may gloss over aspects of R
* How to scrape from very complex pages, e.g. those built as javascript applications. `rvest` does have some capabilities for this and there's a package called `rselenium` that let's you actually mimic a browser in R to scrape interactive content (see this [tutorial](https://www.rselenium-teaching.etiennebacher.com/))

## Why does this matter?
Web scraping is used widely in data science, social science, and the humanities to quickly collect large amounts of semi-structured data. Some examples:

* Mahdavi, Paasha, and John Ishiyama. 2020. “Dynamics of the Inner Elite in Dictatorships: Evidence from North Korea.” _Comparative Politics_ 52 (2): 221–49. https://doi.org/10.5129/001041520X15652680065751.
  * Looks at who falls in and out of favor with Kim Jong-un by tracking who accompanies him using media reports of facilities inspections:

  > We initially scrape all daily reports in English from the KCNA website from January 2012 to June 2015. The endpoint is the latest available date that the website could still be accessed without a South Korean “mirror.” We then identify any report that provides information on an inspection visit using keyword stems associated with these events. We subsequently verify each report manually to ensure that each is indeed reporting on an inspection visit by Kim Jong-un; this step yields a total of 303 reports. Using a list of eighty-eight elites within the regime at the end of 2011 based on Ishiyama and from NK News we identify both the events each individual attended with the Supreme Leader and the frequency of co-occurrences with any other elites at each event.


* Carnegie, Allison, and Austin Carson. 2019. “Reckless Rhetoric? Compliance Pessimism and International Order in the Age of Trump.” _The Journal of Politics_ 81 (2): 739–46. https://doi.org/10.1086/702232.
  * Compares President Trump's rhetoric on trade to that of previous presidents by looking at how they talk about trade in speeches
  
  > To conduct our analysis, we used Python to scrape presi-dential documents from the American Presidency Project(APP) archives (http://presidency.proxied.lsit.ucsb.edu/), re-trieving a corpus of documents for George W. Bush, BarackObama, and Donald Trump. There are 23 categories of doc-uments, including everything from campaign documents toconvention speeches to inaugural addresses. We counted thenumber of speeches in which presidents use the word“trade”and created word frequencies, as well as the proportion ofspeeches in which this term was used.

* Walsh, Melanie, and Maria Antoniak. 2021. “The Goodreads ‘Classics’: A Computational Study of Readers, Amazon, and Crowdsourced Amateur Criticism.” _Journal of Cultural Analytics_ 1 (1): 22221. https://doi.org/10.22148/001c.22221.
  * How do "amateur" reviewers discuss literary "classics"? The study uses topic modeling on ~130,000 reviews of 144 literary "classics".

> The first key insight is that Goodreads purposely conceals and obfuscates its data  from the public. The company does not provide programmatic (API) access to the  full text of its reviews, as some websites and social media platforms do. To collect reviews, we thus needed to use a technique called “web scraping,” where one  extracts data from the web, specifically from the part of a web page that users can see, as  opposed  to  retrieving  it  from  an  internal  source.


## Your Goals
* Not everyone will or should have the same learning goal
* Some of you will be able to do this yourself, but will still need to read documentation/tutorials (I do!)
* Some of you will get a very good sense of how this works -- that's great! Coding is learned by repetition


## Installing
* You should have R and R Studio installed on your computer already. If not, please do so now.
* Please start R studio now
* Please install the `rvest`, the `stringr`, and the  `dplyr` packages if you haven't already.
```
install.packages("stringr")
install.packages("rvest")
install.packages("dplyr")
```

**[Go to the next page](web-structure-basics)**
