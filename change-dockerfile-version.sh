#!/usr/bin/env bash
find .. -name Dockerfile -type f -maxdepth 5 -print0 | xargs -0 sed -i '' 's/FROM runtime-ruby:.*$/runtime-ruby:1.0.0/g'
