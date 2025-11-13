# =============================================================================
# PROJECT: template-lib
# FILE: meson.build
# DESCRIPTION: Meson build configuration for template library
#
# AUTHOR: Your Name <your.email@example.com>
# LICENSE: MIT (change as needed)
# CREATED: YYYY-MM-DD
# MODIFIED: YYYY-MM-DD
#
# Copyright (c) YYYY Your Name
# =============================================================================

project('template-lib', 'c',
  version : '0.0.0',
  license : 'MIT',  # Change as needed
  default_options : [
    'warning_level=2',
    'c_std=gnu23',
    'buildtype=debugoptimized'
  ]
)

# Sources - add more with files()
sources = files(
  'src/lib.c',
  # 'src/util.c',
)

# Headers to install - preserves directory structure
headers = files(
  'include/lib.h',
  # 'include/types.h',
)

# Additional compiler arguments beyond warning_level
add_project_arguments(
  '-fPIC',
  '-pedantic',
  '-Wno-missing-field-initializers',
  language : 'c'
)

# Include directories
inc = include_directories('include')

# Library version (for shared library soname)
lib_version = meson.project_version()
lib_soversion = '0'  # Update when ABI changes

# Build both static and shared libraries
# Use library() which respects default_library option
# Users can control with: -Ddefault_library=static|shared|both
template_lib = library('template-lib',
  sources,
  include_directories : inc,
  version : lib_version,
  soversion : lib_soversion,
  install : true
)

# Alternatively, build both explicitly:
# template_lib_static = static_library('template-lib',
#   sources,
#   include_directories : inc,
#   install : true
# )
#
# template_lib_shared = shared_library('template-lib',
#   sources,
#   include_directories : inc,
#   version : lib_version,
#   soversion : lib_soversion,
#   install : true
# )

# Install headers (preserves paths with preserve_path)
install_headers(headers,
  preserve_path : true,
  subdir : ''  # Install directly to includedir
)

# Generate pkg-config file
pkg = import('pkgconfig')
pkg.generate(template_lib,
  name : 'template-lib',
  description : 'Template library for C projects',
  version : meson.project_version(),
  url : 'https://example.com/template-lib'
)

# Declare dependency for use in other Meson projects
template_dep = declare_dependency(
  link_with : template_lib,
  include_directories : inc
)
