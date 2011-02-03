% Problem 1
% my-last find the last element in list
-module(last).
-export([last/1]).

last([Element]) -> E;
last([Element,Rest]) -> last(Rest). 
