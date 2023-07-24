# Codespaces Example

An example of how to use Earthly with Docker in Codespaces.

The repo is provided as a template for any new repos you would like to create using Earthly.
For setup steps for existing repositories select from the [Setup](#setup) sections below.

## Overview

Earthly can be run from within configured Codespaces as part of your customized dev environments. It can be added either by:

* Adding the Earthly feature to your devcontainer configuration
* Installing Earthly directly onto your devcontainer Dockerfile

## Compatibility

Earthly has been tested with Codespaces on Github.com and in Visual Studio Code.

## References

- [Install Earthly](https://earthly.dev/get-earthly)
- [Devcontainer Introduction](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers)
- [Codespaces Deep Dive](https://docs.github.com/en/codespaces/getting-started/deep-dive)
- [Secrets for Codespaces](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/configuring-dev-containers/specifying-recommended-secrets-for-a-repository)

## Setup

### Basic Setup

The basic setup for Earthly in Codespaces uses Docker for running Earthly.

1. Add the .devcontainer folder and contents to the root of your repo
1. Update the example devcontainer.json and include any other features or settings you require
1. Update the example Earthfile as required by your project
1. Run `Rebuild Container` on your codespace to have it rebuild your devcontainer with the updated configuration
1. Test the installation by running `earthly github.com/earthly/hello-world+hello`
1. Your Earthly commands will now run on docker in Codespaces!

_Note_: It is recommended to login to DockerHub to avoid any rate limiting issues. Follow the guide linked in the devcontainer.json for how to setup your secrets in your codespace. The postCreateCommand.sh script will then handle login on startup for you.

### Setup with Satellites (Recommended)

With Satellites you can run Earthly in your devcontainer and only optionally install docker or podman if you prefer a smaller devcontainer environment. Other benefits include sharing compute and cache with your coworkers or CI for faster build times and benefiting from high-bandwidth internet access from the satellite.

This example uses the Earthly devcontainer feature for simplicity.

_Note_: If you do want to use Earthly on Codespaces without installing docker or podman: At this time to use `SAVE IMAGE --push` command in Earthfiles without docker or podman installed requires you to use the `--no-output` flag. For example `earthly --org my-org --no-output --push +hello`

1. Follow the [Basic Setup](#basic-setup) steps 1-3 above
1. If you already have an Earthly account:
    - Add your Earthly login token as a Codespaces secret `EARTHLY_TOKEN`
    
    If you don't have an Earthly account, or haven't used satellites before, read more about them here:
    - [Earthly Satellites](https://docs.earthly.dev/earthly-cloud/satellites)
    - [Earthly Login/Registration](https://cloud.earthly.dev/login)
    - [Earthly Create Token](https://docs.earthly.dev/docs/earthly-command#earthly-account-create-token)
    - Then add your Earthly login token as a Codespaces secret `EARTHLY_TOKEN`
1. Set your Earthly org name in devcontainer.json: `EARTHLY_ORG`
1. Set your Satellite name in devcontainer.json: `EARHTLY_SATELLITE`
1. Run `Rebuild Container` on your codespace to have it rebuild your devcontainer with the updated configuration
1. Test your satellelite is setup by viewing the `Creation Log` or run `earthly sat --org ${YOUR ORG NAME} ls` to check its status
1. Your Earthly commands will now run on your satellite!

### Setup with Podman (Manually customizing your Devcontainer)

Currently there are known issues with running Earthly with Podman on an environment that uses cgroup v2 on Codespaces (which runs as a Docker container). You can check what version of cgroup your podman installation is using by running:

```podman info | grep cgroup```

These issues are still being investigated at this time and there is no fix available yet. 

You can confirm that you are being affected by these issues by checking the logs from the earthly-buildkit container via `podman logs {YOUR_CONTAINER_ID_HERE}`. If you see `sh: write error: Invalid argument` before the container exits you are affected by this issue.  

Related to: [Podman-on-Docker building fails on cgroup2 enabled systems](https://github.com/containers/podman/issues/12559)

For more information on Podman with Devcontainers:
    
- [Advanced Containers - Podman](https://code.visualstudio.com/remote/advancedcontainers/docker-options#_podman) 
    
    _Note_: This doc refers to setting up Podman as a remote container instead of as internal to the devcontainer.

