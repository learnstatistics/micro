TEXNAME=CI-Principles-of-Microeconomics

export PATH := /usr/local/texlive/2015/bin/x86_64-linux:$(PATH)

all: $(TEXNAME).pdf

print-cover: print-cover.pdf

print-cover-front: print-cover-front.pdf

solutions-print-cover: solutions-print-cover.pdf

interior: interior.pdf
interior.dvi: $(TEXNAME).tex
	latex --jobname interior $<
	latex --jobname interior $<
	latex --jobname interior $<

base-text: base-text.pdf
base-text.dvi: $(TEXNAME).tex
	latex --jobname base-text $<
	latex --jobname base-text $<
	latex --jobname base-text $<

solutions: solutions.pdf
solutions.dvi: $(TEXNAME).tex
# Build .aux file for any references used
	latex --jobname interior $<
# Now build the actual solutions
	latex --jobname solutions $<
	latex --jobname solutions $<
	latex --jobname solutions $<

solutions-interior: solutions-interior.pdf
solutions-interior.dvi: $(TEXNAME).tex
# Build .aux file for any references used
	latex --jobname interior $<
# Now build the actual solutions
	latex --jobname solutions-interior $<
	latex --jobname solutions-interior $<
	latex --jobname solutions-interior $<

%.dvi : %.tex
	latex $<
	latex $<
	latex $<

%.ps : %.dvi
	dvips -o $@ $<

%.pdf : %.ps
	ps2pdf -r300 -dPDFSETTINGS=/printer -dColorConversionStrategy=/LeaveColorUnchanged -dGrayImageResolution=300 -dColorImageResolution=300 $<
#	ps2pdf $<

# Intermediate and target files that Latex will output
suffixes := .dvi .ps .pdf .out .log .toc .aux .bbl .blg .tps .glo .ist .acn

rmfiles := $(foreach f,$(suffixes),$(TEXNAME)$(f))

.PHONY: clean
clean:
	rm -f $(foreach f,$(suffixes),$(TEXNAME)$(f)) interior.* solutions.*
	rm -f $(foreach f,$(suffixes),print-cover$(f))
	rm -f $(foreach f,$(suffixes),print-cover-front$(f))
	rm -f $(foreach f,$(suffixes),base-text$(f))
	rm -f $(foreach f,$(suffixes),solutions-print-cover$(f))
	rm -f $(foreach f,$(suffixes),solutions-interior$(f))
