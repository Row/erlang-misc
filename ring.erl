-module(ring).
-export([ring/2,ring_node/1]).

ring_node(Next_PID) ->
    receive
        {msg, 0} ->
            io:format("Finish received~n", []),
            Next_PID ! {msg, 0};
        {msg, N} ->
            io:format("MSG received ~w~n", [N]),
            Next_PID ! {msg, N - 1},
            ring_node(Next_PID);
        {change_next_pid, New_PID} ->
            io:format("Changed next PID~n", []),
            ring_node(New_PID)
    end.
    

ring(N, M) ->
    io:format("Start ring~n", []),
    Start_PID = spawn(ring, ring_node, [0]),
    ring(N-1, M, Start_PID, Start_PID).
ring(0, M, Ring_Start_Node, Next_Node) -> 
    Ring_Start_Node ! {change_next_pid, Next_Node},
    Ring_Start_Node ! {msg, M},
    io:format("Ring Started~n", []);
ring(N, M, Ring_Start_Node, Next_Node) ->
    Next_PID = spawn(ring, ring_node, [Next_Node]),
    ring(N-1, M, Ring_Start_Node, Next_PID).

