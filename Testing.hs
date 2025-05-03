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

testDeal :: Grader String
testDeal = assess "deal" 0 $ do 
    check "that deal creates the right length" $ all (==52) [length $ gameToDeck game | game <- decks] `shouldBe` True
    check "that deal doesn't contain dupes" $ all noDupes decks `shouldBe` True
    where
        decks :: [Game]
        decks = [deal deck [] [] | i <- [1..100]]
        noDupes :: Game -> Bool
        noDupes ([],[]) = True
        noDupes ([],_)  = error "lists are of unequal length"
        noDupes (_,[])  = error "lists are of unequal length"
        noDupes ((p1:p1s),(p2:p2s)) = if p1==p2 then False else noDupes (p1s,p2s)

testPlay :: Grader String
testPlay = assess "play" 0 $ do 
    check "that play replaces cards"   $ (length p11,length p21) `shouldBe` (0,2)
    check "that play replaces cards 2" $ (length p12,length p22) `shouldBe` (2,0)
    where (p11,p21) = play testGame1
          (p12,p22) = play testGame2

tree :: Grader String
tree = describe "War" $ do
        testDeal
        testPlay

runTests :: Int -> Bool -> IO ()
runTests verb force = do
        let a = runGrader tree
        format <- makeFormat verb force "projectDesc.yaml"
        runRWST a () format
        return ()