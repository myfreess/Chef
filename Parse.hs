module Parse where

import Prelude hiding (round)
import Control.Monad
import Control.Applicative
import Data.List
import Data.Char
import Brc

newtype Parser val = Parser { parse :: String -> [(val, String)]  }

parseCode :: Parser a -> String -> a
parseCode m s = case parse m s of
  [(res, [])] -> res
  _           -> error "Hugh?"
--

instance Functor Parser where
  fmap f (Parser ps) = Parser $ \p -> [ (f a, b) | (a, b) <- ps p ]
--

instance Applicative Parser where
  pure = return
  (Parser p1) <*> (Parser p2) = Parser $ \p ->
    [ (f a, s2) | (f, s1) <- p1 p, (a, s2) <- p2 s1 ]
--

instance Monad Parser where
  return a = Parser $ \s -> [(a, s)]
  p >>= f  = Parser $ concatMap (\(a, s1) -> f a `parse` s1) . parse p
--

instance MonadPlus Parser where
  mzero     = Parser $ const []
  mplus p q = Parser $ \s -> parse p s ++ parse q s
--

instance Alternative Parser where
  empty   = mzero
  p <|> q = Parser $ \s -> case parse p s of
    [] -> parse q s
    rs -> rs
--

item :: Parser Char
item = Parser $ \s -> case s of
  [     ] -> []
  (h : t) -> [(h, t)]
--

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = item >>= \c -> if p c then return c else empty

char :: Char -> Parser Char
char = satisfy . (==)

square, round, curly :: Parser (RTree Brc)
square = do { char '[';
              l <- many bracket;
	      char ']';
	      return $ RNode Square l; }

round = do { char '(';
             l <- many bracket;
	     char ')';
	     return $ RNode Round l; }

curly = do { char '{';
             l <- many bracket;
	     char '}';
	     return $ RNode Curly l; }

bracket :: Parser (RTree Brc)
bracket = square <|> curly <|> round




