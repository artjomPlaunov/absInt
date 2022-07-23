(* file abSyn.ml *)
type variable = string
type aexpr =
  | Num of int
  | Var of string
  | Minus of aexpr * aexpr
  | Plus of aexpr * aexpr
type bexpr =
  | Lt of aexpr * aexpr
  | Nand of bexpr * bexpr
  | Or of bexpr * bexpr
type 'a tree =
  | Prog of 'a tree list * 'a
  | Assign of variable * aexpr * 'a
  | Emptystmt of 'a
  | If of bexpr * 'a tree * 'a
  | Ifelse of bexpr * 'a tree * 'a tree * 'a
  | While of bexpr * 'a tree * 'a
  | Break of 'a
  | Stmlist of 'a tree list * 'a
          
