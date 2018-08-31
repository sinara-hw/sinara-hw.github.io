# TEMPLATE=default.latex
# --latex-engine xelatex --latex-engine-opt=-shell-escape --listings
# --template $(TEMPLATE)

OPTS=-V lang=en -V papersize=a4 -V fontsize=10pt \
     -V documentclass=article -V classoption=oneside \
     -V geometry=inner=3cm,outer=3cm,top=3cm,bottom=4cm \
     -V fontfamily=palatino \
     -M numbersections=false

#-M title=Sinara -M author="The Sinara Contributors"

%.pdf: %.md # $(TEMPLATE)
	pandoc --from markdown_github --to latex $(OPTS) \
		--output $@ $<
