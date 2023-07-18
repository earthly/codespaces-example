# Codespaces Example

An example of how to use Earthly with Docker in Codespaces.

## References

- https://earthly.dev/get-earthly
- https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers
- https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/configuring-dev-containers/specifying-recommended-secrets-for-a-repository


## How To Use

1. Add the .devcontainer folder and contents to the root of your repo
1. Update the example devcontainer.json and Dockerfile to include any other features or settings you require
1. Update the example Earthfile as required by your project
1. Run `Rebuild Container` on your codespace to have it rebuild your devcontainer with the updated configuration
1. Test the installation by running `earthly github.com/earthly/hello-world+hello`
1. Your Earthly commands will now run on docker in Codespaces!

_Note_: It is recommended to login to the docker registry to avoid any rate limiting issues.


