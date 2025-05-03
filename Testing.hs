module Testing where
import War
import TestInputs
import Data.List
import Data.Semigroup
import Test.Grader.Tests
import Test.Grader.Core
import Test.Grader.Eval
import Test.Grader.Rubric
import Control.Monad.Extra
import Control.Monad.Trans.RWS
import System.IO.Unsafe
import Data.Maybe

gameToDeck :: Game -> Deck
gameToDeck (p1,p2) = p1++p2

occursOnce :: Eq a => [a] -> a -> Bool
occursOnce lst a = (length [e | e <- lst,e==a])==1

testDeal :: Grader String
testDeal = assess "deal" 0 $ do 
    check "that deal creates the right length" $ all (==52) [length $ gameToDeck game | game <- decks] `shouldBe` True
    check "that deal doesn't contain dupes" $ all noDupes decks `shouldBe` True
    where
        decks :: [Game]
        decks = [deal deck [] [] | i <- [1..100]]
        noDupes :: Game -> Bool
        noDupes ([],[]) = True
        noDupes (h1,h2) = 
            if (length h1)==(length h2) then
                all id ([(not $ c `elem` h2)&&(occursOnce h1 c) | c <- h1]++[(not $ c `elem` h1)&&(occursOnce h2 c) | c <- h2])
            else error "lists are of unequal length"

testWar :: Grader String
testWar = assess "war" 0 $ do
        check "that one side can win a war" $ war warGame2 3 ([],[]) `shouldBe`
            ([(Jack,Hearts),(Ace,Hearts),(Two,Hearts),(Seven,Hearts),(King,Hearts),(Two,Diamonds),(Seven,Clubs),(Six,Clubs)],[(Nine,Diamonds),(Eight,Diamonds)])
        check "that a war can continue" $ war warGame2 1 ([],[]) `shouldBe`
            ([(Jack,Hearts),(Ace,Hearts),(Two,Hearts),(Seven,Hearts),(King,Hearts),(Two,Diamonds),(Seven,Clubs),(Six,Clubs)],[(Nine,Diamonds),(Eight,Diamonds)])
        check "that one-card hands return empty lists" $ war warGame1 3 ([],[]) `shouldBe` ([],[])

testPlay :: Grader String
testPlay = assess "play" 0 $ do 
    check "that play replaces cards"   $ (length p11,length p21) `shouldBe` (0,2)
    check "that play replaces cards 2" $ (length p12,length p22) `shouldBe` (2,0)
    where (p11,p21) = play testGame1 1
          (p12,p22) = play testGame2 1

tree :: Grader String
tree = describe "War" $ do
        testDeal
        testWar
        testPlay

runTests :: Int -> Bool -> IO ()
runTests verb force = do
        let a = runGrader tree
        format <- makeFormat verb force "projectDesc.yaml"
        runRWST a () format
        return ()
