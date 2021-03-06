setwd("./..")
job_search_data <- read.csv("job_search_data.csv")
  head(job_search_data)

job_search_data$job_summary <- gsub("<U+00EF><U+0082><U+00B7>", " ", job_search_data$job_summary, fixed = TRUE)
job_search_data$job_summary <- gsub("<U+00E2><U+0080><U+0099>", " ", job_search_data$job_summary, fixed = TRUE)
job_search_data$job_summary <- gsub("\n", " ", job_search_data$job_summary, fixed = TRUE)

tidy_jobs <- job_search_data %>%
  unnest_tokens(word, job_summary)

tidy_jobs

cleaned_jobs <- tidy_jobs %>%
  anti_join(get_stopwords())

cleaned_jobs %>%
  count(word, sort = TRUE)

## Sentiment
nrcjoy <- get_sentiments("nrc") %>%
  filter(sentiment == "joy")

tidy_jobs %>%
  semi_join(nrcjoy) %>%
  count(word, sort = TRUE)

## Two word pairs
two_word <- job_search_data %>%
  unnest_tokens(bigram, job_summary, token = "ngrams", n = 2)

bigrams_separated <- two_word %>%
  separate(bigram, c("word1", "word2"), sep = " ")
  
bigrams_filtered <- bigrams_separated %>%
filter(!word1 %in% stop_words$word) %>%
filter(!word2 %in% stop_words$word)

bigram_counts <- bigrams_filtered %>%
  count(word1, word2, sort = TRUE)
bigram_counts
