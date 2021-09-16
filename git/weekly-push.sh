#! /bin/bash
# release weekly progress or 
release_branch=release
dev_branch=dev

current_branch_name=$(git symbolic-ref -q HEAD)
current_branch_name=${branch_name##refs/heads/}
current_branch_name=${branch_name:-HEAD}

if [ "$1" = "dev" ]; then
    git checkout dev 
    git pull
    git merge $current_branch_name
    CONFLICTS=$(git ls-files -u | wc -l)
    if [ "$CONFLICTS" -gt 0 ] ; then
        echo "There is a merge conflict. Aborting"
        git merge --abort
        exit 1
    fi
    git push
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