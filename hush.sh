#!/usr/bin/env bash

# TODO:
# move hush variables here?

hush() {
  if [ "$2" == "quietly" ]; then
    case "$1" in
      "testing") testing_quietly=1 ;;
      "assert")  assert_quietly=0 ;;
    esac
  fi
}

hushed_assertion() {
  if [ $test_quietly -eq 1 -o $assert_quietly -eq 1 ]; then
    echo 1
  else
    echo 0
  fi
}

hushed_test() {
  if [ $test_quietly -eq 1 ]; then
    echo 1
  else
    echo 0
  fi
}
