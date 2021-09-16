#! /bin/bash
# release weekly progress or 
release_branch=release
dev_branch=dev

current_branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
git add .
git commit -m "[${current_branch_name}] terminating commit to merge"

if [ "$1" = "dev" ]; then
    git checkout dev 
elif [ "$1" = "release" ]; then
    git checkout release 
else
    echo "argument must be dev or release"
    exit 1
fi

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
