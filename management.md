# Tasks

## Release a new version of Gloo

## Update the images for a given version of Gloo

summary: publish a new deployer image that references the correct values


# Notes

## Schema

- It is a marketplace requirement that all images be hosted in gcr, under solo-io-public
- The images must be passed through the schema for optional customization
  - images are specified as an image uri string and parsed into `registry`, `repo`, and `tag` components
- We will use the convention of ingesting these values as shown below:
```
fullUri: glooImages.gloo.full
registry: glooImages.gloo.registry
repo: glooImages.gloo.repository
tag: glooImages.gloo.tag
```
- Images belonging to glooe that are not part of gloo will be nested under `glooEImages` instead of `glooImages`
