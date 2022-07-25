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

delete:
	rm -rf *~ .*~ main.native
	ocamlbuild -clean
