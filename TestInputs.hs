module TestInputs where
import War
import Data.List

--assemble w/ [(a,b) | a <- [Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Jack,Queen,King,Ace],b <- [Hearts,Diamonds,Clubs,Spades]]
deck :: Deck
deck = [(Two,Hearts),(Two,Diamonds),(Two,Clubs),(Two,Spades),
        (Three,Hearts),(Three,Diamonds),(Three,Clubs),(Three,Spades),
        (Four,Hearts),(Four,Diamonds),(Four,Clubs),(Four,Spades),
        (Five,Hearts),(Five,Diamonds),(Five,Clubs),(Five,Spades),
        (Six,Hearts),(Six,Diamonds),(Six,Clubs),(Six,Spades),
        (Seven,Hearts),(Seven,Diamonds),(Seven,Clubs),(Seven,Spades),
        (Eight,Hearts),(Eight,Diamonds),(Eight,Clubs),(Eight,Spades),
        (Nine,Hearts),(Nine,Diamonds),(Nine,Clubs),(Nine,Spades),
        (Ten,Hearts),(Ten,Diamonds),(Ten,Clubs),(Ten,Spades),
        (Jack,Hearts),(Jack,Diamonds),(Jack,Clubs),(Jack,Spades),
        (Queen,Hearts),(Queen,Diamonds),(Queen,Clubs),(Queen,Spades),
        (King,Hearts),(King,Diamonds),(King,Clubs),(King,Spades),
        (Ace,Hearts),(Ace,Diamonds),(Ace,Clubs),(Ace,Spades)]

testGame1 :: Game
testGame1 = ([(Two,Hearts)],[(Four,Diamonds)])

testGame2 :: Game
testGame2 = ([(Four,Hearts)],[(Two,Diamonds)])

warGame1 :: Game
warGame1 = ([(Four,Hearts)],[(Four,Diamonds)])

warGame2 :: Game
warGame2 = ([(Two,Hearts),(Seven,Hearts),(King,Hearts),(Jack,Hearts),(Ace,Hearts)],
            [(Two,Diamonds),(Seven,Clubs),(Six,Clubs),(Nine,Diamonds),(Eight,Diamonds)])
