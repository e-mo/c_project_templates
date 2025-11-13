# =============================================================================
# C MAKEFILE - BINARY BUILD LOGIC
# =============================================================================
# PROJECT: make_template_bin
# FILE: bin.mk
# 
# DESCRIPTION:
# Make template for building a C binary.
# 
# Part of a two file Make build system:
#     Makefile - binary project configuration
#  -> bin.mk   - complex build logic
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

# For building object subdirectory tree
OBJ_SUBDIRS := $(sort $(dir $(OBJS))) 

# Append necessary CPP flags
CPPFLAGS += -I$(INC_DIR) -MMD -MP

# Build Target
BIN := $(PROJECT)
BIN_TARGET := $(BUILD_DIR)/$(BIN)

.DEFAULT_GOAL := all
all: $(BIN_TARGET)

# Build binary 
$(BIN_TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

# Install binary
install: all
	$(INSTALL) -d $(DESTDIR)$(BINDIR)
	$(INSTALL_PROGRAM) $(BIN_TARGET) $(DESTDIR)$(BINDIR)/$(BIN)
	@echo "Installation complete."

# Uninstall binary
uninstall:
	@rm -vf $(DESTDIR)$(BINDIR)/$(BIN)
	@echo "Uninstall complete."

# Run binary (with optional args)
run: all
	@$(BIN_TARGET) $(ARGS)

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

.PHONY: all install uninstall run clean
