#! /bin/bash
current_branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
last_commit=$(git log release..GITTOOLS  --oneline | tail -1)
last_commit=${commit:0:7}
git cherry   release ${current_branch_name}
# sed -i "'s/^pick ce5efdb /edit ce5efdb /;/^pick ce6efdb /d'"

GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash release~1
