module War where
import Data.List

type Game = [Card]
type Card = (Type,Suit)
data Type = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace deriving (Show)
data Suit = Hearts | Diamonds | Clubs | Spades deriving (Show)

getCardVal :: Card -> Int
getCardVal (Two,_)   = 2
getCardVal (Three,_) = 3
getCardVal (Four,_)  = 4
getCardVal (Five,_)  = 5
getCardVal (Six,_)   = 6
getCardVal (Seven,_) = 7
getCardVal (Eight,_) = 8
getCardVal (Nine,_)  = 9
getCardVal (Ten,_)   = 10
getCardVal (Jack,_)  = 11
getCardVal (Queen,_) = 12
getCardVal (King,_)  = 13
getCardVal (Ace,_)   = 14
