{-# LANGUAGE EmptyCase, TemplateHaskell, PolyKinds, DataKinds, TypeFamilies, ScopedTypeVariables, GADTs, StandaloneDeriving, RankNTypes, TypeOperators, UndecidableInstances #-}

module SISpec where

import Data.Singletons
import Data.Singletons.Bool
import Data.Singletons.Tuple
import Data.Singletons.TH

import Data.Quantity.Map
import Data.Quantity.Quantity
import Data.Quantity.System
import Data.Quantity.System.SI
import Data.Quantity.Zahl

import Test.Hspec


type SI =  
  '[ '( Dim Length , Uni Meter) 
  , '(Dim Time, Uni Second) 
  , '(Dim Mass, Uni (Kilo Gram))] 

type CGS =  
  '[ '( Dim Length , Uni (Centi Meter)) 
  , '(Dim Time, Uni Second) 
  , '(Dim Mass, Uni Gram)] 



m1 :: Qu SI '[ '(Uni Meter, Posi 1) ] Rational
m1 = Qu 1

m2 :: Qu SI '[ '(Uni Second, Posi 1) ] Rational
m2 = Qu 2


-- The following is a compile error
-- combined :: Qu SI '[ '(Uni Meter, Posi 1) ] Rational
-- combined = m1 |+| m2


marathonLength :: Qu SI '[ '(Uni Meter, Posi 1) ] Rational
marathonLength = Qu 42195



marathonLengthInKm :: Qu SI '[ '(Uni (Kilo Meter), Posi 1) ] Rational
marathonLengthInKm = convertUnit $ marathonLength

type DensityIn l = Qu l (LookupCSUWithDim l '[ '(Dim Mass, Posi 1) , '(Dim Length, Nega 3) ] )

-- waterDensity :: Qu CGS '[ '(Uni Gram, Posi 1) , '(Uni (Centi Meter), Nega 3) ] Rational
waterDensity :: DensityIn CGS Rational
waterDensity = Qu 1

-- waterDensityInSI :: Qu SI '[ '(Uni (Kilo Gram), Posi 1) , '(Uni Meter, Nega 3) ] Rational
waterDensityInSI :: DensityIn SI Rational
waterDensityInSI = convertCSU waterDensity




spec :: Spec 
spec = do
  describe "Quantity calculus library" $ do
    it "can convert to numerical value correctly" $
      (toNumerical $ marathonLength) `shouldBe` 42195
    it "can convert between units correctly" $
      (toNumerical $ marathonLengthInKm) `shouldBe` 42.195      
      
    it "can convert between CSU correctly" $
      (toNumerical $ waterDensityInSI) `shouldBe` 1000


{-
-- type L1 = Sing (DimOfUnit '[ '(Uni Gram, Posi 1) , '(Uni (Centi Meter), Nega 3) ]) 
-- type L2 = Sing ('[  '(Dim Mass, Posi 1) ,  '(Dim Length, Posi 1) ]) 

type L1 = Sing (DimOfUnit '[ '(Uni (Meter), Nega 3) ]) 
type L1x = Sing (DimOfUnitName Meter)
type L1x2 = Sing (ZahlPowerOfDim (Nega 3) (DimOfUnitName Meter))
type L2 = Sing ('[  '(Dim Length, Posi 1) ]) 


type L3 = Sing (ZahlPowerOfDim (Posi 2) '[ '(Dim Mass, Posi 3)])
type L4 = Sing ('[ '(Dim Mass, Posi 6)]                         )             
-}