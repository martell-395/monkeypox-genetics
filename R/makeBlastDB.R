# Notebook completed by Samantha Martell
# First modified: 03 Jun 2022
# Last modified: 03 Jun 2022
# [YouTube tutorial](https://www.youtube.com/watch?v=qhLSfx_wpeA) uploaded by [Dr. Danny Arends](https://dannyarends.nl/?).
# copyright (c) 2022 - Samantha Martell

makeBlastDB <- function(sequences, db = "data/DNAdb.fsa", name = "MonkeyDNA", dbtype = "nucl"){
  cat("", file = db)
  for(header in names(sequences)){
    cat(header, "\n", file = db, append = TRUE)
    cat(sequences[header], "\n", file = db, append = TRUE)
  }
  
  system(paste0("makeblastdb -in ", db," -parse_seqids -title '", name, "' -dbtype ", dbtype))
  return(db)
  
}