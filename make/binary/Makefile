# =============================================================================
# C MAKEFILE - BINARY CONFIGURATION
# =============================================================================
# PROJECT: make_template_bin
# FILE: Makefile
# 
# DESCRIPTION:
# Make template for building a C binary.
# 
# Part of a two file Make build system:
#  -> Makefile - binary project configuration
#     bin.mk   - complex build logic
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
PROJECT := make_template_bin

# Project Version
MAJOR := 0
MINOR := 0
PATCH := 0

# Sources
SRCS := main.c

# Directory Structure
SRC_DIR   := src
BUILD_DIR := build
INC_DIR   := include
OBJ_DIR   := $(BUILD_DIR)/obj

# Tools
CC ?= gcc
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL)

# Build Flags
CFLAGS ?= -g -O0
CPPFLAGS ?= 
LDLIBS ?= 
LDFLAGS ?=

INTERNAL_CFLAGS := -std=gnu23 -Wall -Wextra -pedantic -Wno-missing-field-initializers

# Install
PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)

BINDIR ?= $(EXEC_PREFIX)/bin
DESTDIR ?=

ARGS ?=

include mk/bin.mk
