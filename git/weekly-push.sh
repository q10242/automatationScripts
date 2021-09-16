#! /bin/bash
# release weekly progress or 
release_branch=release
dev_branch=dev

current_branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

if [ "$1" = "dev" ]; then
    git add .
    git commit -m "[${current_branch_name}] terminating commit to merge"
    git checkout dev 
    git pull
    git merge $current_branch_name --no-edit
    CONFLICTS=$(git ls-files -u | wc -l)
    if [ "$CONFLICTS" -gt 0 ] ; then
        echo "There is a merge conflict. Aborting"
        exit 1
    fi
    git push
    git checkout $current_branch_name
    echo $current_branch_name
     # tes
elif [ "$1" = "release" ]; then
    git checkout release 
    git pull
    git merge $current_branch_name
    CONFLICTS=$(git ls-files -u | wc -l)
    if [ "$CONFLICTS" -gt 0 ] ; then
        echo "There is a merge conflict. Aborting"
        git merge --abort
        exit 1
    fi
    git push
else
    echo "argument must be dev or release"
fi