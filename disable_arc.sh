#!/bin/bash
find . -type f \( -name "GNUmakefile" -or -name "GNUmakefile.*" \) \
  -exec ./_disable_arc.sh {} \;
