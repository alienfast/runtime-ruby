#!/usr/bin/env bash
docker run -it -v $(pwd):/home/circleci/runtime-ruby alienfast/ci-ruby:latest /bin/bash
