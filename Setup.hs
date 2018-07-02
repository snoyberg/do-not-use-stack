import Control.Concurrent(threadDelay)
import Control.Monad(when)
import Data.List(isInfixOf)
import Distribution.Simple(defaultMain)
import System.Environment(getEnvironment)
import System.Exit(exitFailure)
import System.IO(hPutStrLn, stderr)

main ::
  IO ()
main =
  let detectStackEnv env =
        maybe False ("snapshots" `isInfixOf`) (lookup "HASKELL_PACKAGE_SANDBOXES" env)
  in  do  env <- getEnvironment
          when (detectStackEnv env) $
            do  hPutStrLn stderr "Do not use stack."
                threadDelay 10000000
                exitFailure
          defaultMain
