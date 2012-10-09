WD := $(shell pwd)
CACHE_DIR := $(WD)/cache
VENV := $(WD)/venv
PY := $(VENV)/bin/python
PIP := $(VENV)/bin/pip
PROJECT_DIR := $(WD)/fabdroid
APK_ZIP := my_python_project.zip
ANDPY27_PROJECT := /home/brousch/Projects/PythonAPK

FABRIC_VERSION := Fabric-1.4.3
FABRIC_GZ := $(FABRIC_VERSION).tar.gz
FABRIC_URL := http://pypi.python.org/packages/source/F/Fabric/$(FABRIC_GZ)

SSH_VERSION := ssh-1.7.14
SSH_GZ := $(SSH_VERSION).tar.gz
SSH_URL := http://pypi.python.org/packages/source/s/ssh/$(SSH_GZ)

.PHONY: install
install: create_venv get_reqs get_deps

.PHONY: create_venv
create_venv:
	virtualenv -p python2.7 $(VENV)

.PHONY: get_reqs
get_reqs:
	$(PIP) install -r requirements.txt

.PHONY: make_cachedir
make_cachedir:
	mkdir -p $(CACHE_DIR)

.PHONY: clear_cache
clear_cache:
	rm -rf $(CACHE_DIR)

.PHONY: get_deps
get_deps: clean_deps get_dep_fabric get_dep_ssh

.PHONY: clean_deps
clean_deps: clean_dep_fabric clean_dep_ssh

.PHONY: get_dep_fabric
get_dep_fabric: make_cachedir
	wget -O $(CACHE_DIR)/$(FABRIC_GZ) $(FABRIC_URL)
	tar -xzf $(CACHE_DIR)/$(FABRIC_GZ) -C $(CACHE_DIR)
	cp -R $(CACHE_DIR)/$(FABRIC_VERSION)/fabric $(PROJECT_DIR)/

.PHONY: clean_dep_fabric
clean_dep_fabric:
	rm -rf $(PROJECT_DIR)/fabric

.PHONY: get_dep_ssh
get_dep_ssh: make_cachedir
	wget -O $(CACHE_DIR)/$(SSH_GZ) $(SSH_URL)
	tar -xzf $(CACHE_DIR)/$(SSH_GZ) -C $(CACHE_DIR)
	cp -R $(CACHE_DIR)/$(SSH_VERSION)/ssh $(PROJECT_DIR)/

.PHONY: clean_dep_ssh
clean_dep_ssh:
	rm -rf $(PROJECT_DIR)/ssh

.PHONY: generate_zip
generate_zip: get_deps
	cd $(PROJECT_DIR); zip -r $(APK_ZIP) ./fabric ./ssh ./*.py;
	mv $(PROJECT_DIR)/$(APK_ZIP) $(WD)/$(APK_ZIP)

.PHONY: replace_pyapk_zip
replace_pyapk_zip:
	cp $(WD)/$(APK_ZIP) $(ANDPY27_PROJECT)/res/raw/
