# =============================================================================
# C CONFIG MAKEFILE - LIB
# =============================================================================
 
# Project Metadata
PROJECT := template-lib
VERSION := 0.0.0

# Sources
SRCS := lib.c

# Library Headers
LIB_HEADERS := lib.h

# Directory Structure
SRC_DIR   := src
BUILD_DIR := build
INC_DIR   := include
OBJ_DIR   := $(BUILD_DIR)/obj

# Build Target
LIB := lib$(PROJECT).a
BUILD_TARGET := $(BUILD_DIR)/$(LIB)

# Tools
CC ?= gcc
AR ?= ar
RANLIB ?= ranlib
INSTALL ?= install
INSTALL_DATA ?= $(INSTALL) -m 644

# Build Flags
CFLAGS ?= -g -O0
CPPFLAGS ?=
ARFLAGS ?= rcs

INTERNAL_CFLAGS := -std=gnu23 -fPIC -Wall -Wextra -pedantic -Wno-missing-field-initializers

# Install
PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)

LIBDIR ?= $(EXEC_PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include
DESTDIR ?=

include mk/lib.mk
