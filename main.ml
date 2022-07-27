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
and printBexpr b =
  match b with
  | Lt (a1, a2) ->
    let _ = printAexpr a1 in
    let _ = print_string " < " in
    printAexpr a2
  | _ -> print_string " bexpr "

let rec printProg prog depth =
  match prog with
  | Prog (sl, _, lbl) ->
    let _ = indent depth "" in
    let _ = print_endline "Prog:" in
    let _ = indent (depth+2) "" in
    let _ = print_endline "Stmlist: {" in
    let _ = printStmlist sl (depth+4) in
    let _ = indent (depth + 2) "" in
    let _ = print_endline "}" in
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
  | Break (lbl, _) ->
    let _ = indent depth "" in
    print_endline (lbl ^ ": " ^ "break;")
  | Stmlist (sl, _) ->
    let _ = indent depth "" in
    let _ = print_endline "Stmlist: {" in
    let _ = printStmlist sl (depth + 2) in
    let _ = indent depth "" in 
    print_endline "}"
  | If (lbl, b, a, _) ->
    let _ = indent depth "" in
    let _ = print_string ("(if " ^ lbl ^ ": ") in
    let _ = printBexpr b in
    let _ = print_endline "" in
    let _ = printProg a (depth+2) in
    let _ = indent depth "" in
    print_endline ")"
  | Ifelse (lbl, b, a1, a2, _) ->
    let _ = indent depth "" in
    let _ = print_string ("(ifelse " ^ lbl ^ ": ") in
    let _ = printBexpr b in
    let _ = print_endline "" in
    let _ = printProg a1 (depth+2) in
    let _ = printProg a2 (depth+2) in
    let _ = indent depth "" in
    print_endline ")"
  | While (lbl, b, a, _) ->
    let _ = indent depth "" in
    let _ = print_string ("(while " ^ lbl ^ ": ") in
    let _ = printBexpr b in
    let _ = print_endline "" in
    let _ = printProg a (depth+2) in
    let _ = indent depth "" in
    print_endline ")"
  | _ -> print_endline "foobar"
and printStmlist sl depth =
  match sl with
  | [] -> print_string ""
  | l :: ls ->
    let _ = printStmlist ls depth in
    printProg l depth;;


let lexbuf = Lexing.from_channel stdin in
  try
    printProg (Parser.prog Lexer.token lexbuf) 0
  with
  | Lexer.Error msg ->
    Printf.fprintf stderr "%s%!" msg
  | Parser.Error ->
    Printf.fprintf stderr "At offset %d: syntax error.\n%!"
                                     (Lexing.lexeme_start lexbuf);;
