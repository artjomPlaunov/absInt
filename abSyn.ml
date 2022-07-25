(* file abSyn.ml *)
type variable = string

type label = string

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
  | Prog of 'a tree list * 'a * label
  | Assign of label * variable * aexpr * 'a
  | Emptystmt of label * 'a
  | If of label * bexpr * 'a tree * 'a
  | Ifelse of label * bexpr * 'a tree * 'a tree * 'a
  | While of label * bexpr * 'a tree * 'a
  | Break of label * 'a
  | Stmlist of 'a tree list * 'a
          
