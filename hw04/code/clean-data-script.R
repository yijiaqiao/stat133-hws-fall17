# read `rawscores.scv`
rawscores <- read.csv('data/rawdata/rawscores.csv', header = TRUE)

# get output
sink('../hw04/output/summary-rawscores.txt')
str(rawscores)
print_stats(summary_stats(rawscores))
sink()

# replacing NA with 0
for (i in 1: ncol(rawscores)) {
  for (j in 1:nrow(rawscores)) {
    if (is.na(rawscores[j, i])) {
      rawscores[j, i] <- 0
    }
  }
}

# rescale
rawscores$QZ1 = rescale100(rawscores$QZ1, xmin=0, xmax=12)
rawscores$QZ2 = rescale100(rawscores$QZ2, xmin=0, xmax=18)
rawscores$QZ3 = rescale100(rawscores$QZ3, xmin=0, xmax=20)
rawscores$QZ4 = rescale100(rawscores$QZ4, xmin=0, xmax=20)
rawscores$Test1 = rescale100(rawscores$EX1, xmin=0, xmax=80)
rawscores$Test2 = rescale100(rawscores$EX2, xmin=0, xmax=90)

rawscores$Homework = apply(rawscores[1:nrow(rawscores),1:9], 1, score_homework)
rawscores$Quiz = apply(rawscores[1:nrow(rawscores), 11:14], 1, score_quiz)
Lab = rawscores$ATT
for (i in 1: length(Lab)) {
  Lab[i] <- score_lab(Lab[i])
}
rawscores$Lab = Lab
overall = 0.1 * Lab + 0.3 * rawscores$Homework + 0.15 * rawscores$Quiz + 0.2 * rawscores$Test1 + 0.25 * rawscores$Test2

rawscores$Overall = overall

# Calculate final grades
Grade = overall
for (i in 1:length(overall)) {
  if (overall[i] >= 95 & overall[i] <= 100) {
    Grade[i] <- 'A+'
  } else if (overall[i] < 95 & overall[i] >= 90) {
    Grade[i] <- 'A'
  } else if (overall[i] < 90 & overall[i] >= 88) {
    Grade[i] <- 'A-'
  } else if (overall[i] < 88 & overall[i] >= 86) {
    Grade[i] <- 'B+'
  } else if (overall[i] < 86 & overall[i] >= 82) {
    Grade[i] <- 'B'
  } else if (overall[i] < 82 & overall[i] >= 79.5) {
    Grade[i] <- 'B-'
  } else if (overall[i] < 79.5 & overall[i] >= 77.5) {
    Grade[i] <- 'C+'
  } else if (overall[i] < 77.5 & overall[i] >= 70) {
    Grade[i] <- 'C'
  } else if (overall[i] < 70 & overall[i] >= 60) {
    Grade[i] <- 'C-'
  } else if (overall[i] < 60 & overall[i] >= 50) {
    Grade[i] <- 'D'
  } else if (overall[i] < 50 & overall[i] >= 0) {
    Grade[i] <- 'F'
  }
}

rawscores$Grade = Grade

# summary statistics for Lab, Homework, Quiz, Test1, Test2, and Overall
filename <- c('../hw04/output/Test1-stats.txt', '../hw04/output/Test2-stats.txt', '../hw04/output/Homework-stats.txt', '../hw04/output/Quiz-stats.txt', '../hw04/output/Lab-stats.txt', '../hw04/output/Overall-stats.txt')
for (i in 17:22) {
  sink(file = filename[i-16])
  print_stats(summary_stats(rawscores[ , i]))
  sink()
}

# get file `summary-cleanscores.txt``
sink('../hw04/output/summary-cleanscores.txt')
str(rawscores)
sink()

# export the clean data frame of scores to a CSV file `cleanscores.csv``
write.csv(rawscores, file = '../hw04/data/cleandata/cleanscores.csv')








