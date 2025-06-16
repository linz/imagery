# Publishing

This documentation intends to describe our data publishing process. This process involves multiple part of our system and it can be useful to understand how each piece are chained together.

![publishing](img/publishing/publishing_to_odr.png)

## Processing

It is initiated by a user (data manager) triggering an `imagery-standardising` workflow using Argo Workflows. This workflow standardises the data (COG) and metadata (STAC). The standardised data is stored in a staging location (workflow "scratch" bucket).

## Publishing the data

### GitHub Pull Request

It is either triggered by the same workflow that process the data as an extra step, or by a stand alone workflow otherwise.
This workflow takes the standardised data from its staging location and create a GitHub Pull Request on this repository. This PR acts like a quality check tool: The STAC Catalog is re-generated and the STAC validated, the data can be viewed served by `linz/basemaps` through the link in the PR description and the STAC Collection can be view and amended as a PR file. Once the data has been checked and is ready to go, the reviewer can click on the merging button to trigger publishing the dataset to the Registry of Open Data.

### GitHub Actions

The Publish GitHub Actions (`publish.yml`) is triggered when the PR is merged to the `master` branch.
This Action through the `publish-odr` step
