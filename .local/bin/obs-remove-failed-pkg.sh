#!/bin/bash

[[ $# -lt 1 ]] && exit 1

dir=$1

for a in $dir/*; do 

pushd "${a}"
status=$(osc r | tr -s ' ' | cut -d' ' -f 3)
echo Status of package $(basename ${a}) is $status

if [[ $status = 'failed' || $status = 'unresolvable' || $status = 'broken' ]]; then

echo Should i delete $a?
read -t 10 -N 1 -p 'Y/N: ' answer

case $answer in
    y|Y)
	pushd ..
	osc remove $(basename $a)
	popd
	;;
    *)
	continue
esac

fi

popd

done
