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

PARAMIKO_VERSION := paramiko-1.8.0
PARAMIKO_GZ := $(PARAMIKO_VERSION).tar.gz
PARAMIKO_URL := http://pypi.python.org/packages/source/p/paramiko/$(PARAMIKO_GZ)

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
get_deps: get_fabric get_paramiko

.PHONY: get_fabric
get_fabric: make_cachedir
	wget -O $(CACHE_DIR)/$(FABRIC_GZ) $(FABRIC_URL)
	tar -xzf $(CACHE_DIR)/$(FABRIC_GZ) -C $(CACHE_DIR)
	cp -R $(CACHE_DIR)/$(FABRIC_VERSION)/fabric $(PROJECT_DIR)/

.PHONY: get_paramiko
get_paramiko: make_cachedir
	wget -O $(CACHE_DIR)/$(PARAMIKO_GZ) $(PARAMIKO_URL)
	tar -xzf $(CACHE_DIR)/$(PARAMIKO_GZ) -C $(CACHE_DIR)
	cp -R $(CACHE_DIR)/$(PARAMIKO_VERSION)/paramiko $(PROJECT_DIR)/

.PHONY: generate_zip
generate_zip:
	cd $(PROJECT_DIR); zip -r $(APK_ZIP) ./fabric ./paramiko ./*.py;
	mv $(PROJECT_DIR)/$(APK_ZIP) $(WD)/$(APK_ZIP)

.PHONY: replace_pyapk_zip
replace_pyapk_zip:
	cp $(WD)/$(APK_ZIP) $(ANDPY27_PROJECT)/res/raw/
