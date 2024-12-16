# New Zealand Imagery

[![STAC Browser Badge](https://img.shields.io/badge/Open_in_STAC_Browser-%2309B3AD?style=flat&label=New%20Zealand%20Imagery&labelColor=%23144E63)](https://radiantearth.github.io/stac-browser/#/external/nz-imagery.s3-ap-southeast-2.amazonaws.com/catalog.json)
[![AWS Badge](https://img.shields.io/badge/Open_in_Registry_of_Open_Data_on_AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white&labelColor=%23232F3E)](https://registry.opendata.aws/nz-imagery/)

Toitū Te Whenua makes New Zealand's most up-to-date publicly owned aerial imagery freely available to use under an open licence. You can access this through the [LINZ Data Service](https://data.linz.govt.nz/data/category/aerial-photos/?s=n), [LINZ Basemaps](https://basemaps.linz.govt.nz/#@-41.8899962,174.0492437,z5) or the [Registry of Open Data on AWS](https://registry.opendata.aws/nz-imagery/).

## Quickstart

Browse the archive with [STAC Browser](https://radiantearth.github.io/stac-browser/#/external/nz-imagery.s3-ap-southeast-2.amazonaws.com/catalog.json) or access the catalog directly [https://nz-imagery.s3-ap-southeast-2.amazonaws.com/catalog.json](https://nz-imagery.s3-ap-southeast-2.amazonaws.com/catalog.json)

## Background

This repository contains STAC Collection metadata for each imagery dataset, as well as some guidance documentation:

- [Naming](docs/naming.md) covers the `s3://nz-imagery` bucket naming structure
- [Tools](docs/tools.md) covers some of the STAC ecosystem tools that can be used to interact with our STAC Catalog
- [Usage](docs/usage.md) shows how TIFFs can be interacted with from S3 using GDAL, QGIS, etc

### AWS Access

Toitū Te Whenua owns and maintains a public bucket which is sponsored and shared via the [Registry of Open Data on AWS](https://registry.opendata.aws/nz-imagery/) `s3://nz-imagery` in `ap-southeast-2`.

Using the [AWS CLI](https://aws.amazon.com/cli/) anyone can access all of the imagery specified in this repository.

```
aws s3 ls --no-sign-request s3://nz-imagery/
```

## Related

For access to LINZ's elevation data see [linz/elevation](https://github.com/linz/elevation)

## License

Source code is licensed under [MIT](LICENSE).

All metadata and docs are licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

For [more information on imagery attribution](https://www.linz.govt.nz/products-services/data/licensing-and-using-data/attributing-elevation-or-aerial-imagery-data).
