#setup for work
setwd("~/R/Resources")

#set text to be used and read into variable:text
fileName <- "prideandprejudice_10ch.txt"
text <- readChar(fileName, file.info(fileName)$size)
#get rid of line break characters and slashes and escaped quotation marks
text <- gsub("\r|\n","",text)
text <- gsub("\"","'",text)
#set markov order into variable:look_forward and set length of final text
look_forward <- 5
final_length <- 300 - look_forward - 1

#set up matrix to be used in for loop into matrix:d
d <- matrix(nrow=1, ncol=nchar(text))

#split up substrings into matrix:d
for (i in 1:nchar(text)) {
  char <- substr(text, i, i + look_forward)
  d[1,i] <- char
}

#create data table of frequencies of substrings
char_table <- as.data.frame(table(d))

#rename columns
col_names <- c("substring","frequency")
colnames(char_table) <- col_names

#get total number of non-unique substrings
total_substr <- sum(char_table$frequency)

#add column to char_table with probability of each substring
char_table$probability <- char_table$frequency / total_substr

#add columns to char_table with first characters of substrings and then last character
char_table$first_chars <- substr(char_table$substring, 1, look_forward)
char_table$last_char <- substr(char_table$substring, look_forward+1, look_forward+1)

final_text <- as.character(sample(char_table$substring, size=1, replace=T, prob=char_table$probability))

for (i in 1:final_length) {
  last_chars <- substr(final_text, nchar(final_text) + 1 - look_forward, nchar(final_text))
  possible_substrs <- char_table[char_table$first_chars==last_chars,]
  new_char <- as.character(sample(possible_substrs$last_char, size=1, replace=T, prob=possible_substrs$probability))
  final_text <- paste(final_text, new_char, sep="")
}

final_text