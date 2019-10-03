# Load libraries
library(rvest)
library(stringr)
library(magrittr)

homepage <- "https://www.parliament.uk/mps-lords-and-offices/mps/"
directory <- read_html(homepage)
# Find all links to house reps
leg_urls <- directory %>% html_nodes("td:nth-child(1) a") %>% html_attr("href")

# Define a function that scrapes from a given URL
# this is of course specific to the UK House of Commons
scrape <- function (url) {
  page <- read_html(url)
  name <- page %>% html_nodes('h1') %>% html_text(trim = TRUE)
  constituency  <- page %>% html_nodes('#commons-constituency') %>% html_text(trim = TRUE)
  party <-  page %>% html_nodes('#commons-party') %>% html_text(trim = TRUE)
  email <-  page %>% html_nodes('[data-generic-id="email-address"] a') %>% html_text(trim = TRUE)
  website <-  page %>% html_nodes('[data-generic-id="website"] a') %>% html_text(trim = TRUE)
  twitter <-  page %>% html_nodes('[data-generic-id="twitter"] a') %>% html_text(trim = TRUE) 
  facebook <- page %>% html_nodes('[data-generic-id="facebook"] a') %>% html_text(trim = TRUE)
  if (length(email)) {
    email <- email  %>% `[[`(1)
  }
  else {
    email <- NA
  }
  if (length(website)){
    website <- website %>% `[[`(1)
  }
  else {
    website <- NA
  }
  if (!length(twitter)){
    twitter <- NA
  }
  if (!length(facebook)){
    facebook <- NA
  }
  
  firstElection <- page %>% html_nodes('table#electoral-history tr:last-of-type td.biography-electoral-history-date') %>% html_text(trim = TRUE)

  results <-data.frame(name, constituency, party, email, firstElection, tenure, website, twitter, facebook)
  return (results)
  
}


# create data frame
mps <- data.frame(stringsAsFactors = F)

# cycle through all MPs
for (url in leg_urls) {
  mps <-  rbind(mps, scrape(url))
  }


# Check for duplicates
mps$name[duplicated(mps$name)]





# Some munging
library(dplyr)
mps <- mps %>% mutate(firstElection = str_match(firstElection, "\\d{4}") %>% `[[`(1))
mps <- mps %>% mutate(tenure = 2019 - as.numeric(as.character(firstElection)))
mps <- mps %>% mutate(nameClean = str_remove(name, '\\s+MP$'))
mps <- mps %>% mutate(website = str_remove(website, '[.]+$'))

mps <- mps %>% mutate(hasTwitter = ifelse(!is.na(twitter), "1", "0"))
mps <- mps %>% mutate(hasFacebook = ifelse(!is.na(facebook), "1", "0"))
mps <- mps %>% mutate(hasWebsite = ifelse(!is.na(website), "1", "0"))

#timestamp the date of this
filename <- paste("UK_Commons_", Sys.Date(), ".csv", sep = "")

write.table(mps, file = filename, sep = ",", col.names = NA,
            qmethod = "double")

# Some "analysis"
prop.table(table(mps$hasTwitter, mps$party), margin = 2)
prop.table(table(mps$hasFacebook, mps$party), margin = 2)
prop.table(table(mps$hasWebsite, mps$party), margin = 2)

