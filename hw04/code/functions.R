# Function remove_missing()
remove_missing <- function(x) {
  x <- x[!is.na(x)]
  return(x)
}

#Function get_minimum()
get_minimum <- function(x, na.rm = TRUE) {
  if (is.numeric(x)==FALSE) {
    print("non-numeric argument")
  } else { 
    if (na.rm == TRUE) {
    x <- remove_missing(x)
    x <- sort(x)[1]
    } else {
    x <- sort(x, na.last = FALSE)[1]
    }
    return(x)
  }
}

# Function get_maximux()
get_maximum <- function(x, na.rm = TRUE) {
  if (is.numeric(x)==FALSE) {
    print("non-numeric argument")
  } else { 
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      x <- sort(x, decreasing = TRUE)[1]
    } else {
      x <- sort(x, decreasing = TRUE)[1]
    }
    return(x)
  }
}

# Function get_range()
get_range <- function(x, na.rm = TRUE) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      x <- get_maximum(x) - get_minimum(x)
    } else {
      x <- get_maximum(x) - get_minimum(x)
    }
    return(x)
  }
}

#Function get_percentile10()
get_percentile10 <- function(x, na.rm = TRUE) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      x <- quantile(x, .10, names = FALSE)
    } else {
      x <- quantile(x, .10, names = FALSE)
    }
    return(x)
  }
}

# Function get_percentile90()
get_percentile90 <- function(x, na.rm = TRUE){
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      x <- quantile(x, .90, names = FALSE)
    } else {
      x <- quantile(x, .90, names = FALSE)
    }
    return(x)
  }
}

#Function get_median()
get_median <- function(x, na.rm = TRUE) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
    x <- sort(remove_missing(x))
    if (length(x) %% 2 == 0) {
      x <- (x[length(x)/2] + x[length(x)/2+1])/2
    } else {
      x <- x[(length(x)+1)/2]
    }
    } else{
      x <- NA
    }
    return(x)
  }
}

# Function get_average()
get_average <- function(x, na.rm = TRUE) {
  s <- 0
  avg <- 0
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else{
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      for (i in 1:length(x)) {
        s <- s + x[i]
        avg <- s/i
      } 
    } else {
      for (i in 1:length(x)) {
        s <- s + x[i]
        avg <- s/i
      } 
    }
  } 
  return(avg)
}

# Function get_stdev()
get_stdev <- function(x, na.rm = TRUE) {
  s <- 0
  avg <- get_average(x, na.rm)
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else{
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      for (i in 1:length(x)) {
        s <- s + (x[i] - avg) ^ 2
      } 
    } else {
      for (i in 1:length(x)) {
        s <- s + (x[i] - avg) ^ 2
      } 
    } 
    s <- sqrt(s/(length(x)-1))
  } 
  return(s)
}

# Function get_quartile1()
get_quartile1 <- function(x, na.rm = TRUE) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      x <- quantile(x, names = FALSE) [2]
    } else {
      x <- quantile(x, names = FALSE) [2]
    }
    return(x)
  }
}

# Function get_quartile3()
get_quartile3 <- function(x, na.rm = TRUE) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    if (na.rm == TRUE) {
      x <- remove_missing(x)
      x <- quantile(x, names = FALSE) [4]
    } else {
      x <- quantile(x, names = FALSE) [4]
    }
    return(x)
  }
}

# Function count_missing()
count_missing <- function(x) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    x <- sum(is.na(x))
  }
  return(x)
}

# Function summary_stats()
summary_stats <- function(x) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    x <- list(minimum = get_minimum(x),
              percent10 = get_percentile10(x),
              quartile1 = get_quartile1(x),
              median = get_median(x),
              mean = get_average(x),
              quartile3 = get_quartile3(x),
              percent90 = get_percentile90(x),
              maximum = get_maximum(x),
              range = get_range(x),
              stdev = get_stdev(x),
              missing = count_missing(x))
  }
  return(x)
}

# Function print_stats()
print_stats <- function(x) {
  numx <- 1:length(x)
  names <- names(x)
  for (i in 1: length(x)) {
    numx[i] <- sprintf("%.4f", x[[i]])
    spaces <- paste(rep(" ", 9 - nchar(names[i])), collapse = "")
    cat(paste0(names[i], spaces, ":", " ", numx[i], '\n'))
  }
}

# Function drop_lowest()
drop_lowest <- function(x) {
  if (is.numeric(x) == FALSE) {
    print("non-numeric argument")
  } else {
    a <- which.min(x)
    x <- x[-a]
  }
  return(x)
}


# Function rescale100()
rescale100 <- function(x, xmin, xmax) {
  z <- 100 * (x - xmin) / (xmax - xmin)
  return(z)
}

# Function score_homework()
score_homework <- function(x, drop = TRUE) {
  if (drop == TRUE) {
    x <- drop_lowest(x)
  } 
  x <- get_average(x)
  return(x)
}

# Function score_quiz()
score_quiz <- function(x, drop = TRUE) {
  if (drop == TRUE) {
    x <- drop_lowest(x)
  }
  x <- get_average(x)
  return(x)
}

# Function score_lab()
score_lab <- function(x) {
  if (x >= 11) {
    x <- 100
  } else if ( x == 10) {
    x <- 80
  } else if ( x == 9) {
    x <- 60
  } else if ( x == 8) {
    x <- 40
  } else if ( x == 7) {
    x <- 20
  } else {
    x <- 0
  }
  return(x)
}








