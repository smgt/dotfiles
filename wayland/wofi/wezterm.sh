#!/usr/bin/env bash

printf "paprika\ngrunte\nsugarsnap\n" | wofi --show dmenu | {
  read -r host
  wezterm connect "$host"
}
