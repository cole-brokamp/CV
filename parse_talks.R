#!/usr/bin/Rscript

library(tidyverse)

# read in yaml and parse yaml file
input <-
  readLines('talks.yaml') %>%
  paste(collapse='\n')

talks <-
  strsplit(input,'---',fixed=TRUE)[[1]] %>%
  tail(-1)

talks.yaml <- lapply(talks,yaml::yaml.load)


yaml_paste_talks <- function(y) {
  out <- paste0(y$title,'. ',
                '*',y$event,'.* ',
                y$location,'. ',
                y$year,'.')
  if (!is.null(y$link)) {
    dl_link <- paste0('https://talks.colebrokamp.com/', y$s3_filename)
    out <- paste0(out,' *[Download](',dl_link,')*. ')
    }
  return(out)
}

talks.parsed <- lapply(talks.yaml,yaml_paste_talks)

# make tex file
file.create('talks.md')
talks.parsed %>%
  paste(collapse='\n\n') %>%
  cat(file='talks.md')

system('pandoc -o talks.tex talks.md')
