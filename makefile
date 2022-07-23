OCAMLBUILD := ocamlbuild -use-menhir -menhir "menhir --infer --explain"

all : delete built examples
built:
	$(OCAMLBUILD) main.native

examples:
	@echo "# using the parser:"
	@echo ";" | ./main.native

delete:
	rm -rf *~ .*~ main.native
	ocamlbuild -clean
