# ===================================================================
# Title: Data Preparation for HW03
# Description: This file is to create desired data file.
# Input(s): data file 
# Output(s): data file "nba2017-teams.csv" in  
# Author: Yijia Qiao
# Date: 10-10-2017
# ===================================================================

# Importing data frames
library(dplyr)
library(readr)
library(ggplot2)

# (using relative paths)
roster <- read_csv('./hw03/data/nba2017-roster.csv')
stats <- read_csv('./hw03/data/nba2017-stats.csv')

# Adding new variables to stats 
stats <- mutate(stats, 
                missed_fg = field_goals_atts - field_goals_made, 
                missed_ft = points1_atts - points1_made,
                points = points3_made * 3 + points2_made * 2 + points1_made ,
                rebounds = off_rebounds + def_rebounds)

# Calculating Efficiency Index
efficiency <- (stats$points + stats$rebounds + stats$assists + stats$steals + stats$blocks - stats$missed_fg -stats$missed_ft -stats$turnovers) / stats$games_played
sink(file = './hw03/output/efficiency-summary.txt')
summary(efficiency)
sink()

stats <- mutate(stats, efficiency = efficiency)

# Merging tables
teamstats <- merge(roster, stats, by.x = 'player', by.y = 'player')

# Creating nba2017-teams.csv
teams <- teamstats %>%
  group_by(team) %>%
  select(team, experience, salary, points3_made, points2_made, points1_made, points, off_rebounds, def_rebounds, assists, steals, blocks, turnovers, fouls, efficiency) %>%
  summarise(experience = round(sum(experience), 2),
            salary = round(sum(salary)/1000000, 2),
            points3 = sum(points3_made),
            points2 = sum(points2_made),
            free_throws = sum(points1_made),
            points = sum(points),
            off_rebounds = sum(off_rebounds),
            def_rebounds = sum(def_rebounds),
            assists = sum(assists),
            steals = sum(steals),
            blocks = sum(blocks),
            turnovers = sum(turnovers),
            fouls = sum(fouls),
            efficiency = sum(efficiency))

summary(teams)

sink(file = './hw03/output/teams-summary.txt')   
summary(teams)
sink()

write.csv(teams, "./hw03/data/nba2017-teams.csv", row.names=FALSE)

# Some graphics
pdf(file = './hw03/images/teams_star_plot.pdf')
stars(teams[ ,-1], labels = teams$team)
dev.off()

pdf(file = './hw03/images/experience_salary.pdf')
ggplot(data = teams, aes(x = experience, y = salary)) + geom_point(aes(color = team)) + geom_text(aes(label = team))
dev.off()

# Ranking of teams
# See Rmd file







