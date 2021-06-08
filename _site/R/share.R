here::i_am("R/submit.R")
library(here)

# Create images of source code with carbon.js ---------------------------------
# template = "night-owl",
# font_family = "Hack",
# palette = c(r = 31, g = 129, b = 109, a = 1)
#
# template = "synthwave-84",
# font_family = "Hack",
# palette = c(r = 10, g = 26, b = 51, a = 1)
library(carbonate)
carbon_script <- function(path,
                          template = "lucario",
                          font_family = "Hack",
                          palette = c(r = 130, g = 142, b = 151, a = 100)) {
  # Read source code
  code <- readLines(path)
  x <- carbon$new(code)

  # Apply theme arguments
  x$template <- template
  x$font_family <- font_family
  x$palette <- palette

  # Open URL in browser
  browseURL(x$uri())
}
