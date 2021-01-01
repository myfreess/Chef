{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE ViewPatterns #-}

module Tactic where

import Brc
import Color
import Control.Monad

without :: (Eq a) => [a] -> a -> [a]
without l c = filter (/= c) l

twist :: [a] -> [a]
twist l = tail l ++ [head l] 

safeCast :: [a] -> Segment (a,[a])
safeCast [] = Empty
safeCast (x:xs) = Some (x, xs)

reGroup :: [a] -> Segment a
reGroup (safeCast -> Empty) = Empty
reGroup (safeCast -> Some (x, xs)) =
    case xs of
    ![] -> Some x
    _ -> Segment x mid y where
        (!mid, !y) = go id xs
	go acc [x] = (acc [], x)
	go acc (e:l) = go (acc . (e:)) l
        
walkRTree :: RTree a -> RTree a
walkRTree ~(RNode x l) = CNode x $ fmap walkRTree (reGroup l)


-- 如果继续使用RNode， 可以实现一个简版的dyeing函数
-- 实际上效果可能是更好了
dyeing :: Color -> [Color] -> RTree a -> RTree (Color,a)
dyeing c t (CNode x Empty) = CNode (c,x) Empty
dyeing c t (CNode x (Some sub)) = CNode (c,x) (Some $ dyeing (head (t `without` c)) (twist t) sub)
dyeing c t (CNode x (Segment p [] e)) = CNode (c,x) $ Segment (dyeing cp (twist t) p) [] (dyeing ce (twist (twist t)) e) where
    table = t `without` c
    cp = head table
    ce = (head (twist table))
-- length l 较大时染色较均匀
dyeing c t (CNode x (Segment p l e)) = CNode (c, x) $ Segment (dyeing c' (twist t) p) (go l table' t) (dyeing c' (twist t) e) where
    table = t `without` c
    c' = head table
    table' = t `without` c'
    go [] r t = []
    go (x:xs) r t = (:) (dyeing (head r) t x) (go xs (twist r) (twist t))

draw :: RTree a -> RTree (Color,a)
draw = dyeing magenta colors . walkRTree
