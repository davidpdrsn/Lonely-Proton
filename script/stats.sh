#!/usr/bin/env bash
set -e

if [ -e stats.csv ]; then
  rm stats.csv
fi

echo "sources lines of code,test lines of code,test production code ratio, total lines of code,number of files,test time,number of classes" >> stats.csv
run-command-on-git-revisions $1 $2 "sh stats_on_this_rev.sh" >> stats.csv
