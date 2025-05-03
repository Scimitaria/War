module Main where
import War
import Parsing
import Testing
import TestInputs
import System.IO
import System.Environment
import System.Console.GetOpt

data Flag = Verbose | Test | Help  deriving (Show, Eq)

options :: [OptDescr Flag]
options = [ Option ['v'] ["verbose"]       (NoArg Verbose)          "Pretty-print the result of the move and exit."
          , Option ['t'] ["test"]          (NoArg Test)             "Run tests and exit."
          , Option ['h'] ["help"]          (NoArg Help)             "Print usage information and exit."
          ]

main :: IO ()
main = do
    args <- getArgs
    let (flags, inputs, errors) = getOpt Permute options args
    if (Help `elem` flags) || (not $ null errors)
    then putStrLn $ usageInfo "War [options] [filename] card game." options
    else if Test `elem` flags then runTests 1 True
    else putStrLn $ show $ deck