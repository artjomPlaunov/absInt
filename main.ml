open AbSyn
open Parser
open Lexer

let print_program p d = print_endline "hello";;

  
let lexbuf = Lexing.from_channel stdin in
  try
    print_program 0 (Parser.prog Lexer.token lexbuf)
  with
  | Lexer.Error msg ->
    Printf.fprintf stderr "%s%!" msg
  | Parser.Error ->
    Printf.fprintf stderr "At offset %d: syntax error.\n%!"
                                     (Lexing.lexeme_start lexbuf);;
