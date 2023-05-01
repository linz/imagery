# New Zealand Imagery

Toitū Te Whenua makes New Zealand’s most up-to-date publicly owned aerial imagery freely available to use under an open licence. You can access this through the [LINZ Data Service](https://data.linz.govt.nz/data/category/aerial-photos/?s=n), [LINZ Basemaps](https://basemaps.linz.govt.nz/#@-41.8899962,174.0492437,z5) or Amazon AWS.

This repository contains STAC metadata for each imagery dataset, as well as some guidance documentation for storage structure and naming.

## AWS Access

Toitū Te Whenua provides a public requester pays bucket `s3://linz-imagery` in `ap-southeast-2`.

Using the [AWS CLI](https://aws.amazon.com/cli/) anyone with a AWS account can access all the imagery mentioned inside of this repository.

```
aws s3 ls s3://linz-imagery --request-payer requester
```

## License

Source code is licensed under [MIT](LICENSE).

All metadata and docs are licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).  

For [more information on imagery attribution](https://www.linz.govt.nz/products-services/data/licensing-and-using-data/attributing-elevation-or-aerial-imagery-data).
