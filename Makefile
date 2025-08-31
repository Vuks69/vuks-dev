.PHONY: help Makefile deploy test

SPHINXOPTS			?=
SPHINXBUILD			?= sphinx-build
SOURCEDIR			= source
BUILDDIR			= build
DEPLOYDIR			= /var/www/website
STAGINGDIR			= /var/www/staging
# Fix weird interaction between sphinx and nix
# https://github.com/sphinx-doc/sphinx/issues/3451
SOURCE_DATE_EPOCH 	= $(shell git log -1 --format=%ct)

EXCLUDE			= .buildinfo .buildinfo.bak objects.inv
RSYNC_EXCLUDE	= $(addprefix --exclude , $(EXCLUDE))
RSYNC_OPTS		= -avz --delete $(RSYNC_EXCLUDE)
RSYNC			= rsync

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

deploy:
	@$(RSYNC) $(RSYNC_OPTS) "$(BUILDDIR)/html/" "$(DEPLOYDIR)/"

test:
	@$(RSYNC) $(RSYNC_OPTS) "$(BUILDDIR)/html/" "$(STAGINGDIR)/"
