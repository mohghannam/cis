#!/bin/bash
input=/usr/share/cis/stickybit
while IFS= read -r line
do
	chmod o-t $line
done < $input
