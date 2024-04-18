---
title: Data analysis
description: What can we learn from this?
layout: default
---
The focus of today isn't on data analysis, so this last part is more of a "show and tell" of some simple things you could do with the data.

## Comparing tenure
We left off with creating the `yearSince` variable. Let's do some basic analysis on that. We'll first turn "party" into a factor variable, and use that to look at the composition of the assembly:
```
# Check party composition
fullAssembly$party <- as.factor(fullAssembly$party)
summary(fullAssembly$party)
```
Now let's look at summary statistics and a histogram for the years in which assembly members joined:

```
summary(fullAssembly$yearSince)
hist(fullAssembly$yearSince)
```
This looks like a very young assembly with some very old members!
Let's look at the oldest ones:

```
arrange(fullAssembly, yearSince) |> head()
```


Is this the same for both parties?
Let's create subsets for parties?

```
# Create party subsets
assemblyDem <- fullAssembly |> filter(party == "Democratic")
assemblyRep <- fullAssembly |> filter(party == "Republican")
```
Look at how they differ:
```
# Compare how long Dems & Rs are in the Assembly
summary(assemblyDem$yearSince)
summary(assemblyRep$yearSince)
```
This looks quite different! Democrats have some long-serving members, Republicans none!
This becomes even clearer when we graph this in parallel violin plots:
```
ageViolin <-
  fullAssembly |> filter(party == "Republican" |
                            party == "Democratic") |> ggplot(aes(y = yearSince, x = party)) +
  coord_flip()+
  geom_violin(trim=FALSE)+
  geom_boxplot(width=0.1) +
  theme_minimal()
ageViolin
```
What an interesting difference! We have a couple of research projects right there? Why is this? Does it affect how the two parties behave in the assembly? Is it similar to other states?

# Topic modeling
We have all this text! Let's do some automated text analysis. We'll use the `quanteda` library. We first need to tokenize the data. Let's create a function that performs standard steps for this:
```
tokenize_bios <- function (data){
  bioTokens <-
    tokens(
      data$biography,
      remove_punct = TRUE,
      remove_numbers = TRUE,
      remove_symbols = TRUE
    )
  bioTokens <-
    tokens_remove(bioTokens, pattern = c(stopwords("en"), stopwords("es")))
  return(bioTokens)
}
```
Next we can create some world clouds. Quanteda actually has a feature for contrasting within a single word cloud, but we'll create separate ones:

```
bio_wordCloud <- function(data){
  bioTokens <- tokenize_bios(data)
  dfmat_bio <- dfm(bioTokens) |>
    dfm_trim(
      min_termfreq = 0.8,
      termfreq_type = "quantile",
      max_docfreq = 0.1,
      docfreq_type = "prop"
    )
  textplot_wordcloud(dfmat_bio)  
}

bio_wordCloud(fullAssembly)
bio_wordCloud(assemblyDem)
bio_wordCloud(assemblyRep)
```

Hard to spot much of interest in there if we're honest. Let's see if we can see more with some LDA topic modeling. Again, let's create a function to do this, extracting the top terms for all models, allowing us to specify the number of topics:

```
topicTerms <- function(data, k = 6) {
  # From https://tutorials.quanteda.io/machine-learning/topicmodel/
  bioTokens <- tokenize_bios(data)
  
  dfmat_bio <- dfm(bioTokens) |>
    dfm_trim(
      min_termfreq = 0.8,
      termfreq_type = "quantile",
      max_docfreq = 0.3,
      docfreq_type = "prop"
    )
  
  tmodBio <- textmodel_lda(dfmat_bio, k)
  return (terms(tmodBio, 10))
}


topicTerms(fullAssembly)
topicTerms(assemblyDem)
topicTerms(assemblyRep)
```

Note that LDA topic models start at a random location: you won't always get the same results, especially on small corpora such as ours.



## The Finished Code

[Here is the finalized script](NYS-assembly.R) of the entire process for you to look through.
