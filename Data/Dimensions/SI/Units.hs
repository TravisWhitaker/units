{-# LANGUAGE TypeFamilies, TypeOperators #-}

-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Dimensions.SI.Units
-- Copyright   :  (C) 2013 Richard Eisenberg
-- License     :  BSD-style (see LICENSE)
-- Maintainer  :  Richard Eisenberg (eir@cis.upenn.edu)
-- Stability   :  experimental
-- Portability :  non-portable
--
-- This module exports unit definitions according to the SI system of units.
-- The definitions were taken from here: <http://www.bipm.org/en/si/>.
--
-- There is one deviation from the definition at that site: To work better
-- with prefixes, the unit of mass is 'Gram'.
-----------------------------------------------------------------------------

module Data.Dimensions.SI.Units where

import Data.Dimensions
import Data.Dimensions.SI.Base


data Hertz = Hertz
instance Unit Hertz where
  type BaseUnit Hertz = Number :/ Second
instance Show Hertz where
  show _ = "Hz"

data Newton = Newton
instance Unit Newton where
  type BaseUnit Newton = Meter :* Gram :/ (Second :^ Two)
  conversionRatio _ = 1000
instance Show Newton where
  show _ = "N"

data Pascal = Pascal
instance Unit Pascal where
  type BaseUnit Pascal = Newton :/ (Meter :^ Two)
instance Show Pascal where
  show _ = "Pa"

data Joule = Joule
instance Unit Joule where
  type BaseUnit Joule = Newton :* Meter
instance Show Joule where
  show _ = "J"

data Watt = Watt
instance Unit Watt where
  type BaseUnit Watt = Joule :/ Second
instance Show Watt where
  show _ = "W"

data Coulomb = Coulomb
instance Unit Coulomb where
  type BaseUnit Coulomb = Second :* Ampere
instance Show Coulomb where
  show _ = "C"

data Volt = Volt
instance Unit Volt where
  type BaseUnit Volt = Watt :/ Ampere
instance Show Volt where
  show _ = "V"

data Farad = Farad
instance Unit Farad where
  type BaseUnit Farad = Coulomb :/ Volt
instance Show Farad where
  show _ = "F"

data Ohm = Ohm
instance Unit Ohm where
  type BaseUnit Ohm = Volt :/ Ampere
instance Show Ohm where
  show _ = "Ω"

data Siemens = Siemens
instance Unit Siemens where
  type BaseUnit Siemens = Ampere :/ Volt
instance Show Siemens where
  show _ = "S"

data Weber = Weber
instance Unit Weber where
  type BaseUnit Weber = Volt :* Second
instance Show Weber where
  show _ = "Wb"

data Tesla = Tesla
instance Unit Tesla where
  type BaseUnit Tesla = Weber :/ (Meter :^ Two)
instance Show Tesla where
  show _ = "T"

data Henry = Henry
instance Unit Henry where
  type BaseUnit Henry = Weber :/ Ampere
instance Show Henry where
  show _ = "H"

data Lumen = Lumen
instance Unit Lumen where
  type BaseUnit Lumen = Candela
instance Show Lumen where
  show _ = "lm"

data Lux = Lux
instance Unit Lux where
  type BaseUnit Lux = Lumen :/ (Meter :^ Two)
instance Show Lux where
  show _ = "lx"

data Becquerel = Becquerel
instance Unit Becquerel where
  type BaseUnit Becquerel = Number :/ Second
instance Show Becquerel where
  show _ = "Bq"

data Gray = Gray
instance Unit Gray where
  type BaseUnit Gray = (Meter :^ Two) :/ (Second :^ Two)
instance Show Gray where
  show _ = "Gy"

data Sievert = Sievert
instance Unit Sievert where
  type BaseUnit Sievert = (Meter :^ Two) :/ (Second :^ Two)
instance Show Sievert where
  show _ = "Sv"

data Katal = Katal
instance Unit Katal where
  type BaseUnit Katal = Mole :/ Second
instance Show Katal where
  show _ = "kat"

