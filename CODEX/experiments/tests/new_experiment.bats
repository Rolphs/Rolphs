#!/usr/bin/env bats

load '/usr/lib/bats/bats-support/load'
load '/usr/lib/bats/bats-assert/load'

setup() {
  TMP_REPO="$(mktemp -d)"
  mkdir -p "$TMP_REPO/CODEX/experiments"
  cp "$BATS_TEST_DIRNAME/../new_experiment.sh" "$TMP_REPO/CODEX/experiments/"
  cd "$TMP_REPO/CODEX/experiments"
  mkdir exp000_base
  > exp000_base/README.md
  > exp000_base/notes.md
  git init -q
  git config user.email "test@example.com"
  git config user.name "Test"
  git add exp000_base
  git commit -m "init" >/dev/null
}

teardown() {
  rm -rf "$TMP_REPO"
}

@test "creación del directorio numerado y archivos" {
  run bash new_experiment.sh --no-push <<< "Prueba"
  assert_success
  assert_output --partial "exp001_prueba"
  [ -d exp001_prueba ]
  [ -f exp001_prueba/README.md ]
  [ -f exp001_prueba/notes.md ]
}

@test "falla sin --no-push cuando no hay remoto" {
  run bash new_experiment.sh <<< "Push"
  assert_failure
  assert_output --partial "Error: Falló el push"
}
