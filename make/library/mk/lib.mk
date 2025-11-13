# =============================================================================
# C MAKEFILE - LIBRARY BUILD LOGIC
# =============================================================================
# PROJECT: make_template_lib
# FILE: lib.mk
# 
# DESCRIPTION:
# Make template for building a C library (static and shared).
# 
# Part of a two file Make build system:
#     Makefile - library project configuration
#  -> lib.mk   - complex build logic
#
# This allows for a clean seperation of frequently modified coniguration
# variables and rarely modified (if ever) build rules and logic.
# 
# AUTHOR: Evan Morse <emorse8686@gmail.com>
# LICENSE: MIT
# CREATED: 2025-11-9
# MODIFIED: 2025-11-9
#
# Copyright (c) 2025 Evan Morse
# ============================================================================= 

# Shell/Make configuration
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --no-print-directory
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Object and dependency list generation
OBJS := $(patsubst %.c,%.o,$(addprefix $(OBJ_DIR)/,$(SRCS)))
DEPS := $(OBJS:.o=.d)

# Object subdirectory list generation
OBJ_SUBDIRS := $(sort $(dir $(OBJS))) 

# Append necessary CPP flags
CPPFLAGS += -I$(INC_DIR) -MMD -MP

# Static library name
LIB_STATIC := lib$(PROJECT).a
# Shared library linker name
LIB_SHARED := lib$(PROJECT).so

VERSION := $(MAJOR).$(MINOR).$(PATCH)
SOVERSION := $(MAJOR)

# Shared library soname
LIB_SHARED_SONAME := $(LIB_SHARED).$(SOVERSION)
# Shared library full name (the actual .so file generated)
LIB_SHARED_FULL := $(LIB_SHARED).$(VERSION)

# Set build targets
LIB_STATIC_TARGET := $(BUILD_DIR)/$(LIB_STATIC)
LIB_SHARED_TARGET := $(BUILD_DIR)/$(LIB_SHARED_FULL)

# Determine what to build
TARGETS :=
ifeq ($(BUILD_STATIC),yes)
	TARGETS += $(LIB_STATIC_TARGET)
endif
ifeq ($(BUILD_SHARED),yes)
	TARGETS += $(LIB_SHARED_TARGET)
endif

.DEFAULT_GOAL := all
all: $(TARGETS)

# Build static library 
$(LIB_STATIC_TARGET): $(OBJS) | $(BUILD_DIR)
	$(AR) $(ARFLAGS) $@ $^
	$(RANLIB) $@

# Build shared library
$(LIB_SHARED_TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) -shared -Wl,-soname,$(LIB_SHARED_SONAME) $(LDFLAGS) -o $@ $^ $(LDLIBS) 
	@cd $(BUILD_DIR) && ln -sf $(LIB_SHARED_FULL) $(LIB_SHARED_SONAME)
	@cd $(BUILD_DIR) && ln -sf $(LIB_SHARED_SONAME) $(LIB_SHARED)

# Install library files and headers
install: all
	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)

ifeq ($(BUILD_STATIC),true)
	$(INSTALL_DATA) $(LIB_STATIC_TARGET) $(DESTDIR)$(LIBDIR)/$(LIB_STATIC)
endif
ifeq ($(BUILD_SHARED),true)
	$(INSTALL_PROGRAM) $(LIB_SHARED_TARGET) $(DESTDIR)$(LIBDIR)/$(LIB_SHARED_FULL)
	@cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIB_SHARED_FULL) $(LIB_SHARED_SONAME)
	@cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIB_SHARED_SONAME) $(LIB_SHARED)
endif

	@for header in $(LIB_HEADERS); do \
		target_dir=$(DESTDIR)$(INCLUDEDIR)/$$(dirname $$header); \
		$(INSTALL) -d $$target_dir; \
		$(INSTALL_DATA) $(INC_DIR)/$$header $$target_dir/; \
	done
	@echo "Installation complete."

# Uninstall library files and headers
uninstall:
	@rm -vf $(DESTDIR)$(LIBDIR)/$(LIB_STATIC)

	@rm -vf $(DESTDIR)$(LIBDIR)/$(LIB_SHARED)
	@rm -vf $(DESTDIR)$(LIBDIR)/$(LIB_SHARED_SONAME)
	@rm -vf $(DESTDIR)$(LIBDIR)/$(LIB_SHARED_FULL)

	@for header in $(LIB_HEADERS); do \
		rm -vf $(DESTDIR)$(INCLUDEDIR)/$$header; \
		dir=$(DESTDIR)$(INCLUDEDIR)/$$(dirname $$header); \
		while [ "$$dir" != "$(DESTDIR)$(INCLUDEDIR)" ] && rmdir "$$dir" 2>/dev/null; do \
			dir=$$(dirname $$dir); \
		done; \
	done
	@echo "Uninstall complete."

# Remove all build artifacts
clean:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)

# Build object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_SUBDIRS)
	$(CC) $(CPPFLAGS) $(INTERNAL_CFLAGS) $(CFLAGS) -c $< -o $@

# Create object subdirectory
$(OBJ_SUBDIRS):
	mkdir -p $@

# Create build subdirectory
$(BUILD_DIR):
	mkdir -p $@

# Include generated depenency files
-include $(DEPS)

.PHONY: all install uninstall clean
