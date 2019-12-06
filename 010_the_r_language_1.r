## R Basics

# variable assignments
x <- 1
foo <- round(3.1415) + 1

# built-in functions
round(3.1415)
factorial(3)
sqrt(9)
factorial(foo)

# remove an object
rm(foo)

# built-in dataset
WorldPhones

# vector
vec <- c(1, 2, 3, 10, 100)
vec

# matrix
mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)
mat

# vector arithmetic
vec + 4
vec * 4
# multiply with another vector
vec * vec

# matrix multiplication
vec %*% vec     # inner
vec %o% vec     # outer

# transposing matrices
mat
t(mat)

# arrays
a1 <- array(c(1, 2, 3, 4, 5, 6), dim = c(2, 2, 3))
a1

a2 <- array(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12), dim = c(2, 2, 3))
a2


## Four Basic Data Types

# 1. numeric
class(0.111)

# 2. character
class("hello")
nchar("hello")
paste("hello", "world")

# 3. logical
class(TRUE)
3 < 4
class(T)

# 4. factor
fac <- factor(c("a", "b", "c", "a", "a", "c"))
fac
class(fac)

# vector has ONE data type!
vec <- c(1, "R", TRUE)
class(vec)
vec

# coersion
c(5, "two")
c(TRUE, "a")
c(TRUE, 5)
TRUE + 5
TRUE + FALSE
sum(c(TRUE, TRUE, FALSE, TRUE, TRUE))   # counts TRUEs
mean(c(TRUE, TRUE, FALSE, TRUE, TRUE))  # proportion of TRUEs

# manual coersion with functions
as.numeric(TRUE)
as.character(TRUE)
as.logical(0)
as.factor(c("a", "b", "a"))

# matrix has also only ONE data type
mat2 <- matrix(c(1, 2, 3, "R", "S", "T", TRUE, FALSE, TRUE), nrow = 3)
mat2


# Lists and Data Frames

lst <- list(1, "R", TRUE)
lst
class(lst)

# list containing other vectors
list(c(1, 2), TRUE, c("a", "b" , "c"))


# Data Frame

df <- data.frame(c(1, 2, 3),
                 c("R", "S", "T"),
                 c(TRUE, FALSE, TRUE))

df

# Names

# named vector
# names set during vector creation
nvec <- c(one = 1, two = 2, three = 3)
nvec
names(nvec)
# set names after object creation
names(nvec) <- c("eins", "zwei", "drei")
nvec

# naemed list
nlst <- list(
  numbers = c(1, 2),
  logicals = TRUE,
  letters = c("a", "b" , "c")
)

nlst
names(nlst)
nlst$letters

# named data frame
ndf <- data.frame(
  numbers = c(1, 2, 3, 4),
  letters = c("R", "S", "T", "U"),
  logicals = c(TRUE, FALSE, TRUE, TRUE)
)

ndf
names(ndf)
dim(ndf)
nrow(ndf)
ncol(ndf)
