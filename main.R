library(meme)
library(rtweet)
library(showtext)

font_add_google("Anton", "anton")

# Create Meme
image_source <- "http://i0.kym-cdn.com/entries/icons/mobile/000/000/745/success.jpg"
image_meme <- meme(image_source, 
                   upper = "Happy friday!", 
                   lower = "Wait, sorry, it's tuesday", 
                   font = "Anton",
                   size = 3)

meme_save(image_meme, file="meme.png")

# Send Meme via Twitter
token <- create_token(
  app = "QuantargoBot",
  consumer_key = Sys.getenv("TWITTER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_SECRET")
)

post_tweet(status = "Happy Friday! https://next.quantargo.com/qbits/qbit-meme-test-2-Dvk7V45BV/app/main.R", token = token)

