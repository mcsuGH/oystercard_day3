# Oystercard

We have been asked to create a program to emulate an oystercard, which can be used to touch in and out of different stations and keep a record of all the journeys it has been used for. On each card, there is a balance where fares will be deducted based upon how many zones have been passed when used on a journey. If the user forgots to either touch in or out, a maximum fee will be applied instead.

## Instructions

Clone this repository to your desired location, run the command `gem install bundler` then run `bundle`.\
\
Run RSpec in the main `oystercard` directory whilst in the terminal in order to run the unit tests.\
\
Alternatively, run irb and load the file `oystercard.rb` located inside the lib directory. Create a new card within irb by using `Oystercard.new`. Create stations with the command `Station.new(name,zone)` and use the methods `touch_in(station)` and `touch_out(station)` (`station` being any Stations that have been created). Remember to use `top_up(amount)` on your card before using it, as you will not be able to travel without any money on it!\
\
If you forget to `touch_out(station)`, you can use the command `no_touch_out` to end your journey, but be aware this will charge you the maximum fare as a penalty! If you forgot to `touch_in(entry_station)`, using `touch_out(exit_station)` will raise you an error that you have not yet touched in, please instead `touch_in(exit_station)` and treat your exit station as the station you entered, then you can use `no_touch_out` to end the journey, which will charge the maximum fare as a penalty.

## User Stories
```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```

## Domain Model Diagram

| name              | oystercard                | station               | journey                        | 
| ----------------- | ------------------------- | --------------------- | ------------------------------ | 
|                   | @balance: number, reader  | @name: string, reader | @entry_station: class, reader  |
| variables         | @journey: class, reader   | @zone: number, reader | @exit_station: class, reader   |
|                   |                           |                       | @journey_history: array, reader|
| ----------------- | ------------------------- | --------------------- | ------------------------------ |
|                   | touch_in(station)         |                       | start(station)                 |
| methods           | touch_out(station)        |                       | finish(station)                |
|                   | top_up(amount)            |                       | record_journey                 |
|                   | deduct(fare)              |                       | fare                           |
| ----------------- | ------------------------- | --------------------- | ------------------------------ |

An idea of the different classes required along with the instance variables and methods for each class.

## Tasks yet to be completed

Code needs further changes - currently many tests are testing state and not behaviour - will need to add new methods to test (for example `print_journey_history` to check journey history) so that I can test the behaviour of the program instead, which will allow me to remove some of the attribute readers.


