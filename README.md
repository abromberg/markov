Markov Chains
======

These scripts were created in R for a class I took Fall Quarter of my Freshman year at Stanford called Breaking Codes, Finding Patterns.

I was tasked with using [Markov Chains](http://en.wikipedia.org/wiki/Markov_chain) to randomly generate text based off a corpus of input text and a order for the chain.

More information about the actual process can be found on the Wikipedia page I linked to.

I wrote this as I was learning R and haven't given it a substantial look-over since, so there are guaranteed to be inefficiencies or mistakes. If you spot one, please [let me know!](mailto:andy@andybromberg.com)

Steps to Run
======

1. Install and launch R. I like to use [RStudio](http://www.rstudio.com/).
2. Create a directory called *markov*. From the command line: *mkdir markov*
3. Open up that directory. From the command line: *cd markov*
4. Clone this repository. From the command line: *git clone git@github.com:abromberg/markov.git*
5. Open whichever R file you want to use in RStudio (there is one for word-based Markov chain text generation, and one for character-based).
6. Make sure your working directory is the *markov* directory. From RStudio, you can go to Tools -> Set Working Directory -> Choose Directory. Or you can run the command *setwd('path/to/directory')*
7. Download .txt files of whatever you want to base the output off of and place them in the Markov directory.
8. Change the lines that define the filenames in the program to include those text files.
9. Change the variable *look_forward* to the Markov order you want to use.
10. Select 'Run' to execute the program.
