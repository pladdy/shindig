#!/usr/bin/env bash

source "./shindig.sh"
echo "i'm in tests.sh : $0"

testing "some basic assertions for numbers and strings" ; {
  assert 1 == 1;
  assert 1 == 0;
  assert 1 != 0;

  assert 1 -gt 0;
  assert 4 -ge 4;
  assert 4 -lt 5;
  assert 4 -le 4;

  assert 1 -eq 1;
  assert 1 -ne 0;

  assert "this is a string" = "this is a string";
  assert "this is a string" == "this is a string";
  assert "this is a string" = "different string";
  assert "this string" != "that string";

  assert "this" =~ "^th"
  assert "winnie the pooh" =~ "the pooh$"
}

testing "some ls output...quietly" quietly ; {
  assert "$(ls)" = "$(ls)"
}

# same as above but only keeping the assertion quiet.  useful on tests with
# multiple noisy assertions you want to quiet down
testing "some more ls output...quietly" ; {
  assert "$(ls)" = "$(ls)" quietly
}

testing "even more ls output...but loudly" ; {
  assert "$(ls)" = "$(ls)"
}

