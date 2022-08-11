# Docker Images Collection

Docker images used to build production and development containers.

## List of Available Images

This repository contains the following image:

| Name | Description | Version |
| ---- | ----------- | ------- |
| [LaTeX](./latex) | LaTeX documents preparation toolbox | [0.0.2](./latex/VERSION) |
| [Rust](./rust) | Rust compiler tools | [1.62.1](./rust/VERSION)
| [Sandbox](./sandbox) | VSCode development sandbox's base image | [0.0.2](./sandbox/VERSION)

## Versioning Mechanism

As a mono-repository, each image evolves at its own pace, independently of other images in the repository. In order to update an image's version, 
the new [semantic versioning](https://semver.org) number must be added at the end of the image's `VERSION` file. Suppose you want to upgrade the [LaTeX](./latex) image to a new version `0.1.4`, and that the LaTeX's [VERSION](./latex/VERSION) file looks like this:

```sh
0.1.0
0.1.1
0.1.2
0.1.3
```

Here, the current (latest) image version number is `0.1.3`. In order to bump the image to version `0.1.4` you simply add a new line as shown below:

```sh
0.1.0
0.1.1
0.1.2
0.1.3
0.1.4         <== new image version
```

As show below, you then add, commit and push the new VERSION file to the repository and the Github Actions [release](.github/workflows/release.yml) workflow will build and publish the new image to the [Github Container Registry (GCR)](https://github.com/orgs/AutonomyOrg/packages?repo_name=docker-images):

```sh
$ git add ./latex/VERSION
$ git commit -m "Update LaTeX image to version 0.1.4"
$ git push
```