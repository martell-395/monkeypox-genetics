readBlastDBasCsv <- function (filepath){
  db.test <- read.delim(filepath, sep = ",", header = TRUE)
  colnames(db.test) <- c("names", "seq")     # rename columns
  ncbi.seq <- unlist(list(db.test["seq"]))   # convert to list and unlist to return a vector
  names <- unlist(list(db.test["names"]))    # convert to list and unlist to return a vector
  names(ncbi.seq) <- names                    # assign names to sequences
  
  # str(ncbi.seq) # check the dataframe
  
  return(ncbi.seq)
}