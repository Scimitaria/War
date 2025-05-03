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

runGame :: Game -> Int -> IO ()
runGame ([],[]) _ = putStrLn "tie"
runGame (_,[])  _ = putStrLn "p1 wins"
runGame ([],_)  _ = putStrLn "p2 wins"
runGame (p1,p2) warSize = do
    putStrLn ((show $ length p1) ++ "," ++ (show $ length p2))
    runGame (play (p1,p2) warSize) warSize

runGameV :: Game -> Int -> IO ()
runGameV ([],[]) _ = putStrLn "tie"
runGameV (_,[])  _ = putStrLn "p1 wins"
runGameV ([],_)  _ = putStrLn "p2 wins"
runGameV (h1@(p1:_),h2@(p2:_)) warSize = do
    putStrLn ((show $ length h1) ++ "," ++ (show $ length h2))
    putStrLn ((showCard p1) ++ "," ++ (showCard p2))
    if (getCardVal p1) == (getCardVal p2) then putStrLn "war!" else return ()
    runGameV (play (h1,h2) warSize) warSize

getSize :: [Flag] -> Int
getSize [] = 3
getSize (Size s:_) = 
    case readMaybe s of
        Just size -> size
        _ -> 3
getSize (_:fs) = getSize fs

main :: IO ()
main = do
    args <- getArgs
    let (flags, inputs, errors) = getOpt Permute options args
    if (Help `elem` flags) || (not $ null errors)
    then putStrLn $ usageInfo "War [options] [filename] card game." options
    else if Test `elem` flags then runTests 1 True
    else do let game = deal deck [] []
                size = getSize flags
            if Verbose `elem` flags then runGameV game size
            else runGame game size