# Global  Pairwise Sequence Alignment for DNA sequences in an R Shiny App. 
## Summary: 
This R Shiny  application enables  users to conduct global pairwise sequence alignment for DNA sequences, and then create a dotplot of the sequences.
The app uses  the ```pairwiseAlignment()``` function from the Biostrings package, which uses the Needleman-Wunsch algorithm to find the optimal alignment.
A default scoring matrix and  percent identity calculation method are set, however users can modify it to their specific needs using the input boxes; 
Setting up the scoring matrix involves defining values that quantify the match, mismatch, gap opening, and gap extension penalties for the pairwise sequence alignment algorithm:
```Match```: Aligned positions with identical  bases, showing sequence similarity.
```Mismatch```:  positions with differing bases, indicating sequence dissimilarity.
```Gap Opening```: Introducing a gap for insertions/deletions, initiating a sequence gap.
```Gap Extension```: Continuing an existing gap
For the Percent Identity calculation, users can choose from 4 methods. Please refer to this link for the differences between the methods: https://rdrr.io/bioc/Biostrings/man/pid.html
Users can also create a dot plot of the two sequences, and then save it to a PNG file. The plot has 3 modifiable parameters: 
```wsize```: The parameter determines the size of the sliding window used to analyze the sequences in the dotplot, influencing the granularity of sequence comparison.
```wstep```: It refers to the step size that the sliding window takes as it moves along the sequences in the dotplot, impacting the degree of overlap between adjacent windows and the sensitivity of match detection.
```nmatch```: The "nmatch" parameter sets a threshold for the minimum number of matches within a window required to plot a point on the dotplot, affecting the stringency of match identification .

## Running the App: 
1. Make sure you have R installed on your computer.
2. Before running the app, install the libraries listed at the beginning of `app.R`.
3. Open `app.R` and click on "Run App".
4. Optional: Open the app in your web browser.

## Possible enhancements: 
 - Add a FASTA file upload for the input section 
 - Add other plots 
-  Add custom css and html 
## Bugs/Contributions: 
If you encounter any issues with the app, please submit an issue or a pull request! 
All contributions are greatly appreciated and encouraged!
Thank you for using the app and have a great day!
