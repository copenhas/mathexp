-module(vm).
-export([start/0, stop/0, loop/1]).
-export([load/1]).

start() ->
    Pid = spawn_link(?MODULE, loop, [{[], []}]),
    register(vm, Pid).

stop() ->
    vm ! stop.

loop({Stack, Program}) ->
   receive 
       stop -> ok;
       {load, Pid, Instructions} ->
           Pid ! ok,
           loop({Stack, Program ++ Instructions})
   after 0 ->
       loop(execute(Stack, Program))
   end.

execute(Stack, []) -> {Stack, []};
execute(Stack, [Next | Rest]) ->
    Instruction = element(1, Next),
    inset:Instruction(Next, Stack, Rest).

load(Program) ->
    vm ! {load, self(), Program ++ [{return, self()}]},
    receive ok -> ok end.

