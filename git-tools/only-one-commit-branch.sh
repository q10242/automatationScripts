#! /bin/bash
current_branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
commit=$(git log release..GITTOOLS  --oneline | tail -1)

GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash c6c4526~1