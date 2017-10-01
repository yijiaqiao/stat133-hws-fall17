nba2017-player-statistics-dictionary
================
Yijia Qiao
9/29/2017

Data `nba2017-player-statistics.csv`
------------------------------------

Here's the description of the R objects in `nba2017-player-statistics.csv`:

| Column        | Description                                                |
|---------------|------------------------------------------------------------|
| Player        | first and last names of player                             |
| Team          | 3-letter team abbreviation                                 |
| Position      | player's position                                          |
| Experience    | years of experience in NBA (a value of R means rookie)     |
| Salary        | player salary in dollars                                   |
| Rank          | Rank of player in his team                                 |
| Age           | Age of Player at the start of February 1st of that season. |
| GP            | Games Played during regular season                         |
| GS            | Games Started                                              |
| MIN           | Minutes Played during regular season                       |
| FGM           | Field Goals Made                                           |
| FGA           | Field Goal Attempts                                        |
| Points3       | 3-Point Field Goals                                        |
| Points3\_atts | 3-Point Field Goal Attempts                                |
| Points2       | 2-Point Field Goals                                        |
| Points2\_atts | 2-Point Field Goal Attempts                                |
| FTM           | Free Throws Made                                           |
| FTA           | Free Throw Attempts                                        |
| OREB          | Offensive Rebounds                                         |
| DREB          | Defensive Rebounds                                         |
| AST           | Assists                                                    |
| STL           | Steals                                                     |
| BLK           | Blocks                                                     |
| TO            | Turnovers                                                  |

The `Points3` and `Points3_atts` have different values as the latter one is how many attempts the player made. Similarly for the `Points2` and `Points2_atts`.

The value of `points` result from adding all points2 and points3

``` r
1 * FTM + 2 * Points2 + 3 * Points3
```

The data is about NBA 2017 statistics. (see [NBA](www.basketball-reference.com) for more details)

Here is a sample data of [GS Warriors statistics for 2017](https://www.basketball-reference.com/teams/GSW/2017.html)
