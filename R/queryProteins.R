# Notebook completed by Samantha Martell
# First modified: 03 Jun 2022
# Last modified: 03 Jun 2022
# [YouTube tutorial](https://www.youtube.com/watch?v=qhLSfx_wpeA) uploaded by [Dr. Danny Arends](https://dannyarends.nl/?).
# copyright (c) 2022 - Samantha Martell

# ID is the the ID of the (annotated) nucleotide sequence in the NCBI database.

queryProteins <- function(id = "NC_003310.1"){ 
  links <- entrez_link(dbfrom = "nuccore", id = id, db = "protein")
  protein.ids <- links$links$nuccore_protein
  
  cat("This list has", length(protein.ids), "entries. \n")
  # cat("The class of protein.ids is", class(protein.ids), ".")
  
  # unannotated nucleotide sequences will produce a protein.ids list with a length of 0, so don't want to query those. 
  if(length(protein.ids) > 0){
    protein.seq <- downloadData(protein.ids, "protein")
    return(protein.seq)
  }
  return(NULL)
}