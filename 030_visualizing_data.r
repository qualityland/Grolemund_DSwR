## Visualizing Data


# gg - grammar of graphics
# aesthetics           - color, shape, alpha
# faceting             - facet_grid, facet_wrap
# geoms                - barchart, histogram, point, smooth
# position adjustments - stack, dodge, identity, fill, jitter



# basic R plot
plot(iris$Sepal.Width, iris$Sepal.Length)

# same with ggplot2's qplot()
library(ggplot2)

qplot(iris$Sepal.Width, iris$Sepal.Length)

# species in different color
qplot(Sepal.Width, Sepal.Length, data = iris, color=Species)


## Aesthetics

# color, fill, alpha, shape, size, linetype

# mpg
?mpg
head(mpg)
tail(mpg)

# qplot
qplot(displ, hwy, data = mpg)
# set color to a discrete/categorical variable
qplot(displ, hwy, data = mpg, color = class)
# only 6  shapes - SUVs will not be plotted
qplot(displ, hwy, data = mpg, shape = class)
# set color to a contiuous variable
qplot(displ, hwy, data = mpg, color = cty)

## Faceting

# facet into columns by cylinders
qplot(displ, hwy, data = mpg) +
  facet_grid(. ~ cyl)

# facet into rows by drive (front, rear, 4-wheel)
qplot(displ, hwy, data = mpg) +
  facet_grid(drv ~ .)

# facet into a grid of drive / cylinders
qplot(displ, hwy, data = mpg) +
  facet_grid(drv ~ cyl)

# facet by class and wrap at end of line
qplot(displ, hwy, data = mpg) +
  facet_wrap(~ class)

## Geoms

# barchart, histogram, point (scatterplot), smooth (smoothed mean)

# Default geoms in ggplot2:
# 1. One categorical variable - Bar Chart
# 2. One contiuous variable   - Histogram
# 3. Two continuous variables - Scatterplot
# 4. One continuous, one categorical variable - Boxplot


# Scatterplot and Smoothed Mean
#
# same contious variables (displ, hwy)
# but different geom:
qplot(displ, hwy, data = mpg, geom = "point")               # scatter plot
qplot(displ, hwy, data = mpg, geom = "smooth")              # smoothed mean  
qplot(displ, hwy, data = mpg, geom = "smooth", se=FALSE)    # smoothed mean w. standard deviation
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))  # both, smoothed mean and basis data

# Boxplot
#
# contiuous vs. categorical variable
# use geom = "boxplot"
qplot(class, hwy, data = mpg, geom = "boxplot")
# median          - line in middle of box where 50% of values fall below
# 25th percentile - lower box line where 25% of values fall below
# 75th percentile - upper box line where 75% of values fall below
# 25th - 75th box - inter-quartile range IQR (common values)
# whiskers        - 1.5 times the IQR / box height (typical values)
# everything else - outliers

# reorder class (categorical variable) by mean of hwy
qplot(reorder(class, hwy), hwy, data = mpg, geom = "boxplot")
# use median() as reorder function, instead of mean()
qplot(reorder(class, hwy, FUN=median), hwy, data = mpg, geom = "boxplot")

# further reading: ggplot2 website
# https://ggplot2.tidyverse.org/reference/



# Bar Charts
#
# scatter plot (two continuous variables)
qplot(x, z, data = diamonds)

# histogram (one continuous variable)
qplot(x, data = diamonds)

# bar chart (one categorical variable)
qplot(cut, data = diamonds)

# fill color
qplot(cut, data = diamonds, fill = cut)
# CAVE! 'color' stands for outline color
qplot(cut, data = diamonds, color = cut)


## Position Adjustments

# stack - on top of each other
# dodge - side by side (barchart in a barchart)
# identity - overlaping each other (biggest hiding others)
# fill - displays proportions
# jitter - displays points that overlap / hide each other

qplot(color, data = diamonds, geom = "bar", fill = cut)

# 'position' parameter for qplot() is deprecated, but this works:

# different cuts stacked on each other
ggplot(diamonds, aes(color, fill = cut)) +
  geom_bar(position = "stack")

