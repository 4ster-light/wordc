{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_wordc (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "wordc"
version :: Version
version = Version [0,1,0,0] []

synopsis :: String
synopsis = "A command line tool similar to the wc command"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
