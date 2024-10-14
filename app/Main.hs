import Control.Exception (IOException, catch)
import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (IOMode(ReadMode), hGetContents, openFile)

readFileContents :: FilePath -> IO String
readFileContents filename = do
  handle <- openFile filename ReadMode
  hGetContents handle
  
countStats :: String -> (Int, Int, Int)
countStats text = (lineCount, wordCount, charCount)
  where
    lineCount = length (lines text)
    wordCount = length (words text)
    charCount = length text

main :: IO ()
main = do
  args <- getArgs
  if length args /= 1
    then do
      putStrLn "Usage: wordc <filename>"
      exitFailure
    else do
      let filename = head args
      contents <- catch (readFileContents filename) handler
      let (linesCount, wordsCount, charsCount) = countStats contents
      putStrLn $ "Lines: " ++ show linesCount
      putStrLn $ "Words: " ++ show wordsCount
      putStrLn $ "Chars: " ++ show charsCount
  where
    handler :: IOException -> IO String
    handler e = do
      putStrLn $ "Error: " ++ show e
      exitFailure
