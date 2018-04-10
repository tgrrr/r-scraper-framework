\name{jobScrapeTool}
\alias{jobScrapeTool}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
jobScrapeTool(value)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{value}{
%%     ~~Describe \code{value} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (value) 
{
    dat <- list()
    setwd("./..")
    urls <- list("Lead_Senior_fed.htm", "Javascript_dev_Traffio.html")
    parseJob <- function(header, html_class, i) {
        tryCatch(page \%>\% html_node(html_class) \%>\% html_text() \%>\% 
            str_trim() \%>\% unlist(), error = function(e) {
            NA
        })
    }
    for (i in 1:length(urls)) {
        page <- urls[i] \%>\% as.character() \%>\% read_html()
        job_site <- "Indeed"
        job_title <- parseJob("job_title", "b.jobtitle font", 
            i)
        job_location <- parseJob("job_location", "span.location", 
            i)
        job_summary <- parseJob("job_summary", "span.summary", 
            i)
        job_date <- parseJob("job_date", "date", i)
        job_salary <- parseJob("job_salary", "span.no-wrap", 
            i)
        dat[[i]] <- data.frame(job_title, job_location, job_date, 
            job_salary, job_summary, job_site)
    }
    job_search_data = do.call(rbind, dat)
    write.table(job_search_data, "job_search_data.csv", sep = ",", 
        col.names = T, append = T)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
