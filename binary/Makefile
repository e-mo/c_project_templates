# =============================================================================
# C GENERIC MAKEFILE - BIN
# =============================================================================
 
# Project Metadata
PROJECT := template-bin
VERSION := 0.0.0

# Sources
SRCS := main.c

# Directory Structure
SRC_DIR   := src
BUILD_DIR := build
INC_DIR   := include
OBJ_DIR   := $(BUILD_DIR)/obj

# Build Target
BIN := $(PROJECT)
BUILD_TARGET := $(BUILD_DIR)/$(BIN)

# Tools
CC ?= gcc
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL)

# Build Flags
CFLAGS ?= -g -O2
CPPFLAGS ?= 
LDLIBS ?= 
LDFLAGS ?=

INTERNAL_CFLAGS := -std=gnu23 -fPIC -Wall -Wextra -pedantic -Wno-missing-field-initializers

# Install
PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)

BINDIR ?= $(EXEC_PREFIX)/bin
DESTDIR ?=

ARGS ?=

include mk/bin.mk
