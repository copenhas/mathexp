Definitions.


Rules.

[0-9]+ :
    {token, {number, TokenLine, list_to_integer(TokenChars)}}.

[0-9]+\.[0-9]+ :
    {token, {number, TokenLine, list_to_float(TokenChars)}}.

\+ : {token, {'+', TokenLine}}.
\- : {token, {'-', TokenLine}}.
/ : {token, {'/', TokenLine}}.
\* : {token, {'*', TokenLine}}.
\( : {token, {'(', TokenLine}}.
\) : {token, {')', TokenLine}}.

[\000-\s] : skip_token.
[\n] : {end_token, {'$end', TokenLine}}.


Erlang code.


