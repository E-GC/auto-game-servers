#!/bin/bash

function log_level {
    echo "[${1}] ${2}"
}

function info {
  log_level "INFO" "${1}"
}

function warn {
  log_level "WARN" "${1}"
}

function error {
    log_level "ERROR" "${1}"
}

function fatal {
    log_level "FATAL" "${1}"
    exit 1
}