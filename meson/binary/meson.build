# =============================================================================
# PROJECT: template-bin
# FILE: meson.build
# DESCRIPTION: Meson build configuration for template binary
#
# AUTHOR: Your Name <your.email@example.com>
# LICENSE: MIT (change as needed)
# CREATED: YYYY-MM-DD
# MODIFIED: YYYY-MM-DD
#
# Copyright (c) YYYY Your Name
# =============================================================================

project('meson_template_bin', 'c',
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
  'src/main.c',
  # 'src/config.c',
)

# Additional compiler arguments beyond warning_level
add_project_arguments(
  '-pedantic',
  '-Wno-missing-field-initializers',
  language : 'c'
)

# Include directories
inc = include_directories('include')

# Dependencies (examples commented out)
# threads_dep = dependency('threads')
# openssl_dep = dependency('openssl')
# custom_lib = dependency('custom', method : 'pkg-config')

# Build executable
template_bin = executable('template-bin',
  sources,
  include_directories : inc,
  # dependencies : [threads_dep, openssl_dep],
  install : true
)

# Optional: Add tests
# test('basic test', template_bin,
#   args : ['--test']
# )
