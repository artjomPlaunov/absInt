%{
    open AbSyn;;
    let x = ref 1;;
    let nextLbl =
      let res = String.cat "lbl" (string_of_int (!x)) in
      let _ = x := !x + 1 in
      res
%}

%token MINUS PLUS DIVIDE MOD
%token TRUE FALSE LT GT NAND OR LEQ GEQ
%token LPAREN RPAREN ASSIGN
%token SEMICOLON IF ELSE WHILE BREAK LBRACKET RBRACKET EOF
%token <string> IDENT
%token <int> NUM

%left     OR
%nonassoc NO_ELSE
%nonassoc ELSE
%left NAND
%left MINUS PLUS
%nonassoc UMINUS

%start prog
%type <unit AbSyn.tree> prog
%type <aexpr> aexpr
%type <bexpr> bexpr
%type <unit AbSyn.tree> stmt
%type <unit AbSyn.tree list> stmtlist

%%

prog:
  | l = stmtlist EOF                       { Prog (l, (), nextLbl) }

stmt:
  | x = IDENT ASSIGN a = aexpr SEMICOLON   { Assign (nextLbl, x, a, ()) }
  | SEMICOLON                              { Emptystmt (nextLbl, ()) }
  | IF LPAREN b = bexpr RPAREN
    s = stmt %prec NO_ELSE                 { If (nextLbl, b, s, ()) }
  | IF LPAREN b = bexpr RPAREN s = stmt
    ELSE s2 = stmt                         { Ifelse (nextLbl, b, s, s2, ()) } 
  | WHILE LPAREN b = bexpr RPAREN
    s = stmt                               { While (nextLbl, b, s, ())}  
  | BREAK SEMICOLON                        { Break (nextLbl, ()) }
  | LBRACKET l = stmtlist RBRACKET         { Stmlist (l, ()) }

stmtlist:
  | l = stmtlist s = stmt                  { s :: l }
  |                                        { [] }

aexpr:
  | n = NUM                                { Num n }
  | x = IDENT                              { Var x }
  | a1 = aexpr MINUS a2 = aexpr            { Minus (a1, a2) }
  | a1 = aexpr PLUS a2 = aexpr             { Plus (a1, a2) }
  | MINUS a = aexpr                        { Minus ((Num 0), a) } %prec UMINUS
  | LPAREN a = aexpr RPAREN                { a }

bexpr:
  | a1 = aexpr LT a2 = aexpr               { Lt (a1, a2) }
  | b1 = bexpr NAND b2 = bexpr             { Nand (b1, b2) }
  | b1 = bexpr OR b2 = bexpr               { Or (b1, b2) }
  | LPAREN b = bexpr RPAREN                { b }

%%



