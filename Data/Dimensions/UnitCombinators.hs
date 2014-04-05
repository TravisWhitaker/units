{- Data/Dimensions/UnitCombinators.hs

   The units Package
   Copyright (c) 2013 Richard Eisenberg
   eir@cis.upenn.edu

   This file defines combinators to build more complex units from simpler ones.
-}

{-# LANGUAGE TypeOperators, TypeFamilies, UndecidableInstances, 
             ScopedTypeVariables, DataKinds, FlexibleInstances,
             ConstraintKinds #-}

module Data.Dimensions.UnitCombinators where

import Data.Singletons ( Sing, SingI, sing )

import Data.Dimensions.Units
import Data.Dimensions.DimSpec
import Data.Dimensions.Z

infixl 7 :*
-- | Multiply two units to get another unit.
-- For example: @type MetersSquared = Meter :* Meter@
data u1 :* u2 = u1 :* u2

instance (Dimension d1, Dimension d2) => Dimension (d1 :* d2) where
  type DimSpecsOf (d1 :* d2) = (DimSpecsOf d1) @+ (DimSpecsOf d2)
    
instance (Unit u1, Unit u2) => Unit (u1 :* u2) where

  -- we override the default conversion lookup behavior
  type DimOfUnit (u1 :* u2) = (DimOfUnit u1) @+ (DimOfUnit u2)
  conversionRatio _ = conversionRatio (undefined :: u1) *
                      conversionRatio (undefined :: u2)

infixl 7 :/
-- | Divide two units to get another unit
data u1 :/ u2 = u1 :/ u2

instance (Dimension d1, Dimension d2) => Dimension (d1 :/ d2) where
  type DimSpecsOf (d1 :/ d2) = (DimSpecsOf d1) @- (DimSpecsOf d2)

instance (Unit u1, Unit u2) => Unit (u1 :/ u2) where
  type DimOfUnit (u1 :/ u2) = (DimOfUnit u1) @- (DimOfUnit u2)
  conversionRatio _ = conversionRatio (undefined :: u1) /
                      conversionRatio (undefined :: u2)

infixr 8 :^
-- | Raise a unit to a power, known at compile time
data unit :^ (power :: Z) = unit :^ Sing power

instance Dimension dim => Dimension (dim :^ power) where
  type DimSpecsOf (dim :^ power) = (DimSpecsOf dim) @* power

instance (Unit unit, SingI power) => Unit (unit :^ power) where
  type DimOfUnit (unit :^ power) = (DimOfUnit unit) @* power
  conversionRatio _ = conversionRatio (undefined :: unit) ^^ (szToInt (sing :: Sing power))

infixr 9 :@
-- | Multiply a conversion ratio by some constant. Used for defining prefixes.
data prefix :@ unit = prefix :@ unit

-- | A class for user-defined prefixes
class UnitPrefix prefix where
  -- | This should return the desired multiplier for the prefix being defined.
  -- This function must /not/ inspect its argument.
  multiplier :: Fractional f => prefix -> f

instance ( Unit unit
         , UnitPrefix prefix ) => Unit (prefix :@ unit) where
  type DimOfUnit (prefix :@ unit) = DimOfUnit unit
  conversionRatio _ = multiplier (undefined :: prefix) * conversionRatio (undefined :: unit)
