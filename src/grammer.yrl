Nonterminals expression.
Terminals number '+' '-' '/' '*' '(' ')'.

Rootsymbol expression.
Endsymbol '$end'.

Left 300 '+'.
Left 300 '-'.
Left 400 '*'.
Left 400 '/'.


expression -> expression '+' expression : [ '$2', '$1', '$3' ].
expression -> expression '-' expression : [ '$2', '$1', '$3' ].
expression -> expression '/' expression : [ '$2', '$1', '$3' ].
expression -> expression '*' expression : [ '$2', '$1', '$3' ].
expression -> '(' expression ')' : '$2'.
expression -> number : '$1'.
