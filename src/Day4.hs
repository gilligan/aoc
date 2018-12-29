module Day4 where

import qualified Text.Trifecta as TF

data Time = Time { hour, min :: Integer }
    deriving (Show, Eq, Ord)

data Date = Date { y, m, d :: Integer }
    deriving (Show, Eq, Ord)

data DateTime = DateTime { date :: Date, time :: Time }
    deriving (Show, Eq, Ord)

data GuardEvent = GuardWakeup
                | GuardFallAsleep
                | GuardBeginShift Integer
                deriving (Show, Eq)

dateParser :: TF.Parser Date
dateParser = Date <$> TF.integer
    <*  TF.char '-'
    <*> TF.integer
    <*  TF.char '-'
    <*> TF.integer

timeParser :: TF.Parser Time
timeParser = Time <$> TF.integer <* TF.char ':' <*> TF.integer


dateTimeParser :: TF.Parser DateTime
dateTimeParser = DateTime <$> inBrackets dateParser
                          <*> timeParser
                              where
                                  TF.between (TF.symbol "[") (TF.symbol "]")

eventParser :: TF.Parser GuardEvent
eventParser = TF.choice [pWake, pSleep, pEndShift]
    where
        pWake = GuardWakeup <$ TF.string "wakes up"
        pSleep = GuardFallAsleep <$ TF.string "falls asleep"
        pEndShift = do
            _ <- TF.string "Guard #"
            n <- TF.integer
            _ <- TF.string "begins shift"
            return $ GuardBeginShift n

day4 :: String
day4 = "day4"

--[1518-10-31 00:58] wakes up
--[1518-02-27 00:57] wakes up
--[1518-04-05 00:03] falls asleep
--[1518-06-03 00:18] falls asleep
--[1518-08-06 00:39] falls asleep
--[1518-08-15 00:54] falls asleep
--[1518-03-07 00:00] falls asleep
--[1518-05-01 00:12] falls asleep
--[1518-06-17 00:53] wakes up
--[1518-03-13 00:13] falls asleep
--[1518-08-05 00:34] wakes up
--[1518-11-23 00:57] wakes up
--[1518-07-01 23:59] Guard #1301 begins shift
--[1518-02-08 00:51] wakes up
--[1518-11-10 00:59] wakes up
--[1518-07-06 00:01] falls asleep
--[1518-07-08 00:11] falls asleep
--[1518-04-04 00:40] wakes up
--[1518-04-26 00:04] wakes up
--[1518-03-26 00:35] falls asleep
--[1518-06-05 00:33] falls asleep
--[1518-07-25 23:56] Guard #433 begins shift

