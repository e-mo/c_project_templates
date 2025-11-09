# =============================================================================
# C BUILD MAKEFILE - BIN 
# =============================================================================

SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --no-print-directory
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

OBJS := $(patsubst %.c,%.o,$(addprefix $(OBJ_DIR)/,$(SRCS)))
DEPS := $(OBJS:.o=.d)

# For building object subdirectory tree
OBJ_SUBDIRS := $(sort $(dir $(OBJS))) 

# Append necessary CPP flags
CPPFLAGS += -I$(INC_DIR) -MMD -MP

.DEFAULT_GOAL := all
all: $(BUILD_TARGET)

install: all
	$(INSTALL) -d $(DESTDIR)$(BINDIR)
	$(INSTALL_PROGRAM) $(BUILD_TARGET) $(DESTDIR)$(BINDIR)/$(BIN)
	@echo "Installation complete."

uninstall:
	@rm -vf $(DESTDIR)$(BINDIR)/$(BIN)
	@echo "Uninstall complete."

run: all
	@$(BUILD_TARGET) $(ARGS)

clean:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)

$(BUILD_TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_SUBDIRS)
	$(CC) $(CPPFLAGS) $(INTERNAL_CFLAGS) $(CFLAGS) -c $< -o $@

$(OBJ_SUBDIRS):
	mkdir -p $@

$(BUILD_DIR):
	mkdir -p $@

.PHONY: all install uninstall run clean
-include $(DEPS)
