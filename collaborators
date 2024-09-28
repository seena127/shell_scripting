#!/bin/bash

################
## Author: Sreenivas
# Date: 25-09-2024
# List users with access
################

# GitHub API URL
API_URL="https://api.github.com"


User_name=$username
Token=$gittoken
Repo_owner=$1
Repo_name=$2

# Function that checks if the number of arguments passed is 2 or not
helper() {
    if [ $# -ne 2 ]; then
        echo "Please provide 2 arguments in the format: ./shee.sh repo_owner repo_name"
        exit 1
    fi
}

# Function to create Git URL and check for authentication
git_api_url() {
    local endpoint=$1
    local url="${API_URL}/${endpoint}"

    # Sending a GET request to GitHub API for authentication
    curl -s -u "${User_name}:${Token}" "$url"
}

# Function to list users with read access for a repository
git_list_user() {
    local endpoint="repos/${Repo_owner}/${Repo_name}/collaborators"

    # Fetch list of collaborators in the repository
    collaborators="$(git_api_url "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display user list with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access"
    else
        echo "Users with read access to ${Repo_owner}/${Repo_name}:"
        echo "$collaborators"
    fi
}

# Call the helper function to check for the correct number of arguments
helper "$Repo_owner" "$Repo_name"

echo "Listing users:"
echo "--------------------------------------------------------------------------------"
git_list_user
