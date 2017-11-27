
HW04 - Grade Visualizer
=======================

This assignment focuses on a data set containing raw scores of fictitious students in a hypothetical Stat 133 course. Overall, this HW is to work on a relatively small data computing and visualization project.

### Introduction

From the user point of view, the main deliverable will be a shiny app to visualize:

-   the overall grade distribution
-   the distribution and summary statistics of various scores
-   the relationships between pairs of scores

From the developer point of vew, this HW requires a number of functions that process the data, and compute the required statistics.

In summary, this project involves working around three primary aspects:

1.  Low level coding:

-   writing functions (and document them)
-   testing functions (runing unit tests)

1.  Data Analysis Cycle:

-   data preparation, and reformatting
-   data analysis and visualization
-   reporting via interactive tools

1.  Practice with R packages:

-   `testthat`
-   `shiny`
-   `ggvis`
-   optional: `readr`, `dplyr`, etc

### Run Shiny App

``` r
library(shiny)
# Run an app from a subdirectory in the repo
runGitHub("stat133-hws-fall17", "yijiaqiao", subdir = "hw04/app")
```

### Note

-   Special instructions for any user (if necessary)
-   Special instructions for graders (if necessary)
-   Links to any resources that you used to complete the HW
-   List of references that you used to complete the HW

### Comments and Reflections

-   Was this your first time writing unit tests? --This is my first time with unit tests.
-   On a scale from 0 to 10, how confusing you found the logic of testthat tests? --I think 4.5.
-   Was this your first time working with ggvis? --This was my first time working with ggvis.
-   On a scale from 0 to 10, how confusing you found the syntax of ggvis? --Ggvis has different syntaxes but its syntaxes are quite clear when people read. So I think 8.
-   Was this your first time working with conditional panels in shiny? --This was my first time.
-   On a scale from 0 to 10, how challenging you found to work with the conditional panels? --6.
-   So far we???ve exposed you to three graphing paradigms in R: base plots, ggplot, and now ggvis. Which do you like the most and why? --I like ggplot the most. Because it has clear and simple structure to do graph layers. Also it's pretty.
-   Did anyone help you completing the assignment? If so, who? --Yes. I asked GSI and peers for helping with debugging.
-   How much time did it take to complete this HW? --About 6 hours.
-   What was the most time consuming part? --Shiny app.
