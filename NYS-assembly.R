# Load libraries
library(rvest)
library(stringr)
library(dplyr)
library(quanteda)
# install.packages("seededlda")
library(seededlda)
library(ggplot2)


# NYS Assembly Scraping ---------------------------------------------------


# NYS Assembly
homepage <- "https://assembly.state.ny.us/mem/"
directory <- read_html(homepage)
# Find all links to assembly members
leg_urls <-
  directory %>% html_nodes(".mem-name a") %>% html_attr("href")




scrape <- function(url) {
  url <- paste0("https://assembly.state.ny.us", url, "/")
  page <- read_html(url)

  name <-
    page %>% html_node('#head-mem-name') %>% html_text(trim = TRUE)
  district <-
    page %>% html_node('#head-mem-dist') %>% html_text(trim = TRUE)

  bioUrl <- paste0(url, "bio")
  bioPage <- read_html(bioUrl)
  biography <-
    bioPage %>% html_node('#biotext') %>% html_text(trim = TRUE)

  contactUrl  <- paste0(url, "contact")
  contactPage <- read_html(contactUrl)
  email <-
    contactPage %>% html_node('.member-email') %>% html_text(trim = TRUE)
  results <- data.frame(name, district, biography, email)
  return (results)
}

# create data frame
assembly <- data.frame(stringsAsFactors = F)

# cycle through all MPs
for (url in leg_urls) {
  print(url)
  assembly <-  rbind(assembly, scrape(url))
}

# Ballotpedia Scraping  & Merge -------------------------------------------


# Get additional data from Ballotpedia
bpUrl <- "https://ballotpedia.org/New_York_State_Assembly"
bpPage <- read_html(bpUrl)
bpTable <-
  bpPage %>% html_node('table#officeholder-table') %>% html_table()



# Merge dataframes
bpTable$Office <- bpTable$Office %>% str_remove("New York State ")

bpTable <-
  bpTable %>% rename(district = Office,
                     memberSince = `Date assumed office`,
                     party = Party)

fullAssembly <- merge(assembly, bpTable, by = "district")



# Cleaning & basic analysis -----------------------------------------------


# Check party composition
fullAssembly$party <- as.factor(fullAssembly$party)
summary(fullAssembly$party)

# Convert Date joined into year for simplicyt
fullAssembly$yearSince <-
  fullAssembly$memberSince %>% str_extract("\\d{4}") %>% as.numeric()

summary(fullAssembly$yearSince)
hist(fullAssembly$yearSince)

# Create party subsets
assemblyDem <- fullAssembly %>% filter(party == "Democratic")
assemblyRep <- fullAssembly %>% filter(party == "Republican")


# Compare how long Dems & Rs are in the Assembly
summary(assemblyDem$yearSince)
summary(assemblyRep$yearSince)

# Visualize this as a boxplot
ageBox <-
  fullAssembly %>% filter(party == "Republican" |
                            party == "Democratic") %>% ggplot(aes(x = yearSince)) +
  geom_boxplot(position = "identity") +
  facet_wrap( ~ party, ncol = 1)

ageBox

# or a violin plot
ageViolin <-
  fullAssembly %>% filter(party == "Republican" |
                            party == "Democratic") %>% ggplot(aes(y = yearSince, x = party)) +
  coord_flip()+
  geom_violin(trim=FALSE)+
  geom_boxplot(width=0.1) +
  theme_minimal()
ageViolin


# Topic modeling ----------------------------------------------------------


topicTerms <- function(data, k = 6) {
  # From https://tutorials.quanteda.io/machine-learning/topicmodel/
  bioTokens <-
    tokens(
      data$biography,
      remove_punct = TRUE,
      remove_numbers = TRUE,
      remove_symbols = TRUE
    )
  bioTokens <-
    tokens_remove(bioTokens, pattern = c(stopwords("en"), stopwords("es")))

  dfmat_bio <- dfm(bioTokens) %>%
    dfm_trim(
      min_termfreq = 0.8,
      termfreq_type = "quantile",
      max_docfreq = 0.3,
      docfreq_type = "prop"
    )

  tmodBio <- textmodel_lda(dfmat_bio, k)
  return (terms(tmodBio, 10))
}



# Run topic models
topicTerms(fullAssembly)
topicTerms(assemblyDem)
topicTerms(assemblyRep)
