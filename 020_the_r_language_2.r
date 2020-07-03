# Subsetting 1

x <- c(0, 0, 0, 0, 1, 0, 0)
# index where x != 1
i <- which(x != 0)
# logical of TRUEs and FALSEs
l <- x != 0
# value that is != 0
v <- x[x!=0]


vec <- c(6, 1, 3, 6, 10, 5)

df <- data.frame(
  name = c("John", "Paul", "George", "Ringo"),
  birth = c(1942, 1940, 1943, 1942),
  instrument = c("guitar", "bass", "guitar", "drums"),
  stringsAsFactors = FALSE
)
df

vec[2]
vec[c(5, 6)]
vec[-c(5, 6)]
vec[vec > 5]

df[c(2, 4), 3]
df[, 1]
df[, "instrument"]
df$instrument
df$"instrument"

df[c(1, 1, 1, 2, 2), 1:3]
1:4
1:100

# internal representation of a matrix is a vector
mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)
# that's why this works (even if a matrix has 2 dimensions)
mat[2]

# data frames are internally stored as lists,
# that's why this will return the 2nd column
df[2]
class(df[2])
df[, 2]
class(df[, 2])

# names
names(vec) <- c("a", "b", "c", "d", "e", "f")
vec
vec[c("a", "b", "d")]

df[, "name"]
df$name

# logicals
vec[vec > 5]


# Exercise
# Write down as many ways to extract the name "John" from df:
df[1, 1]
df[1, -(2:3)]
df[1, -c(2, 3)]
df[1, "name"]
df[1, c(TRUE, FALSE, FALSE)]
df[-(2:4), 1]
df[-c(2, 3, 4), 1]
df["1", 1]
df[c(TRUE, FALSE, FALSE, FALSE), 1]
df[c(TRUE, FALSE, FALSE, FALSE), c(TRUE, FALSE, FALSE)]
df[c(TRUE, FALSE, FALSE, FALSE), "name"]
df[-(2:4), c(TRUE, FALSE, FALSE)]


# Subsetting of Lists
lst <- list(c(1, 2), TRUE, c("a", "b", "c"))
lst[1]
class(lst[1])

# single brackets return a list
lst[[1]]
class(lst[[1]])

# double brackets return a vector
sum(lst[[1]])
lst[[1]][2]

# using names returns a vector
names(lst) <- c("alpha", "beta", "gamma")
lst$alpha


# packages
#install.packages("ggplot2")
library(ggplot2)

# head()
diamonds[1:6, ]
head(diamonds)

# tail()
tail(diamonds)
last_row <- nrow(diamonds)
diamonds[(last_row - 5):last_row, ]

# View()
View(diamonds)

# help()
?diamonds
help(diamonds)

# plot diamonds x and y values
qplot(diamonds$x, diamonds$y)

# subselect outliers (x < 3 or y > 20)
diamonds[diamonds$x < 3 | diamonds$y > 20, ]

# group membership
1 %in% c(1, 2, 3, 4)
1 %in% c(2, 3, 4)

# are the values of c(1, 2, 3) members of the other vector?
c(1, 2, 3) %in% c(2, 3, 4, 5, 6)

# exclusive or is a function!
outliers <- xor(diamonds$x < 3, diamonds$y > 20)
diamonds[outliers, ]

# any() and all()
any(TRUE, FALSE, FALSE)
all(TRUE, FALSE, FALSE)

# Exercise
w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")

# Is w positive?
w > 0

# Is x greater than 10 and less than 20?
x > 10 & x < 20

# Is y a month name?
y %in% month.name

# Is every value of z a day of the week?
all(z %in% c(
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
))

# logical subsetting
x_zeroes <- diamonds$x == 0     # 54000 TRUEs and FALSEs!
diamonds[x_zeroes, ]

    # which are the big diamonds?
big <- diamonds[diamonds$x > 10, ]
big

str(diamonds)


# Missing Values

# mark values that are not plausible with NA
# NA is not comparable
5 > NA
3 == NA
NA == NA

# use is.na() to find out if you have NAs
is.na(NA)
is.na(c(1, 2, 3, NA, 5))

b <- c(1, 2, 3, NA, 5)

# use na.rm=TRUE to ignore NAs
sum(b, na.rm = TRUE)

# look at Min.
summary(diamonds$x)
# replace inplausible diamonds$x with NA
x_zeroes <- diamonds$x == 0     # x is 0
diamonds$x[x_zeroes] <- NA      # replace with NA
y_too_big <- diamonds$y > 20    # y > 20
diamonds$y[y_too_big] <- NA     # replace with NA
summary(diamonds$x)
diamonds[x_zeroes | y_too_big ,]
qplot(x, y, data = diamonds)
