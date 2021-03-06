# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         = a4

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d build/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

.PHONY: help clean html web pickle htmlhelp latex changes linkcheck

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html      to make standalone HTML files"
	@echo "  pickle    to make pickle files"
	@echo "  json      to make JSON files"
	@echo "  htmlhelp  to make HTML files and a HTML help project"
	@echo "  latex     to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  changes   to make an overview over all changed/added/deprecated items"
	@echo "  linkcheck to check all external links for integrity"
	@echo " "
	@echo " ================================================================="
	@echo " Modificaciones para Matemáticas en Ingeniería con Matlab y Octave"
	@echo " ================================================================="
	@echo "  upload    sube todo el árbol al servidor web"
	@echo "  pngfig    para convertir las figuras svg a png con inkscape"
	@echo "  pdffig    para convertir las figuras svg a pdf con inkscape"

pngfig:
	python makefigures.py png

pdffig:
	python makefigures.py pdf

upload:
	@ echo "Construyendo las transparencias"
	make -C cursos/basico09
	cp cursos/basico09/basico.pdf build/html/tutorial/
	@ echo "Construyendo el tutorial"
	make -C source/tutorial html
	cp -r source/tutorial/_build/html/* build/html/tutorial/
	make -C source/tutorial latex
	make -C source/tutorial/_build/latex all-pdf
	cp source/tutorial/_build/latex/IntroduccionaMatlab.pdf \
	build/html/tutorial/
	@ echo "Construyendo el documento principal"
	make html
	make latex
	make -C build/latex all-pdf
	cp build/latex/iimyo2.pdf build/html/
	@ echo "Subiendo el documento principal a rediris"
	scp -r build/html/* iimyo@forja.rediris.es:/htdocs/

clean:
	-rm -rf build/*

html:
	mkdir -p build/html build/doctrees
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) build/html
	@echo
	@echo "Build finished. The HTML pages are in build/html."

pickle:
	mkdir -p build/pickle build/doctrees
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) build/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

web: pickle

json:
	mkdir -p build/json build/doctrees
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) build/json
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp:
	mkdir -p build/htmlhelp build/doctrees
	$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) build/htmlhelp
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in build/htmlhelp."

latex:
	mkdir -p build/latex build/doctrees
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) build/latex
	@echo
	@echo "Build finished; the LaTeX files are in build/latex."
	@echo "Run \`make all-pdf' or \`make all-ps' in that directory to" \
	      "run these through (pdf)latex."

changes:
	mkdir -p build/changes build/doctrees
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) build/changes
	@echo
	@echo "The overview file is in build/changes."

linkcheck:
	mkdir -p build/linkcheck build/doctrees
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) build/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in build/linkcheck/output.txt."
