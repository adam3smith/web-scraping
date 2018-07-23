# Load libraries
library(rvest)
library(stringr)

# We're scraping the Ohio stat legislature

homepage <- "https://www.legislature.ohio.gov/legislators/legislator-directory"
directory <- read_html(homepage)
# Find all links to house reps
leg_urls <- directory %>% html_nodes("#houseDirectory td:nth-of-type(2) a") %>% html_attr("href")

#create data frame
legislators <- data.frame(stringsAsFactors = F)


# Circle through all and scrape basic data
for (url in leg_urls) {
  page <- read_html(url)
  contact <- page%>% html_nodes("div .contactModule")
  if (length(contact)) {
    address <-  contact %>% `[[`(1) %>% html_text(trim = TRUE)
    
    background <-  contact %>% `[[`(2) %>% html_text(trim = TRUE)
    committees <- page %>% html_nodes(".committeeList a") %>% html_text(trim = TRUE)
    committees <- paste(committees, collapse = "; ")
    bio <- page %>% html_node(".biography p") %>% html_text(trim = TRUE)
    
    legislators <-  rbind(legislators, data.frame(address, background, committees, bio))
    
  }
}

# Set up other data frame
legislators_clean <- data.frame(stringsAsFactors = F)

# Improve what we scrape

for (url in leg_urls) {
  page <- read_html(url)
  contact <- page%>% html_nodes("div .contactModule")
  if (length(contact)) {
    address <- contact %>% `[[`(1) %>% html_text(trim = TRUE)
    name <- str_match(address, "^Representative\\s(.+)") %>% `[[`(2)
    district <- str_match(address, "District\\s\\d+")
    district
    background <- contact %>%`[[`(2) %>% html_text(trim = TRUE)
    hometown <-  str_match(background, "Hometown : (.+) Party :")  %>% `[[`(2)
    hometown
    party <-  str_match(background, "Party : (.+) Current Term :") %>% `[[`(2)
    party
    leadership <- str_match(background, "Leadership Position : (.+)\\s*Hometown :")
    if (length(leadership)){
      leadership <- leadership %>% `[[`(2)
    }
    else {
      leadership <- NA
    }
    committees <- page %>% html_nodes(".committeeList a") %>% html_text(trim = TRUE)
    committees <- paste(committees, collapse = "; ")
    bio <- page %>% html_node(".biography p") %>% html_text(trim = TRUE)
    
    legislators_clean <-  rbind(legislators_clean, data.frame(name, district, hometown, party, leadership, committees, bio, url))
  }        
}

#timestamp the date of this
filename <- paste("Ohio-House_", Sys.Date(), ".csv", sep = "")

write.table(legislators_clean, file = filename, sep = ",", col.names = NA,
            qmethod = "double")
