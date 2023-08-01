#!/bin/sh
set -e

# Check if DockerHub login creds present and if so login
dockerhub_login() {
    if [[ -n "${DOCKERHUB_USERNAME}" || -n "${DOCKERHUB_PASSWORD}" ]]; then
        if docker login --username ${DOCKERHUB_USERNAME} --password ${DOCKERHUB_PASSWORD} 2>/dev/null; then
            echo "Login to DockerHub succeeded"
        else 
            echo "Login to DockerHub failed"
        fi
    fi
}

# Check if Earthly token present and if so login
earthly_login() {
    if [[ -n "${EARTHLY_TOKEN}" ]]; then
        # account login reads fron EARTHLY_TOKEN env var
        if earthly account login 2>/dev/null; then
            echo "Login to Earthly succeeded"
            if [[ -n "${EARTHLY_ORG}" ]]; then
                if earthly org select ${EARTHLY_ORG} 2>/dev/null; then
                    select_earthly_satellite
                else
                    echo "Failed to select Earthly Org"
                fi
            fi
        else
            echo "Login to Earthly failed"
        fi
    fi
}

# Function to login to earthly satellite if logged in Earthly Account has a valid org
select_earthly_satellite() {
    if [[ -n "${EARTHLY_ORG}" ]]; then
        if [[ $(earthly sat --org ${EARTHLY_ORG} ls | grep ${EARHTLY_SATELLITE}) ]]; then
            echo "Your Earthly Satellite already exists. Selecting..."
            earthly sat --org ${EARTHLY_ORG} select ${EARHTLY_SATELLITE}
        else
            echo "Your Earthly Satellite does not yet exist. Launching..."
            earthly sat --org ${EARTHLY_ORG} launch ${EARHTLY_SATELLITE}
        fi
    else 
        echo "No Earthly Org set, satellite will not be launched"
    fi
}

dockerhub_login
earthly_login
