-module(inset).
-export([
            push/3,
            add/3,
            subtract/3,
            multiply/3,
            divide/3,
            return/3
        ]).

push({push, Value}, Stack, Program) -> 
    {[Value | Stack], Program}.

add({add}, [Right, Left | Stack], Program) -> 
    {[Left + Right | Stack], Program}.

subtract({subtract}, [Right, Left | Stack], Program) -> 
    {[Left - Right | Stack], Program}.

multiply({multiply}, [Right, Left | Stack], Program) -> 
    {[Left * Right | Stack], Program}.

divide({divide}, [Right, Left | Stack], Program) -> 
    {[Left / Right | Stack], Program}.

return({return, ProgId, Pid}, [Value | Stack], Program) -> 
    Pid ! {return, ProgId, Value},
    {Stack, Program}.
