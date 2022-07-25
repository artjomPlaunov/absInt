open AbSyn
open Parser
open Lexer

let rec indent depth res = 
  match depth with
  | 0 -> print_string res
  | n -> indent (depth-1) (res ^ " ");;

let rec printAexpr a =
  match a with
  | Num x -> print_string (string_of_int x)
  | Var x -> print_string x
  | Minus (a1, a2) ->
    let _ = print_string "(" in
    let _ = printAexpr a1 in
    let _ = print_string " - " in
    let _ = printAexpr a2 in
    print_string ")"
  | Plus (a1, a2) ->
    let _ = print_string "(" in
    let _ = printAexpr a1 in
    let _ = print_string " + " in
    let _ = printAexpr a2 in
    print_string ")"      

let rec printProg prog depth =
  match prog with
  | Prog (sl, _, lbl) ->
    let _ = indent depth "" in
    let _ = print_endline "Prog:" in
    let _ = indent (depth+2) "" in
    let _ = print_endline "Stmlist:" in
    let _ = printStmlist sl (depth+4) in
    let _ = indent depth "" in
    print_endline (lbl ^ ":")
  | Emptystmt (lbl, _) ->
    let _ = indent depth "" in
    print_endline (lbl ^ ":" ^ " ;")
  | Assign (lbl, dest, a, _) ->
    let _  = indent depth "" in
    let _ = print_string (lbl ^ ": ") in
    let _ = print_string (dest ^ " = ") in
    let _ = printAexpr a in
    print_endline ";"
  | _ -> print_endline "foobar"
and printStmlist sl depth =
  match sl with
  | [] -> print_string ""
  | l :: ls ->
    let _ = printProg l (depth) in
    printStmlist ls depth;;


let lexbuf = Lexing.from_channel stdin in
  try
    printProg (Parser.prog Lexer.token lexbuf) 0
  with
  | Lexer.Error msg ->
    Printf.fprintf stderr "%s%!" msg
  | Parser.Error ->
    Printf.fprintf stderr "At offset %d: syntax error.\n%!"
                                     (Lexing.lexeme_start lexbuf);;
