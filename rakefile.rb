grammer = './src/grammer.yrl'
lexical = './src/lexical.xrl'


task :default => [:parser, :lexer] do

end

desc 'Generates the parser code from grammer.yrl'
task :parser do
    sh "./yecc.erl #{grammer}"
end

desc 'Generates the lexer code from lexical.xrl'
task :lexer do
    sh "./leex.erl #{lexical}"
end

