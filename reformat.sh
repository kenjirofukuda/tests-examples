#!/bin/bash
 
find . -type f \
       \( \
       -name "*.m" -or \
       -name "*.h" -or \
       -name "*.mm" -or \
       -name "*.c" -or \
       -name "*.cpp" \) -exec astyle {} --options=./gui/_astyle_gnustep --suffix=none \;
