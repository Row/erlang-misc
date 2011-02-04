% Solution to 99 problems as seen on 
% http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html
%
% Problem 1 - 11
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

