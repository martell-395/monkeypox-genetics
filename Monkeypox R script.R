# Introduction
# [YouTube tutorial](https://www.youtube.com/watch?v=qhLSfx_wpeA) uploaded by [Dr. Danny Arends](https://dannyarends.nl/?).

# Notebook completed by Samantha Martell
# 
# Opened: 30 May 2022
# 
# Final edit: 

### To-do list
# 1. Where do we get our data from? (e.g. USA, Portugal, Belgium). Source from NCBI. 
# 2. Load genome sequences from fasta and NCBI.
# 3. Create a blast database.
# 4. Load associated proteins from NCBI.
# 5. Create a protein model (Levenstein, MSA) -> consensus.
# 6. tblastn Consensus to viral genomes database.
# 7. Genomic layout of the virus.

# Clear environment
rm(list = ls())


# set working directory
setwd("C:/Users/samma/Monkeypox-genetics/")
cat(getwd())
list.files()

## Importing packages
library(msa)
library(RColorBrewer)
library(rentrez)
library(stringdist)
library(seqinr)


# 0 Getting data from NCBI

# getwd()
sourceIDs <- read.csv(file = "C:/Users/samma/Monkeypox-genetics/data/monkeypox_annotation.txt", sep = "\t", header = TRUE, row.names = 1)

# check the dataframe
head(sourceIDs)

Check the structure of the new dataframe. 

str(sourceIDs)



# 1 Load genome sequences

rseq <- entrez_fetch("nucleotide", rownames(sourceIDs)[1], rettype = "fasta")


Check the data.

cat(class(rseq), "\n\n")
cat(str(rseq), "\n\n")

Make the output readable using strsplit() and unlist():
  
cat(class(strsplit(rseq, "\n")), "\n")
cat(class(unlist(strsplit(rseq, "\n"))))


Use [`grep`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/grep) function to find the header row.

rseq <- entrez_fetch("nucleotide", rownames(sourceIDs)[1:3], rettype = "fasta")
rseq <- unlist(strsplit(rseq, "\n"))
header.lines <- grep(">", rseq)
header.lines

* This tells us the first sequence starts on row 2, the second sequence starts on row 2821, the third sequence starts on row 5639.

Make a new dataframe containing all the relevant positions:
  
seq.pos <- cbind(
  start = header.lines + 1, # calls all the start positions
  stop = c(header.lines[-1] - 1, length(rseq)) # calls all the end positions + the final entry in header.lines
)
seq.pos




seq.fasta <- apply(seq.pos, 1, function(x){
  cat(as.numeric(x["start"]))
})
``q`

