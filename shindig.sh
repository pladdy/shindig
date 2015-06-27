#!/usr/bin/env bash

shindig_dir=$(dirname $0)
echo "shindir_dir is $shindig_dir"

source "./hush.sh"

# TODO:
# decide if i should remove bash operators and use a more DSL definition
# where something like '==' maps to 'equals'

# TODO:
# put these in a local.sh file to define vars?  maybe global.sh?
testing_quietly=0 # flag to silence one testing group
assert_quietly=0 # flag to silence one assertion

tests=0
assertions=0
test_file=$0 # file sourcing shindig and having tests run

# TODO:
# add report() function to broadcast stats for a testing group and it's
# assertions

# TODO:
# add exit capture to do cleanup/final report call for the last test group

announce() {
  if [ $testing_quietly -eq 0 -a $assert_quietly -eq 0 ]; then
    printf " $*"
  fi
}

assert() {
  if [ "$4" == "quietly" ]; then
    assert_quietly=1
  else
    assert_quietly=0
  fi

  announce "  asserting $*..."

  local assertion=$1
  local operator=$2
  local assumption=$3
  run_test "$assertion" "$operator" "$assumption"
  assertions=$assertions+1
}

run_test() {
  if [ "$2" = "=~" ]; then
    test_regex "$1" "$3"
  else
    test_other "$1" "$2" "$3"
  fi
}

test_other() {
  if [ "$1" $2 "$3" ]; then
    printf "\e[1;92mPass.\e[0m\n"
  else
    printf "\e[1;31mFail.\e[0m\n"
  fi
}

test_regex() {
  if [[ "$1" =~ $2 ]]; then
    printf "\e[1;92mPass.\e[0m\n"
  else
    printf "\e[1;31mFail.\e[0m\n"
  fi
}

testing() {
  if [ "$2" == "quietly" ]; then
    testing_quietly=1
  else
    testing_quietly=0
  fi

  echo "$1";
  tests=$testing+1
}

