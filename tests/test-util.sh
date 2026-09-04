#!/usr/bin/env bash

source "$(dirname "$0")/../setup/util.sh"

title "Util test"

success "Basic success" "descriptive message"
warn "Basic warn" "descriptive message"
fail "Basic fail" "descriptive message"
info "Basic info" "descriptive message"
skip "Basic skip" "descriptive message"

echo ""

quote "Some quote"
quote "That spans multiple lines"

echo ""

cmd "Running a command"
