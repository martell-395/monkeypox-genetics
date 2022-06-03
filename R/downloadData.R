downloadData <- function(ids, db = "nucleotide"){
  rseq <- entrez_fetch(db, ids, rettype = "fasta")  # returns sequences in the fasta format
  rseq <- unlist(strsplit(rseq, "\n"))              # strsplit() to split convert to a list,
                                                    # then unlist() to flatten the list. 
  
  header.lines <- grep(">", rseq) # Use grep() to find the header rows
  
  # to find the positions where the sequences start and end, use the positions of the header lines
  seq.pos <- cbind(start = header.lines + 1, stop = c(header.lines[-1] - 1, length(rseq)))
  
  # apply to every row in seq.pos function (x) (to be defined...) and store in seq.fasta
  seq.fasta <- apply(seq.pos, 1, function(x)
  {
    paste0(rseq[seq(as.numeric(x["start"]), as.numeric(x["stop"]))], sep = "", collapse = "")
  })
  
  # Get the names of the sequences from the original rseq object.
  names(seq.fasta) <- rseq[header.lines]
  return (seq.fasta)
}