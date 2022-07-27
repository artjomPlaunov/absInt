OCAMLBUILD := ocamlbuild -use-menhir -menhir "menhir --infer --explain"

all : delete built examples
built:
	$(OCAMLBUILD) main.native

examples:
	@echo "# using the parser:"
	@echo "Program 1: ;"
	@echo ";" | ./main.native
	@echo ""

	@echo "Program 2: x = 42;"
	@echo "x = 42;" | ./main.native
	@echo ""

	@echo "Program 3: break;"
	@echo "break;" | ./main.native
	@echo ""

	@echo "Program 4: break; x = 7;"
	@echo "break; x = 7;" | ./main.native
	@echo ""

	@echo "Program 5: {}"
	@echo "{}" | ./main.native
	@echo ""

	@echo "Program 6: x=-10-20--30;"
	@echo "x=-10-20--30;" | ./main.native
	@echo ""

	@echo "Program 7: x=1; y=2;"
	@echo "x=1; y=2;" | ./main.native
	@echo ""

	@echo "Program 8: {x=10; ; y=20;}"
	@echo "{x=10; ; y=20;}" | ./main.native
	@echo ""

	@echo "Program 9: if (1-2<3-4-5) x=-x;"
	@echo "if (1-2<3-4-5) x=-x;" | ./main.native
	@echo ""

	@echo "Program 10: if (0<x) if (x<0) x=1; else if (x<0) {x=2; x=3;} else {x=4; x=5; x=6;}"
	@echo "if (0<x) if (x<0) x=1; else if (x<0) {x=2; x=3;} else {x=4; x=5; x=6;}" | ./main.native
	@echo ""

	@echo "Program 11: while (0<1){x = x - 1;} x = 42;"
	@echo "while (0<1){x = x - 1;} x = 42;" | ./main.native
	@echo ""

	@echo "Program 12: while (0<1) {}"
	@echo "while (0<1) {}" | ./main.native
	@echo ""

	@echo "Program 13: x=x-1; while (0<1) {x=x-1; if (x<2) break;};"
	@echo "x=x-1; while (0<1) {x=x-1; if (x<2) break;};" | ./main.native
	@echo ""

	@echo "Program 14: x=-10; while (x<0) if (x<0) if (0<x) x = -x;"
	@echo "x=-10; while (x<0) if (x<0) if (0<x) x = -x;" | ./main.native
	@echo ""

	@echo "Program 15: x=-10; while (x<0) {x=x-1; break;}; x=10;"
	@echo "x=-10; while (x<0) {x=x-1; break;}; x=10;" | ./main.native
	@echo ""

	@echo "Program 16: x=0; while (x<0) { while (x<0) x=x-1; x=10;}; x= 100;"
	@echo "x=0; while (x<0) { while (x<0) x=x-1; x=10;}; x= 100;" | ./main.native
	@echo ""

	@echo "Program 17: x=0; while (x<0) { while (x<0) x=x-1; break;}; x=100;"
	@echo "x=0; while (x<0) { while (x<0) x=x-1; break;}; x=100;" | ./main.native
	@echo ""

	@echo "Program 18: x=x-1; while (0<1) {x=x-1; if (2<x) break; };"
	@echo "x=x-1; while (0<1) {x=x-1; if (2<x) break; };" | ./main.native
	@echo ""

	@echo "Program 19: x=10; while (x>0) x=x-1;"
	@echo "x=10; while (x>0) x=x-1;" | ./main.native
	@echo ""

delete:
	rm -rf *~ .*~ main.native
	ocamlbuild -clean
