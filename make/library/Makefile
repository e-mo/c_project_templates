# =============================================================================
# C MAKEFILE - LIBRARY CONFIGURATION
# =============================================================================
# PROJECT: make_template_lib
# FILE: Makefile
# 
# DESCRIPTION:
# Make template for building a C library (static and shared).
# 
# Part of a two file Make build system:
#  -> Makefile - library project configuration
#     lib.mk   - complex build logic
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

# Project Name
PROJECT := make_template_lib

# Project Version
MAJOR := 0
MINOR := 0
PATCH := 0

# Sources
SRCS := lib.c

# Library Headers
LIB_HEADERS := lib.h

# Directory Structure
SRC_DIR   := src
BUILD_DIR := build
INC_DIR   := include
OBJ_DIR   := $(BUILD_DIR)/obj

# Build both by default
BUILD_STATIC ?= true
BUILD_SHARED ?= true

# Tools
CC ?= gcc
AR ?= ar
RANLIB ?= ranlib
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL)
INSTALL_DATA ?= $(INSTALL) -m 644

# Build Flags
CFLAGS ?= -g -O0
CPPFLAGS ?=
LDFLAGS ?=
LDLIBS ?=
ARFLAGS ?= rcs

INTERNAL_CFLAGS := -std=gnu23 -fPIC -Wall -Wextra -pedantic -Wno-missing-field-initializers

# Install
PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)

LIBDIR ?= $(EXEC_PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include
DESTDIR ?=

include mk/lib.mk
