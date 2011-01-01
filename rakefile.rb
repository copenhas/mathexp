options = ""
dbg_options = options + " +debug_info"

grammar = './src/grammar.yrl'
lexical = './src/lexical.xrl'

erls = FileList.new('./src/*.erl')
erls.add('./src/grammar.erl')
erls.add('./src/lexical.erl')


desc 'Compiles all files to beam'
task :default => [:parser, :lexer] do
    erls.each do |f|
       sh "erlc -o ./ebin #{options} #{f}"
    end
end

task :debug => [:parser, :lexer] do
    erls.each do |f|
       sh "erlc -o ./ebin #{dbg_options} #{f}"
    end
end

desc 'Generates the parser code from grammer.yrl'
task :parser do 
    sh "./yecc.erl #{grammar}"
end

desc 'Generates the lexer code from lexical.xrl'
task :lexer do
    sh "./leex.erl #{lexical}"
end

task :clean do
end
