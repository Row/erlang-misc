% Solution to 99 problems as seen on 
% http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html
%
% Avoiding predefined functions.
%
-module(nnp).
-compile(export_all).

% Problem 1
last([Element]) 
    -> Element;
last([_|Tail]) 
    -> last(Tail).

% Problem 2
last_but([A,B]) ->
    [A,B];
last_but([_|Tail]) -> 
    last_but(Tail).

% Problem 3
element_at(List, I) -> 
    element_at(List, I, 1).
element_at([Element | _], I, N) when N == I ->
    Element;
element_at([_ | Tail], I, N) ->
    element_at(Tail, I, N + 1).

% Problem 4
length_of([]) ->
    0;
length_of([_|Tail]) -> 
    1 + length_of(Tail).

% Problem 5
reverse(L) -> 
    reverse(L,[]).
reverse([H|T],R) -> 
    reverse(T,[H|R]);
reverse([],R) -> 
    R.

% Problem 6
is_palindrome(L1) ->
    is_palindrome(L1, reverse(L1)).
is_palindrome([H1|T1], [H2|T2]) when H1 == H2 ->
    is_palindrome(T1, T2);
is_palindrome([], []) -> 
    true;
is_palindrome(_, _) ->
    false.
    
% Problem 7
flatten([]) -> 
    [];
flatten([[HI|TI]|T]) ->
    [HI | flatten(TI)] ++ flatten(T);    
flatten([H|T]) ->
    [H|flatten(T)].
    
% Problem 8
compress([]) ->
    [];
compress([H|T]) ->
    [H|compress(compress(T), H)].
compress([], _) -> 
    [];
compress([H|T], Unique) when H == Unique ->
    compress(T, Unique);
compress([H|T], Unique) ->    
    [H|compress(T, Unique)].
    
% Problem 9
pack([H|T]) ->
    pack(T, [H]).
pack([], SubL) ->
    [SubL];
pack([H|T], [Prev|SubT]) when H == Prev ->
    pack(T,[H, Prev| SubT]);
pack([H|T], L) ->
    [L|pack(T,[H])].
        
% Problem 10
encode([]) -> 
    [];
encode([[E|TI]|T]) ->
    [{length_of(TI) + 1, E} | encode(T)];
encode(L) ->
    encode(pack(L)).

% Problem 11
encode_mod([]) ->
    [];
encode_mod([[E|TI]|T]) ->
    Len = length_of(TI),
    if
    Len == 0 ->
        [E | encode_mod(T)];
    true ->
        [{length_of(TI) + 1, E} | encode_mod(T)]
    end;    
encode_mod(L) ->
    encode_mod(pack(L)).

% Problem 12
decode([]) ->
    []; 
decode([{N,E}|T]) ->
    repeat(E,N) ++ decode(T);
decode([H|T]) ->
    [H|decode(T)].
    
repeat(_, 0) -> 
    [];
repeat(Char, N) ->
    [Char|repeat(Char, N-1)].
    
% Problem 13
encode_direct([H|T]) ->
    encode_direct(T, H, 1).    
encode_direct([H|T], H, N) ->
    encode_direct(T, H, N+1);
encode_direct([H|T], P, 1) ->
    [P,encode_direct(T, H, 1)];
encode_direct([H|T], P, N) ->
    [{N, P}|encode_direct(T, H, 1)];
encode_direct([], P, 1) ->
    [P];
encode_direct([],P,N) ->
    [{N, P}].
    
% Problem 14
dupli([]) ->
    [];
dupli([H|T]) ->
    [H, H | dupli(T)].

% Problem 15
replicate([], _) ->
    [];
replicate([H|T], N) ->
    replicate(H, N) ++ replicate(T, N);
replicate(_, 0) ->
    [];
replicate(E, N) ->
    [E | replicate(E, N - 1)].

% Problem 16
drop(L, N) ->
    drop(L, N, N - 1).
drop([_|T], N, 0) ->
    drop(T, N);
drop([H|T], N, I) ->
    [H | drop(T, N, I - 1)];
drop([], _, _) ->
    [].
    
% Problem 17
split(L, N) ->
    {split_n(L, N), split_tail(L, N)}.
split_n(_, 0) ->
    [];
split_n([H|T], N) ->
    [H|split_n(T, N-1)].
split_tail(L, 0) ->
    L;
split_tail([_|T], N) ->
    split_tail(T, N-1). 
    
% Problem 18
slice(_,0,0) ->
    [];
slice([H|T],0,M) ->
    [H|slice(T, 0, M - 1)];
slice([_|T],N,M) ->    
    slice(T, N - 1,M - 1).

% Problem 19
% Use mod instead
rotate(L, 0) ->
    L;
rotate(L, N) when N > 0 ->
    {L1, L2} = split(L, N),
    L2 ++ L1;
rotate(L, N) ->
     {L1, L2} = split(L, length_of(L) + N),
     L2 ++ L1.
     
% Problem 20
remove_at([_|T], 1) ->
    T;
remove_at([H|T], N) ->
    [H|remove_at(T, N - 1)].

% Problem 21
insert_at(Val, [H|T], 1) ->
    [Val,H|T];
insert_at(Val,[H|T], N) ->
    [H|insert_at(Val, T, N - 1)].
 
% Problem 22
range(I, J) when I == J ->
    [I];
range(I, J) when I > J ->
    [I|range(I - 1, J)];
range(I, J) ->
    [I|range(I + 1, J)].

% Problem 23
% N-random elements

% Problem 31
is_prime(N) ->
    is_prime(N, N - 1).
is_prime(_, 1) ->
    true;
is_prime(N, K) ->
    N rem K /= 0 andalso is_prime(N, K - 1).   

    
