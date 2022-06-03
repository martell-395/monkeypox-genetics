makeBlastDB <- function (sequences, filename){
  db <- filename
  cat("", file = db)
  for (header in names(sequences)){
    cat(header, "\n", file = db, append = TRUE)
    cat(sequences[header], "\n", file = db, append = TRUE)
  }
  return(db)
}