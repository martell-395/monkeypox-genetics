# Notebook completed by Samantha Martell
# First modified: 03 Jun 2022
# Last modified: 04 Jun 2022
# [YouTube tutorial](https://www.youtube.com/watch?v=qhLSfx_wpeA) uploaded by [Dr. Danny Arends](https://dannyarends.nl/?).
# copyright (c) 2022 - Samantha Martell


blast <- function(sequences, tool  =  "tblastn"){
  tmpfile <- tempfile()
  cat("", file  =  tmpfile)
  
  for(name in names(sequences)){
    cat(">", name, "\n", file  =  tmpfile, append = TRUE)
    cat(gsub("-", "N", sequences[name]), "\n", file  =  tmpfile, append = TRUE)
  }
  
  outfmt <- "\"6 qseqid sseqid qstart qend slen sstart send length pident nident mismatch gapopen gaps evalue\""
  res <- system(paste0(tool, " -db ", db, " -outfmt ", outfmt, " -query ", tmpfile), intern  =  TRUE)
  file.remove(tmpfile)
  
  cat(length(res), "\n")
  
  values <- NA
  if(length(res) > 0){
    values <- unlist(lapply(res, strsplit, "\t"))
  }
  res <- matrix(values, length(res), 14, byrow = TRUE)
  colnames(res) <- c("qseqid", "sseqid", "qstart", "qend", "slen", "sstart", "send", "length", "pident", "nident", 
                     "mismatch", "gapopen", "gaps", "evalue")
  
  res <- data.frame(res)
  
  # clean the data such that only entries with a low e-value are included. 
  res <- res[which(as.numeric(res[, "evalue"]) < 0.01), ]
  
  # tidy up the IDs in the sseqid column
  res[, "sseqid"] <- unlist(lapply(res[, "sseqid"], function(x){
    if(length(grep("|", unlist(strsplit(x, "")), fixed = TRUE)) == 2){
      return(unlist(lapply(strsplit(x, "|", fixed = TRUE), "[", 2)))
    }
    return(x)
    
  }))
  
  return(res)
}