# Global  Pairwise Sequence Alignment for DNA sequences in an R Shiny App. 
## Summary: 
This R Shiny  application enables  users to conduct global pairwise sequence alignment for DNA sequences, and then create a dotplot of the sequences.
The app uses  the ```pairwiseAlignment()``` function from the Biostrings package, which uses the Needleman-Wunsch algorithm to find the optimal alignment.
A default scoring matrix and  percent identity calculation method is set, however users can modify it to their specific needs using the input boxes; 
Setting up the scoring matrix involves defining values that quantify the match, mismatch, gap opening, and gap extension penalties for the pairwise sequence alignment algorithm:<br>
```Match```: Aligned positions with identical  bases, showing sequence similarity.<br>
```Mismatch```:  positions with differing bases, indicating sequence dissimilarity.<br>
```Gap Opening```: Introducing a gap for insertions/deletions, initiating a sequence gap.<br>
```Gap Extension```: Continuing an existing gap<br>
For the Percent Identity calculation, users can choose from 4 methods. Please refer to this link for the differences between the methods: https://rdrr.io/bioc/Biostrings/man/pid.html <br>
Users can also create a dot plot of the two sequences, and then save it to a PNG file. The plot has 3 modifiable parameters:<br> 
```wsize```: The parameter determines the size of the sliding window used to analyze the sequences in the dotplot, influencing the granularity of sequence comparison.<br>
```wstep```: It refers to the step size that the sliding window takes as it moves along the sequences in the dotplot, impacting the degree of overlap between adjacent windows and the sensitivity of match detection.<br>
```nmatch```: The "nmatch" parameter sets a threshold for the minimum number of matches within a window required to plot a point on the dotplot, affecting the stringency of match identification .

## Running the App: 
1. Make sure you have R installed on your  computer.
2. Clone the repository
3. Before running the app, install the libraries listed at the beginning of `app.R`.
4. Open `app.R` and click on "Run App".
5. Optional: Open the app in your web browser.

## Possible enhancements: 
 - Adding a FASTA file upload for the input section 
 - Adding other plots 
-  Adding custom css and html 
## Bugs/Contributions: 
If you encounter any issues with the app, please submit an issue or a pull request! <br>
All contributions are greatly appreciated and encouraged!<br>
Thank you for using the app and have a great day!
