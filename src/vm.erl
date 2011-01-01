-module(vm).
-export([start/0, stop/0, loop/3]).
-export([load/1, compile/1, retrieve/1]).

% basic start and shutdown
start() ->
    Pid = spawn(?MODULE, loop, [{[], []}, true, 0]),
    register(vm, Pid).

stop() ->
    vm ! stop.

% core loop of the process
% normal mode, accept programs and process them
loop({Stack, Program}, true, ProgCounter) ->
   receive 
       stop -> loop({Stack, Program}, false, ProgCounter);
       {load, Pid, Instructions} ->
           ProgId = ProgCounter + 1,
           NewProgram = Instructions ++ [{return, ProgId, Pid}],
           Pid ! {load_success, ProgId},
           loop({Stack, Program ++ NewProgram}, true, ProgId)
   after 0 ->
       loop(execute(Stack, Program), true, ProgCounter)
   end;
% not accepting and no Instructions
% looks like we are done, time for this process to stop
loop({_Stack, []}, false, _ProgCounter) -> ok;
% when not accepting just process current programs 
% and let clients know if they try to load anything
loop({Stack, Program}, false, ProgCounter) ->
    receive
        {load, Pid, _Program} ->
            Pid ! {load_error, shutting_down}
    after 0 -> pass
    end,
    loop(execute(Stack, Program), false, ProgCounter).


execute(Stack, []) -> {Stack, []};
execute(Stack, [Next | Rest]) ->
    Instruction = element(1, Next),
    inset:Instruction(Next, Stack, Rest).


% loads the list of instructions into the virtual machine
% returning a ProgId to be used when retrieving the return value
load(Program) when is_list(Program) ->
    vm ! {load, self(), Program},
    receive 
        {load_success, ProgId} -> ProgId; 
        {load_error, Message} -> {error, Message}
    end.

% compiles a math expression returning the machine instructions
compile([]) -> [];
compile(Expression) when is_list(Expression) ->
    {ok, Tokens, _End} = lexical:string(Expression),
    {ok, Ast} = grammar:parse(Tokens),
    generator:generate(Ast).

% tries to retrieve the return value associated with the ProgId
% returns none atom is nothing recieved yet.
retrieve(ProgId) when is_integer(ProgId) ->
    receive
        {return, ProgId, Value} -> Value
    after 0 ->
        none
    end.
