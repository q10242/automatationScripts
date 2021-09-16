#! /bin/bash
current_branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

echo "testmessage"