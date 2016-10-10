module Main(main) where

import Graphics.Gloss

import State
import Renderer
import Logic
import System.Random

window :: Display
window = InWindow "Nice Window" (1280, 768) (200, 200)

background :: Color
background = black
fps = 60
    
main :: IO ()
main = do
  seed <- newStdGen
  play window background fps (initialGameState seed) render handleEvent updateGameState