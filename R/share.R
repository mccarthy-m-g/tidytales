here::i_am("R/share.R")
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

# Compose Twitter summary card for post----------------------------------------
# tidytales/_posts/2021-06-09_demons-souls/demons_souls_files/figure-html5
# //
library(magick)

get_twitter_card <- function(theme) {
  if (theme == "light") {
    image_read(here("inst", "images", "twittercard-light.png"))
  } else if (theme == "dark") {
    image_read(here("inst", "images", "twittercard-dark.png"))
  }
}

get_hero_image <- function(path, resize, colour = "none") {

  hero <- image_read(path)

  if (resize == "width") {
    geometry <- "500x" # Resize width to 500 keep aspect ratio
  } else if (resize == "height") {
    geometry <- "x500" # Resize height to 500 keep aspect ratio
  }

  canvas <- image_blank(width = 1200, height = 628, color = colour)
  hero <- image_resize(hero, geometry, filter = "Lanczos")

  # Calculate offset based on resize dimensions
  hero_width <- image_info(hero)$width
  offset_x <- 50 + ((500 - hero_width) / 2)
  hero_height <- image_info(hero)$height
  offset_y <- 64 + ((500 - hero_height) / 2)
  offset_amount <- paste0("+", offset_x, "+", offset_y)

  image_composite(canvas, hero, operator = "Over", offset = offset_amount)
}

# Function to create Twitter summary cards
compose_twitter_card <- function(path,
                                 theme = "light",
                                 resize = "width") {
  twitter_card <- get_twitter_card(theme)
  colour <- ifelse(theme == "light", "#123C69", "#FFF5ED")
  hero_image <- get_hero_image(path = path, resize = resize, colour = colour)
  image_composite(hero_image, twitter_card, operator = "Over") %>%
    image_flatten()
}

compose_twitter_card(
  path = "",
  resize = "height"
  ) %>%
  image_write(
    path = "",
    format = "png"
    )
