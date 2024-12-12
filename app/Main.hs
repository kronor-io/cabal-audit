module Main (main) where

import GHC.IO.Encoding (setLocaleEncoding, utf8)
import Distribution.Audit (auditMain)

main :: IO ()
main = do
    setLocaleEncoding utf8
    auditMain
