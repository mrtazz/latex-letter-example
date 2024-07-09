
SOURCES=$(shell find . -type f -name "*-letter*.md")
LETTERS=$(patsubst %.md,%-letter.pdf,$(SOURCES))
ENVELOPES=$(patsubst %.md,%-envelope.pdf,$(SOURCES))

TEMPLATE_DIR ?= ./templates

%-letter.pdf: %.md %-envelope.pdf
	@echo "Creating letter PDF..."
	pandoc -s "$<" --pdf-engine=pdflatex -o "$@" --template "$(TEMPLATE_DIR)/simple-letter.tex"

%-envelope.pdf: %.md
	@echo "Creating envelope PDF..."
	pandoc -s "$<" --pdf-engine=pdflatex -o "$@" --template "$(TEMPLATE_DIR)/envelope.tex"

.PHONY: all
all: $(LETTERS) $(ENVELOPES)
