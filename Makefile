VPATH = .:_spec
vpath %.csl _csl
vpath %.yaml _spec:.
vpath default.% _lib

PANDOC/LATEX := docker run -v "`pwd`:/data" \
	-v "`pwd`/assets/fonts:/usr/share/fonts" \
	-u "`id -u`:`id -g`" pandoc/latex:2.11.3.2

%.pdf : %.md biblio.bib pdf.yaml | _csl
	$(PANDOC/LATEX) -o $@ -d _spec/pdf.yaml $<

_csl :
	git clone https://github.com/citation-style-language/styles.git _csl
