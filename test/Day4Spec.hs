module Day4Spec where

import Test.Hspec
import qualified Text.Trifecta as TF
import Day4

resultToMaybe :: TF.Result a -> Maybe a
resultToMaybe =  TF.foldResult (const Nothing) Just

tryParse :: TF.Parser a -> String -> Maybe a
tryParse p str = resultToMaybe $ TF.parseString p mempty str

spec :: Spec
spec =
    describe "Parsing" $ do
        describe "Date" $ do
            it "parses a valid date text" $
                tryParse dateParser "1518-10-31" `shouldBe` (Just $ Date 1518 10 31)
            it "rejects an invalid date" $
                tryParse dateParser "1518 10 31" `shouldBe` Nothing
        describe "Time" $ do
            it "parses a valid time" $
                tryParse timeParser "13:50" `shouldBe` (Just $ Time 13 50)
            it "rejects an invalid time" $
                tryParse timeParser "13_50" `shouldBe` Nothing
        describe "guard event" $ do
            it "parses a wake-up string" $
                tryParse eventParser "wakes up" `shouldBe` Just GuardWakeup
            it "parses a fall-asleep string" $
                tryParse eventParser "falls asleep" `shouldBe` Just GuardFallAsleep
            it "parses a begins-shift string" $
                tryParse eventParser "Guard #1301 begins shift" `shouldBe` (Just $ GuardBeginShift 1301)
