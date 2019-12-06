library(ggplot2)
library(maps)

## Adjusting Graphs

# show map as scatterplot
texas <- read.csv("./data/texas.csv")
qplot(long, lat, data = texas)

# show map as polygon
# every county is a separate polygon (group)
# order column ensures correct presentation
qplot(long, lat, data = texas, geom = "polygon", group = group)

# map of all US counties
counties <- map_data("county")
qplot(long, lat, data = counties, geom = "polygon", group = group, fill = group)
help(package = "maps")

# exercise: texas map with fill dependent on 'bin'
qplot(long, lat, data = texas, geom = "polygon", group = group, fill = bin)
