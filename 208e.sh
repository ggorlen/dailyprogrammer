#!/bin/bash

# 238e: https://www.reddit.com/r/dailyprogrammer/comments/30ubcl/20150330_challenge_208_easy_culling_numbers/cpycok5/

# it's unclear whether this is a set or squeeze
# problem and whether the output can be sorted

#a=($(echo $* | fold -w1 | sort -u ))
#echo "${a[@]}"

last=$1
echo -n "$last "
shift

for e in $*
do
  if [ $e -ne $last ]; then
    echo -n "$e "
  fi

  last=$e
done

echo
