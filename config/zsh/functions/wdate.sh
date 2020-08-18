#!/bin/zsh

wdate() {
for tz in 'America/Lima' 'Europe/Berlin'; do
  echo -n "${tz}: "
  TZ="$tz" date
done
}
