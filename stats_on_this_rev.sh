#!/usr/bin/env bash
set -e

#
# Prints some statistics about the current revision
#

ruby_files() {
  find . -iname "*.rb"
}

test_files() {
  ruby_files | grep spec
}

app_files() {
  ruby_files | grep -v spec
}

sources_lines_of_code() {
  for file in `app_files`; do
    cat $file
  done |
  wc -l
}

test_lines_of_code() {
  for file in `test_files`; do
    cat $file
  done |
  wc -l
}

test_production_code_ratio() {
  echo "`test_lines_of_code` / `sources_lines_of_code`" | calc
}

total_lines_of_code() {
  echo "`sources_lines_of_code` + `test_lines_of_code`" | calc
}

test_time() {
  bin/rspec > /dev/null
  bin/rspec | grep Finished | cut -d  ' ' -f 3
}

number_of_files() {
  ruby_files | wc -l
}

main() {
  echo `sources_lines_of_code`,`test_lines_of_code`,`test_production_code_ratio`,`total_lines_of_code`,`number_of_files`,`test_time` | sed 's/ *//g'
}

main
