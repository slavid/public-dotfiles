#!/bin/bash
REGEX=(
".*foo.*" 
".*faa.*" 
".*fii.*"
)

for reg in "${REGEX[@]}"
do
	if [[ $1 =~ $reg ]]; then
		break
#		echo "Contains $reg";
	else
		exit 1
#		echo "Not contains foo";
#		echo $1;
#		echo $reg
	fi
done

echo "Contains $reg";
exit 0
