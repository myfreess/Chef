{-# LANGUAGE ViewPatterns #-}

module Fmt where

import Color
import Brc

fmtWithColor :: String -> Color -> String
fmtWithColor s (serial -> n) | n < 0 = undefined
-- 根据序列号进行染色处理
            | n == 0 = "\x1b[31m" ++ s ++ "\x1b[0m"
            | n == 1 = "\x1b[32m" ++ s ++ "\x1b[0m"
            | n == 2 = "\x1b[33m" ++ s ++ "\x1b[0m"
            | n == 3 = "\x1b[34m" ++ s ++ "\x1b[0m"
            | n == 4 = "\x1b[35m" ++ s ++ "\x1b[0m"

fmtBrcL, fmtBrcR :: Brc -> String
fmtBrcL b   | b == Round = "("
            | b == Curly = "{"
            | b == Square = "["

fmtBrcR b   | b == Round = ")"
            | b == Curly = "}"
            | b == Square = "]"


fmtBracket :: RTree (Color, Brc)-> String
fmtBracket (CNode (c,x) Empty) = ((fmtBrcL x) `fmtWithColor` c) ++ ((fmtBrcR x) `fmtWithColor` c)
fmtBracket (CNode (c,x) (Some e)) = ((fmtBrcL x) `fmtWithColor` c) ++ fmtBracket e ++ ((fmtBrcR x) `fmtWithColor` c)
fmtBracket (CNode (c,x) (Segment p l e)) = ((fmtBrcL x) `fmtWithColor` c) ++ fmtBracket p ++ concatMap fmtBracket l ++ fmtBracket e ++ ((fmtBrcR x) `fmtWithColor` c)