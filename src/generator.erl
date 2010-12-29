-module(generator).
-export([generate/1]).

generate([Root, Left, Right]) ->
    LeftExp = generate(Left),
    RightExp = generate(Right),
    RootExp = generate(Root),
    LeftExp ++ RightExp ++ RootExp;
     
generate({number, _Line, Value}) ->
    [{push, Value}];
    
generate({'+', _Line}) ->
    [{add}];

generate({'-', _Line}) ->
    [{subtract}];

generate({'*', _Line}) ->
    [{multiply}];

generate({'/', _Line}) ->
    [{divide}].
