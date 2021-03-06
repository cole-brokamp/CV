R_CMD=R CMD BATCH --vanilla

all: cole-brokamp-cv.pdf

cole-brokamp-cv.pdf: pubs.tex talks.tex software.tex support.tex cole-brokamp-cv.tex
		/Library/TeX/texbin/texfot pdflatex cole-brokamp-cv.tex
		open cole-brokamp-cv.pdf

pubs.tex pubs.md pubs_sections.md: pubs.yaml
		$(R_CMD) parse_pubs.R

talks.tex talks.md: talks.yaml
		$(R_CMD) parse_talks.R

software.tex software.md: software.yaml
		$(R_CMD) parse_software.R

support.tex support.md: support.yaml
		$(R_CMD) parse_support.R
