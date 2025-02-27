#!/bin/bash

# Filename: ex17.sh
#
# Problem: Using awk add two more columns to the table. Calculate the change in currency 
# from the table. Then calculate the percentage of the change relative to the low value.
 
cat ex16.input | awk '{
		printf $0" "
		if ( $2 ~ /^[0-9]+/ ) {
			print "INSERT YOUR CODE HERE"
		} else if ( $2 ~ /^[A-z]+/ ) {
			print "Variation VarPercent"
		} else {
			print ""
		}
	}'
