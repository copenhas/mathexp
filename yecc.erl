#!/usr/bin/env escript
-export([main/1]).

main([Grammer]) ->
    yecc:file(Grammer).
