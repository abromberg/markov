#setup for work
setwd("~/R/Resources")

#set text to be used and read into variable:text
fileName <- "prideandprejudice_10ch.txt"
text <- readChar(fileName, file.info(fileName)$size)
#get rid of line break characters and slashes and escaped quotation marks
text <- gsub("\r|\n","",text)
text <- gsub("\"","'",text)
#set markov order into variable:look_forward and set length of final text
look_forward <- 2
final_length <- 100 - look_forward - 1

#set up matrix to be used in for loop into matrix:d
split_text <- as.data.frame(strsplit(text," "))
word_count <- nrow(split_text)
d <- matrix(nrow=1, ncol=word_count)

#split up word combinations into matrix:d
#from stackoverflow: http://stackoverflow.com/questions/8872376/split-vector-with-overlapping-samples-in-r
splitWithOverlap <- function(vec, seg.length, overlap) {
  starts = seq(1, length(vec), by=seg.length-overlap)
  ends   = starts + seg.length - 1
  ends[ends > length(vec)] = length(vec)
  lapply(1:length(starts), function(i, vec, starts, ends) vec[starts[i]:ends[i]], vec, starts, ends)
}
d <- sapply(split_text, function(x){ splitWithOverlap(as.character(x),(look_forward+1),look_forward)})
d <- sapply(d, function(x){ paste(x, collapse=" ") })


#create data table of frequencies of word combinations
word_table <- as.data.frame(table(d))

#rename columns
col_names <- c("words","frequency")
colnames(word_table) <- col_names

#get total number of non-unique substrings
total_words <- sum(word_table$frequency)

#add column to char_table with probability of each substring
word_table$probability <- word_table$frequency / total_words

#add columns to word_table with last word of word combinations and then first words
word_table$split_words <- strsplit(as.character(word_table$words)," ")
word_table$last_word <- NA_character_
word_table$first_words <- NA_character_
word_table$last_word <- as.character(sapply(word_table$split_words, function(x){ x[look_forward+1] } ))
word_table$first_words <- as.character(sapply(word_table$split_words, function(x){ paste(x[-(look_forward+1)], collapse=" ") } ))

#set seed words
final_text <- as.character(sample(word_table$words, size=1, replace=T, prob=word_table$probability))

#for each word you want to add
for (i in 1:final_length) {
  #get last words of text as it is and put them together
  split_final_text <- as.data.frame(strsplit(as.character(final_text)," "))
  last_words <- paste(as.character(tail(split_final_text,look_forward)[,1]), collapse=" ")
  #get rows of word_table with the same first words as the current last words
  possible_words <- word_table[word_table$first_words==last_words,]
  #pick a new word to add on out of these rows and add it at the end
  new_word <- as.character(sample(possible_words$last_word, size=1, replace=T, prob=possible_words$probability))
  final_text <- paste(final_text, new_word, sep=" ")
}

#display final text
final_text