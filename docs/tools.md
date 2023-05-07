# Tools to consume STAC metadata

A list of tools is available on [the STAC website](https://stacspec.org/en/about/tools-resources/).

## Stac Browser

[Stac Browser](https://github.com/radiantearth/stac-browser) is a web application that provides a UI to search and view STAC metadata. It takes a Catalog or a Collection as the entrypoint to allow the user to navigate through the metadata.
To deploye a STAC Browser, you can follow [this documentation](https://github.com/radiantearth/stac-browser#get-started).
For a quick start, you can use [the demo instance](https://radiantearth.github.io/stac-browser/), pass the link to the STAC Catalog `https://linz-imagery.s3-ap-southeast-2.amazonaws.com/catalog.json` and click on the `Load` button.

### Filtering the data

The Collection can be filtered, in this example showing up all the `0.075m` imagery metadata:

![filter](img/tools/stac_browser_filter.png)

### Viewing Collection details

Clicking on a Collection shows the details:

![collection](img/tools/stac_browser_collection.png)
