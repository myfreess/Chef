{-# LANGUAGE DeriveFunctor #-}

module Brc where

data Segment a = Empty
               | Some a
               | Segment a [a] a
               deriving (Show, Functor)

data RTree a = RNode a [RTree a]
             | CNode a (Segment (RTree a))
             deriving (Show, Functor)

data Brc = Square | Round | Curly deriving (Show, Eq)

