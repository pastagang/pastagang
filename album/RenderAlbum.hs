#!/usr/bin/env cabal
{- cabal:
build-depends: base, cassava, bytestring, vector
-}
-- \|
-- Run this script to format the album csv export
-- Get cabal-install and ghc with https://www.haskell.org/ghcup/
import qualified Data.ByteString.Lazy as BS
import Data.Csv
import qualified Data.Vector as V

type Track = (Int, String, String, String, String, String)

toMarkdown :: Track -> String
toMarkdown (_, datetime, code, hash, _, _) =
    mconcat ["- <https://strudel.cc/?", hash, "> ", title]
  where
    title = takeWhile (/= '@') $ head $ lines code
    date = take 10 datetime

main :: IO ()
main = do
    entries <- decode HasHeader <$> BS.readFile "code_v1_rows.csv"
    case entries of
        Left e -> error e
        Right xs -> putStrLn $ unlines $ map toMarkdown $ V.toList xs
