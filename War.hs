module War where
import Data.List
import System.IO.Unsafe                                       
import System.Random

type Game = (Hand,Hand)
type Deck = [Card]
type Hand = [Card]
type Card = (Type,Suit)
data Type = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace deriving (Show,Eq)
data Suit = Hearts | Diamonds | Clubs | Spades deriving (Show,Eq)

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

deal :: Deck -> Hand -> Hand -> Game
deal [] p1 p2 = (p1,p2)
deal [c1,c2] p1 p2  = (c1:p1,c2:p2)
deal deck p1 p2 = 
    let rand1 = unsafePerformIO $ getStdRandom (randomR (0,(length deck)-1))
        diffRand = let rand2 = unsafePerformIO $ getStdRandom (randomR (0,(length deck)-1))
                   in if rand2==rand1 then diffRand else rand2
        new1 = (deck!!rand1):p1
        new2 = (deck!!diffRand):p2
        newDeck = [card | card <- deck,(not $ card `elem` new1),(not $ card `elem` new2)]
    in  deal newDeck new1 new2

play :: Game -> Game
play game@(h1@(p1:p1s),h2@(p2:p2s)) =
    let card1 = getCardVal p1
        card2 = getCardVal p2
        war :: Game -> Game
        war game = undefined
    in  if      card1>card2 then (p2:h1,[card | card <- h2,card /= p2])
        else if card2>card1 then ([card | card <- h1,card /= p1],p1:h2)
        else war game
