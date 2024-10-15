import Control.Exception (IOException, catch)
import Data.Foldable (forM_)
import Data.List (isInfixOf)
import System.Console.ANSI
import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (IOMode (ReadMode), hGetContents, openFile)

-- Data type to hold all statistics
data Stats = Stats
  { lineCount :: Int,
    wordCount :: Int,
    charCount :: Int,
    searchCount :: Maybe Int
  }

-- Read the contents of a file
readFileContents :: FilePath -> IO String
readFileContents filename = do
  handle <- openFile filename ReadMode
  hGetContents handle

-- Count statistics from the text content
countStats :: String -> Maybe String -> Stats
countStats text searchStr =
  Stats
    { lineCount = length (lines text),
      wordCount = length (words text),
      charCount = length text,
      searchCount = fmap (\s -> length $ filter (isInfixOf s) (lines text)) searchStr
    }

-- Print a statistic with a colored label
printColoredStat :: String -> Int -> IO ()
printColoredStat label value = do
  setSGR [SetColor Foreground Vivid Green]
  putStr label
  setSGR [Reset]
  print value

main :: IO ()
main = do
  args <- getArgs
  case args of
    -- Process command line arguments
    [filename] -> processFile filename Nothing
    [filename, "-s", searchStr] -> processFile filename (Just searchStr)
    _ -> do
      -- If no arguments were given
      setSGR [SetColor Foreground Vivid Blue]
      putStrLn "Usage: wordc <filename> [-s <search_string>]"
      setSGR [Reset]
      exitFailure
  where
    -- Process the file and print statistics
    processFile filename searchStr = do
      contents <- catch (readFileContents filename) handler
      let stats = countStats contents searchStr

      -- Print basic statistics
      printColoredStat "Lines: " (lineCount stats)
      printColoredStat "Words: " (wordCount stats)
      printColoredStat "Chars: " (charCount stats)

      -- Print search occurrences if a search string was provided
      forM_ (searchCount stats) (printColoredStat "Search occurrences: ")

    -- Error handler for file reading
    handler :: IOException -> IO String
    handler e = do
      setSGR [SetColor Foreground Vivid Red]
      putStrLn $ "Error: " ++ show e
      setSGR [Reset]
      exitFailure
