#!/usr/bin/env bash
docker run -it -v $(pwd):/home/circleci/runtime-ruby alienfast/runtime-ruby:latest /bin/bash
