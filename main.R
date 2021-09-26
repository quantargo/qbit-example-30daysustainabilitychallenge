library(meme)
library(rtweet)
library(magick)

image_pool <- c(
  "https://unsplash.com/photos/ficbiwfOPSo/download?force=true&w=1920",
  "https://unsplash.com/photos/ZKWgoRUYuMk/download?force=true&w=1920",
  "https://unsplash.com/photos/ICNI2HX2Wvo/download?force=true&w=1920",
  "https://unsplash.com/photos/w_a40DuyPAc/download?force=true&w=1920",
  "https://unsplash.com/photos/nyL-rzwP-Mk/download?force=true&w=1920",
  "https://unsplash.com/photos/V4ZYJZJ3W4M/download?force=true&w=1920",
  "https://unsplash.com/photos/pMa9_85NqMQ/download?force=true&w=1920")


# Create meme background from random unsplash photos
meme_source_fname <- "meme_source.jpg"
image_source <- sample(image_pool, 1) %>% 
  image_read() %>%
  image_scale(geometry = geometry_size_pixels(width = 1200, height = 675, preserve_aspect = TRUE)) %>%
  image_crop(geometry = geometry_area(width = 1200, height = 675, x_off = 0, y_off = 0), gravity = NULL) %>%
  image_write(meme_source_fname)

enddate <- as.Date("2021-10-27")

countdown <- enddate - Sys.Date()
text <- if(countdown > 30) {
  sprintf("Starting in %d days.", as.Date("2021-09-27") - Sys.Date())
} else if (countdown == 30) {
  "Starting Today!"
} else if (countdown < 30 && countdown > 0) {
  sprintf("%s Days left!")
} else {
  sprintf("Challenge ended on %s.", format(enddate, "%b %d, %Y"))
}

image_meme <- meme(meme_source_fname, 
                   upper = "#30DaySustainability\nDataChallenge", 
                   lower = text,
                   size = 6, 
                   color = "white", 
                   r = 0.4,
                   vjust = 0.1)

meme_save(image_meme, file="meme.jpg")

# Send Meme via Twitter
token <- create_token(
  app = "QuantargoBot",
  consumer_key = Sys.getenv("TWITTER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_SECRET")
)

workspace_link <- "https://www.quantargo.com/qbits/qbit-example-30daysustainabilitychallenge"
tweet_status <- sprintf("#30DaySustainabilityDataChallenge countdown. %s %s. #rstats @datasciconf", text, workspace_link)

post_tweet(status = "#30DaySustainabilityDataChallenge countdown. #rstats #sustainability.", 
           media = "meme.jpg",
           token = token)
