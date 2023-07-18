# Codespaces Example

An example of how to use Earthly with Docker in Codespaces.

## Overview

Earthly can be run from within configured Codespaces as part of your customized dev environments. It can be added either by:

* Adding the Earthly feature to your devcontainer configuration
* Installing Earthly directly onto your devcontainer Dockerfile

## Compatibility

Earthly has been tested with Codespaces on Github.com and in Visual Stuidio Code.

## References

- [Install Earthly](https://earthly.dev/get-earthly)
- [Codespaces Deep Dive](https://docs.github.com/en/codespaces/getting-started/deep-dive)
- [Devcontainer Introduction](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers)
- [Secrets for Codespaces](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/configuring-dev-containers/specifying-recommended-secrets-for-a-repository)


## Basic Setup

_Note_: It is recommended to login to the docker registry to avoid any rate limiting issues.

1. Add the .devcontainer folder and contents to the root of your repo
1. Update the example devcontainer.json and Dockerfile to include any other features or settings you require
1. Update the example Earthfile as required by your project
1. Run `Rebuild Container` on your codespace to have it rebuild your devcontainer with the updated configuration
1. Test the installation by running `earthly github.com/earthly/hello-world+hello`
1. Your Earthly commands will now run on docker in Codespaces!


### Setup with Satellites (Recommended)

With Satellites you can run Earthly in your devcontainer without needing to install docker or podman! This can allow you to have a more simplified setup as well as faster Earthly build times!

_Note_: At this time the `SAVE IMAGE --push` command in Earthly requires you to have docker or podman installed. If you will be using this command you will still need to include installing docker in your devcontainer otherwise it can be removed.
_Note_: It is recommended you login to your docker registry account to prevent rate limiting issues.


1. Follow the [Basic Setup](#Basic-Setup)
1. If you already have an Earthly account:
    - Login to your Earthly account in your devcontainer `earthly account login --token {YOUR_TOKEN_HERE}`
    
    If you don't alrady have an Earthly account or haven't used satellites before read more about them here:
    - https://docs.earthly.dev/earthly-cloud/satellites
    - Registration: https://cloud.earthly.dev/login
    - Then login with `earthly account login --token {YOUR_TOKEN_HERE}`
1. Launch your satellite: `earthly sat launch {YOUR_SAT_NAME_HERE}`
1. Your Earthly commands will now run on your satellite!


### Setup with Podman (Manually customizing your Devcontainer)

Currently there are known issues with running Earthly with Podman on an environment that uses cgroup v2 on Codespaces (which runs as a Docker container). You can check what version of cgroup your podman installation is using by running:

```podman info | grep cgroup```

These issues are still being investigated at this time and there is no fix available yet. You can confirm that you are being affected by these issues by checking the logs from the earthly-buildkit container if you see `sh: write error: Invalid argument` before the container exits.  

Related to: https://github.com/containers/podman/issues/12559

For more information on Podman with Devcontainers:
    
- https://code.visualstudio.com/remote/advancedcontainers/docker-options#_podman 
    
    This refers to setting up Podman as a remote container instead of as part of the devcontainer. This is for using devcontainers on your local machine rather than within Codespaces.

