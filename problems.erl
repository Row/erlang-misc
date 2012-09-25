-module(problems).
-export([gt/2, num_sums/2, par_match/1, pascal/2, postman/1]).

% List comprehension notation 
gt(L, N) ->
    [X || X <- L, X > N].

% Number of sums
% Example 
% num_sums(3, [1, 2]) gives 2
% Solutions is 1+1+1 and 1+2
num_sums(0, _) ->
    1;
num_sums(_, []) ->
    0;
num_sums(Sum, _) when Sum < 0 ->
    0;
num_sums(Sum, [H|T]) ->
    num_sums(Sum, T) + num_sums(Sum - H, [H|T]).

% Parantesis
% true if S contains matching paranthesis
par_match(S) ->
    par_match(S, 0).
par_match(_, Sum) when Sum < 0 ->
    false;
par_match([], Sum) ->
    Sum == 0;
par_match([$(|T], Sum) ->
    par_match(T, Sum + 1);
par_match([$)|T], Sum) ->
    par_match(T, Sum - 1);
par_match([_|T], Sum) ->
    par_match(T, Sum).

% Pascal
% pascal(0,2)=1, pascal(1,2)=2 and pascal(1,3)=3.
pascal(0,_) ->
    1;
pascal(C, C)->
    1;
pascal(C, R) ->
    pascal(C - 1, R - 1) + pascal(C, R - 1).


% Postman
postman(L) ->    
    postman(L,0,0).

postman([],_,Ack) ->
    Ack;
postman([Hd|Tl],Hd,Ack) ->
    postman(Tl,Hd,Ack+1);
postman([Hd|Tl],Max,Ack) when Hd < Max ->
    postman(Tl,Max,Ack);
postman([Hd|Tl],Max,Ack) ->
    max(postman(Tl,Hd,Ack+1),postman(Tl,Max,Ack)).



max(A,B) when A > B->
    A;
max(_A,B) ->
    B.
