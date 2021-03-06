#!/bin/bash

version=$1
text=$2
branch=$(git rev-parse --abbrev-ref HEAD)
repo_full_name=$(git config --get remote.origin.url | sed 's/.*:\/\/github.com\///;s/.git$//')
token=$3

generate_post_data()
{
  cat <<EOF
    {
      "tag_name": "$version",
      "target_commitish": "$branch",
      "name": "$version",
      "body": "$text",
      "draft": false,
      "prerelease": false
    }
EOF
}

echo "Create release $version for repo: $repo_full_name branch: $branch"
curl -v -H 'Accept: application/vnd.github.v3+json' -H "Authorization: token $token" --data "$(generate_post_data)" "https://api.github.com/repos/$repo_full_name/releases"

# curl https://api.github.com/repos/evgen66rus/git_release/releases |jq -r '.[0].tag_name'

