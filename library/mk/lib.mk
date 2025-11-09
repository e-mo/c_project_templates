# =============================================================================
# C BUILD MAKEFILE - LIB
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

#$(INSTALL) -d $(DESTDIR)$(BINDIR)
install: all
	$(INSTALL) -d $(DESTDIR)$(LIBDIR)
	$(INSTALL) -d $(DESTDIR)$(INCLUDEDIR)

	$(INSTALL_DATA) $(BUILD_TARGET) $(DESTDIR)$(LIBDIR)/$(LIB)

	@for header in $(LIB_HEADERS); do \
		target_dir=$(DESTDIR)$(INCLUDEDIR)/$$(dirname $$header); \
		$(INSTALL) -d $$target_dir; \
		$(INSTALL_DATA) $(INC_DIR)/$$header $$target_dir/; \
	done
	@echo "Installation complete."

uninstall:
	@rm -vf $(DESTDIR)$(LIBDIR)/$(LIB)

	@for header in $(LIB_HEADERS); do \
		rm -vf $(DESTDIR)$(INCLUDEDIR)/$$header; \
		dir=$(DESTDIR)$(INCLUDEDIR)/$$(dirname $$header); \
		while [ "$$dir" != "$(DESTDIR)$(INCLUDEDIR)" ] && rmdir "$$dir" 2>/dev/null; do \
			dir=$$(dirname $$dir); \
		done; \
	done
	@echo "Uninstall complete."

clean:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)

$(BUILD_TARGET): $(OBJS) | $(BUILD_DIR)
	$(AR) $(ARFLAGS) $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_SUBDIRS)
	$(CC) $(CPPFLAGS) $(INTERNAL_CFLAGS) $(CFLAGS) -c $< -o $@

$(OBJ_SUBDIRS):
	mkdir -p $@

$(BUILD_DIR):
	mkdir -p $@

.PHONY: all init install uninstall clean
-include $(DEPS)
