#!/usr/bin/env escript
-export([main/1]).

main([Lexical]) ->
    leex:file(Lexical).
