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

war :: Game -> Int -> Game
war (p1,p2) size
    | card1 > card2 = (l1++w1++w2,l2)
    | card1 < card2 = (l1,l2++w2++w1)
    | otherwise =
        case (null l1,null l2) of
            (True,True)   -> ([],[])
            (True,False)  -> ([],l2++w2++w1)
            (False,True)  -> (l1++w1++w2,[])
            (False,False) -> war (l1,l2) size
    where
        (l1,l2) = (drop (length w1) p1,drop (length w2) p2)
        getWarCards :: Hand -> Hand
        getWarCards hand 
          | (length hand) >= size = take size hand
          | otherwise = hand
        (w1,w2) = (getWarCards p1,getWarCards p2)
        (card1,card2) = (getCardVal $ last w1,getCardVal $ last w2)
play :: Game -> Int -> Game
play game@(h1@(p1:p1s),h2@(p2:p2s)) warSize
    | card1>card2 = (p1s++[p1,p2],[card | card <- h2,card /= p2])
    | card2>card1 = ([card | card <- h1,card /= p1],p2s++[p2,p1])
    | otherwise = war game warSize
    where (card1,card2) = (getCardVal p1,getCardVal p2)
