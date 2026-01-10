LATEXMK ?= latexmk
PREFIX ?= out

LANGS = fr \
	en

.PHONY: all
all: build

.PHONY: all
build:
	for lang in ${LANGS}; do \
		cd $${lang}; \
		${LATEXMK} -pdf theobori_cv_$${lang}.tex; \
		cd -; \
	done

.PHONY: install
install: build
	mkdir -p ${PREFIX}

	cp **/*.pdf ${PREFIX}

.PHONY: clean
clean:
	${RM} **/*.aux \
		**/*.log \
		**/*.out \
		**/*.fls \
		**/*.fdb_latexmk \
		**/*.gz \
		**/*.bak*

.PHONY: fclean
fclean: clean
	${RM} **/*.pdf

.PHONY: re
re: fclean build