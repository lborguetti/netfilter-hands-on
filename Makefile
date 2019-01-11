version?=latest
img=local/netfilter-handson:$(version)
baserun=docker run --rm -v `pwd`:/data
run=$(baserun) $(img)
runti=$(baserun) -ti $(img)

guard-%:
	@ if [ "${${*}}" = "" ]; then \
        echo "argument '$*' is required"; \
        exit 1; \
    fi

.PHONY: image
image:
	docker build -t $(img) .

.PHONY: image-silent
image-silent:
	@docker build -t $(img) . > /dev/null

.PHONY: shell
shell: image
	$(runti) /bin/bash

.PHONY: doc
doc: image
	$(run) mdtoc -w README.md
	$(run) dot -O -Tpng ./docs/networking-diagram.dot

view-networking: doc
	display ./docs/networking-design.dot.png
