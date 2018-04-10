#' Function searches a specific airline by IATA code
#'
#' @param
#' @return csv and data.frame() with the jobs
#'
#' @author Phil Steinke, \email{phil@tgrrr.com}
#'
#' @examples
#' jobScrape("job_title", "b.jobtitle font", "indeed")
#'
#' @import RCurl
#' @import jsonlite
#' @export
#'

jobScrapeTool <-
function(value) {
  dat <- list()
  setwd("./..")
  urls <- list("Lead_Senior_fed.htm", "Javascript_dev_Traffio.html") # local test URL's
  parseJob <- function(header, html_class, i) {
    tryCatch(
      page %>%
      html_node(html_class) %>%
      html_text() %>%
      str_trim() %>%
      unlist(),
      error = function(e){NA}
    )
  }

  for (i in 1:length(urls)) {

    # page <- sprintf(urls, i) %>%
      page <-
      urls[i] %>%
      as.character() %>%
      read_html()

    job_site <- "Indeed"
    job_title <- parseJob("job_title", "b.jobtitle font", i)
    job_location <- parseJob("job_location", "span.location", i)
    job_summary <- parseJob("job_summary", "span.summary", i)
    job_date <- parseJob("job_date", "date", i) # days ago on Indeed
    job_salary <- parseJob("job_salary", "span.no-wrap", i) # days ago on Indeed

    dat[[i]] <-
    data.frame(job_title, job_location, job_date, job_salary, job_summary, job_site)
  }

  job_search_data <- do.call(rbind, dat)
  write.table(
    job_search_data,
    "job_search_data.csv",
    sep = ",",
    col.names = T,
    append = T)

}

setwd("~/code/scrapy")
package.skeleton(name = "Scrapy", list = c("jobScrapeTool"))
library(devtools)

# to automatically generate the documentation:
document()

# to build the package
build()

# to install the package
install()
