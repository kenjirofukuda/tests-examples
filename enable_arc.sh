#!/bin/bash
find . -type f \( -name "GNUmakefile" -or -name "GNUmakefile.*" \) \
  -exec ./_enable_arc.sh {} \;
