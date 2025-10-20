## Customize Makefile settings for memo
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

#################################################################
## import rico custom
#################################################################

$(IMPORTDIR)/rico_import.owl: $(MIRRORDIR)/rico.owl $(IMPORTDIR)/rico_terms.txt $(IMPORTSEED) | all_robot_plugins
	$(ROBOT) annotate --input $< --remove-annotations \
		 odk:normalize --add-source true \
		 extract --term-file $(IMPORTDIR)/rico_terms.txt $(T_IMPORTSEED) \
		         --copy-ontology-annotations true --force true \
		         --individuals exclude \
		         --method SUBSET \
		 remove $(foreach p, $(ANNOTATION_PROPERTIES), --term $(p)) \
		        --term rdfs:label \
		        --term IAO:0000115 \
		        --term OMO:0002000 \
		        --term-file $(IMPORTDIR)/rico_terms.txt $(T_IMPORTSEED) \
		        --select complement --select annotation-properties \
		 odk:normalize --base-iri https://nfdi.fiz-karlsruhe.de/4memory/ontology \
		               --subset-decls true --synonym-decls true \
		 repair --merge-axiom-annotations true \
		 $(ANNOTATE_CONVERT_FILE)