# different cuts (for each color) side by side
ggplot(diamonds, aes(color, fill = cut)) +
  geom_bar(position = "dodge")

# different cuts on top of each other (biggest cover smaller ones)
ggplot(diamonds, aes(color, fill = cut)) +
  geom_bar(position = "identity")

# displays proportions between different groups
ggplot(diamonds, aes(color, fill = cut)) +
  geom_bar(position = "fill")


# jitter e.g. rounded data
qplot(cty, hwy, data = mpg)
# in this case jitter each point (add random noise)
qplot(cty, hwy, data = mpg, geom = "jitter")


## Histograms

# visualize distributions of continuoous data

# binwidth (parameter)

# different binwidth's show different aspects of your data
qplot(carat, data = diamonds, binwidth = 1)
qplot(carat, data = diamonds, binwidth = 0.1)
qplot(carat, data = diamonds, binwidth = 0.01)
qplot(carat, data = diamonds, binwidth = 0.003)
# default: range of x-data / 30
qplot(carat, data = diamonds)

# adding a variable to your data
# (here: dependency of depth by cut)
qplot(depth, data = diamonds, binwidth = 0.2)
# zooming in
zoom <- coord_cartesian(xlim = c(55, 70))
qplot(depth, data = diamonds, binwidth = 0.2) + zoom

# depth for each cut
qplot(depth, data = diamonds, binwidth = 0.2, fill = cut) + zoom

# facetting
qplot(depth, data = diamonds, binwidth = 0.2) + zoom + 
  facet_wrap(~ cut)

# facetting with frequency polygrams
qplot(depth, data = diamonds, binwidth = 0.2, geom = "freqpoly", color = cut) + zoom + 
  facet_wrap(~ cut)

# all frequency polygrams in one diagram
# difficult to see where different cuts peak
# since there are so many 'ideal' and few 'fair' cut diamonds
qplot(depth, data = diamonds, geom = "freqpoly", color = cut, binwidth = 0.2) + zoom

# geom density (area of each curve is 1)
# better shows where different cuts peak in depth
qplot(depth, data = diamonds, geom = "density", color = cut) + zoom

# exercise: distribution of price for the different cuts of diamonds
qplot(price, data = diamonds) + facet_wrap(~ cut)
qplot(price, data = diamonds, geom = "freqpoly", color = cut) + facet_wrap(~ cut)
qplot(price, data = diamonds, color = cut, geom = "freqpoly", binwidth = 100)
qplot(price, data = diamonds, color = cut, geom = "density")
# why do fair cut diamonds peak at a higher price than the ones with a better cut?
qplot(carat, price, data = diamonds, geom = "density2d") + facet_wrap(~ cut)
# because bigger diamonds have an inferior cut (to retain mass)

# this can also be visualized with geom 'bin2d'
qplot(carat, price, data = diamonds, geom = "bin2d")
# or 'hexbin'
install.packages("hexbin")
qplot(carat, price, data = diamonds, geom = "hex")

# overlay raw data with density information (using two geoms)
qplot(carat, price, data = diamonds, geom = c('point', 'density2d'))

# 'smooth'
qplot(carat, price, data = diamonds, geom = 'smooth')
# separate for each cut
# shows that fair cut diamonds sell for less, but the bigger ones
# are fair cut
qplot(carat, price, data = diamonds, color = cut, geom = 'smooth')
# without standard error
qplot(carat, price, data = diamonds, color = cut, geom = 'smooth', se = FALSE)



# this does NOT change point color to blue!
qplot(carat, price, data = diamonds, color = "blue")
# mapping an aesthetic (color) not to data, but manually to 'blue'
# I() stands for 'as-is'

# manually setting an aesthetic
# like size or transparency
qplot(carat, price, data = diamonds, size = I(0.5))
qplot(carat, price, data = diamonds, alpha = I(0.1))
qplot(carat, price, data = diamonds, alpha = I(0.05), size = I(0.5))


# saving graphs

# what is my working directory?
getwd()

# save the last plot to your working directory
ggsave("myplot.pdf")
# and specify file type and size in inches
ggsave("myplot.png", width = 6, height = 6)

