module Main where
import War
import Parsing
import Testing
import TestInputs
import Text.Read
import Data.Maybe
import System.IO
import System.Environment
import System.Console.GetOpt

data Flag = Size String | Verbose | Test | Help  deriving (Show, Eq)

options :: [OptDescr Flag]
options = [ Option ['s'] ["size"]          (ReqArg Size "<num>")    "Specifies a size in the event of war."
          , Option ['v'] ["verbose"]       (NoArg Verbose)          "Pretty-print the result of the move and exit."
          , Option ['t'] ["test"]          (NoArg Test)             "Run tests and exit."
          , Option ['h'] ["help"]          (NoArg Help)             "Print usage information and exit."
          ]

numAces :: Game -> (Int,Int)
numAces (p1,p2) = (length [card | card@(Ace,_) <- p1],length [card | card@(Ace,_) <- p2])

getSize :: [Flag] -> Int
getSize [] = 4
getSize (Size s:_) = 
    case readMaybe s of
        Just size -> size
        _ -> 4
getSize (_:fs) = getSize fs

runGame :: Game -> Int -> IO String
runGame ([],[]) _ = do
    --putStrLn "tie"
    return "tie"
runGame (_,[])  _ = do
    --putStrLn "p1 wins"
    return "p1"
runGame ([],_)  _ = do
    --putStrLn "p2 wins"
    return "p2"
runGame (p1,p2) warSize = runGame (play (p1,p2) warSize) warSize

runGameV :: Game -> Int -> IO String
runGameV ([],[]) _ = do
    putStrLn "tie"
    return "tie"
runGameV (_,[])  _ = do
    putStrLn "p1 wins"
    return "p1"
runGameV ([],_)  _ = do
    putStrLn "p2 wins"
    return "p2"
runGameV (h1@(p1:_),h2@(p2:_)) warSize = do
    putStrLn ((show $ length h1) ++ "," ++ (show $ length h2))
    putStrLn ((showCard p1) ++ "," ++ (showCard p2))
    if (getCardVal p1) == (getCardVal p2) then putStrLn "war!" else return ()
    putStrLn ""--line between plays
    runGameV (play (h1,h2) warSize) warSize

main :: IO ()
main = do
    args <- getArgs
    let (flags, inputs, errors) = getOpt Permute options args
        c = ","
    if (Help `elem` flags) || (not $ null errors)
    then putStrLn $ usageInfo "War [options] [filename] card game." options
    else if Test `elem` flags then runTests 1 True
    else do let game = deal deck [] []
                size = getSize flags
            if Verbose `elem` flags then do
                res <- runGameV game size
                let warSize = show size
                    (a,b) = numAces game
                    (aces1,aces2) = (show a, show b)
                    dat = warSize++c++aces1++c++aces2++c++res++"\n"
                appendFile "data.csv" dat
            else do
                res <- runGame game size
                let warSize = show size
                    (a,b) = numAces game
                    (aces1,aces2) = (show a, show b)
                    dat = warSize++c++aces1++c++aces2++c++res++"\n"
                appendFile "data.csv" dat
