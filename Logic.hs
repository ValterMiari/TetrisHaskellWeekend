-- Logic module
-- Functions for updating game state and responding to user input

module Logic(updateGameState, handleEvent) where

import State
import Piece
import Playfield
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game -- for Event

-- Piece falling velocity, in cells/second
pieceVelocity :: Float
pieceVelocity = 1.5

-- Time to wait before dropping piece again
piecePeriod :: Float
piecePeriod = 1.0 / pieceVelocity

handleEvent :: Event -> State -> State
handleEvent _ s = s

-- Update function passed to gloss
updateGameState :: Float -> State -> State
updateGameState t s = unityStyleUpdate (s {time = t, deltaTime = t - (time s)})

-- my update function
unityStyleUpdate :: State -> State
unityStyleUpdate s
  | secondsToNextMove stateWithUpdatedClocks <= 0 = applyMove stateWithUpdatedClocks
  | otherwise                                     = stateWithUpdatedClocks
    where
      stateWithUpdatedClocks = s {secondsToNextMove = (secondsToNextMove s) - (deltaTime s)}
  
-- Moves the current piece one cell down
applyMove :: State -> State
applyMove s
  | validPos piecePos' (piece s) == False = fixPiece s 
  | otherwise                             = s {piecePos = piecePos'}
    where
      piecePos' = (fst (piecePos s), snd (piecePos s) - 2) -- cell is 2 units

-- Fixes the falling piece to its current position and resets the piece to a new one
fixPiece :: State -> State
fixPiece s = s
  { well = renderPiece (piece s) (piecePos s) (well s)
  , piece = tetrominoO
  , piecePos = (0, 0)
  }




