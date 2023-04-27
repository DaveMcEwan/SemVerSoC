
.PHONY: default
default: SemVerSoC.pdf
default: index.html

DATE_ISO8601 := $(shell date +"%Y-%m-%d")
TIME_ISO8601 := $(shell date +"%H:%M:%S")
DATETIME_ISO8601 := ${DATE_ISO8601}T${TIME_ISO8601}

PANDOC_FLAGS := -f markdown
PANDOC_FLAGS += --metadata "title=Addendum to SemVer: System-on-Chip Designs"
PANDOC_FLAGS += --metadata "author=Dave McEwan"
PANDOC_FLAGS += --metadata "date=${DATETIME_ISO8601}"
PANDOC_FLAGS += --metadata "keywords=SemVer"
PANDOC_FLAGS += --metadata "keywords=SoC"
PANDOC_FLAGS += --metadata "keywords=SystemVerilog"
PANDOC_FLAGS += --metadata "keywords=Verilog"
PANDOC_FLAGS += --metadata "keywords=VHDL"
PANDOC_FLAGS += --variable=colorlinks
PANDOC_FLAGS += --variable=papersize:a4

# Minor tweaks for nicer formatting of PDF.
%.intermediateTex.md: %.md
	sed \
		-e 's/^## \(Downstream Users and Auxiliary Components\)$$/\\clearpage\n## \1/' \
		-e 's/^## \(Changes in .*\)$$/\\clearpage\n## \1/' \
		-e 's/^### \(.* Cheatsheet\)$$/\\clearpage\n### \1/' \
		-e 's/MAJOR/\\textcolor{red}{MAJOR}/' \
		-e 's/MINOR/\\textcolor{orange}{MINOR}/' \
		-e 's/PATCH/\\textcolor{Purple}{PATCH}/' \
		-e 's/^\(#\{1,\}\) \\[a-z]\{1,\}{[a-zA-Z]\{1,\}}{\([A-Z]\{1,\}\)}/\1 \2/' \
		-e 's/| add |/| \\colorbox{blue}{\\makebox[3em][c]{\\rule[0pt]{0pt}{0.7em}\\textcolor{white}{add}}} |/' \
		-e 's/| rem |/| \\colorbox{red}{\\makebox[3em][c]{\\rule[0pt]{0pt}{0.7em}\\textcolor{white}{rem}}} |/' \
		-e 's/| mod |/| \\colorbox{yellow}{\\makebox[3em][c]{\\rule[0pt]{0pt}{0.7em}\\textcolor{black}{mod}}} |/' \
		-e 's/| any |/| \\colorbox{white}{\\makebox[3em][c]{\\rule[0pt]{0pt}{0.7em}\\textcolor{black}{any}}} |/' \
		$*.md > $@

%.pdf: %.intermediateTex.md
	@pandoc --version
	pandoc -i $*.intermediateTex.md \
		--template template.latex \
		${PANDOC_FLAGS} \
		-o $@

# Minor tweaks for nicer formatting of HTML.
%.intermediateHtml.md: %.md
	sed \
		-e 's@MAJOR@<span class="MAJOR">MAJOR</span>@' \
		-e 's@MINOR@<span class="MINOR">MINOR</span>@' \
		-e 's@PATCH@<span class="PATCH">PATCH</span>@' \
		-e 's@| add |@| <span class="ch chAdd">add</span> |@' \
		-e 's@| rem |@| <span class="ch chRem">rem</span> |@' \
		-e 's@| mod |@| <span class="ch chMod">mod</span> |@' \
		-e 's@| any |@| <span class="ch chAny">any</span> |@' \
		$*.md > $@

%.html: %.intermediateHtml.md
	@pandoc --version
	pandoc -i $*.intermediateHtml.md \
		--template template.html \
		${PANDOC_FLAGS} \
		-o $@

index.html: SemVerSoC.html
	cp SemVerSoC.html $@

.PHONY: clean
clean:
	rm -f *.pdf
	rm -f *.intermediate*.*
