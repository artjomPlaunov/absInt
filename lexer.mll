{
open Parser
exception Error of string
}

let digit = ['0'-'9']
let int = digit+
let letter = ['a'-'z' 'A'-'Z']
let id = letter+

rule token = parse
     [' ' '\t' '\n'] { token lexbuf }
   | "nand"    { NAND }
   | "if"      { IF }
   | "else"    { ELSE }
   | "while"    { WHILE }
   | ";"       { SEMICOLON }
   | "("       { LPAREN }
   | ")"       { RPAREN }
   | "{"       { LBRACKET }
   | "}"       { RBRACKET }
   | "nand"    { NAND }
   | "||"      { OR }
   | "-"       { MINUS }
   | "+"       { PLUS }
   | "/"       { DIVIDE }
   | "%"       { MOD }
   | "true"    { TRUE }
   | "false"   { FALSE }
   | ">"       { GT }
   | "<"       { LT }
   | "if"      { IF }
   | eof       { EOF }
   | "else"    { ELSE }
   | "break"   { BREAK }
   | "="       { ASSIGN }
   | id	       { IDENT (Lexing.lexeme lexbuf)}
   | int       { NUM (int_of_string (Lexing.lexeme lexbuf)) }
   