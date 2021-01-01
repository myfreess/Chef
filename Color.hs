

module Color where


newtype Color = Color { serial :: Int } deriving (Show, Eq)


red = Color 0
green = Color 1
yellow = Color 2
blue = Color 3
magenta = Color 4

colors = [red, green, yellow, blue, magenta]
















