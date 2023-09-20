# NZ Imagery bucket website

## Description

This website is a `index.html` landing page deployed on `s3://nz-imagery/` S3 bucket. This page is displayed when accessing `https://nz-imagery.s3.ap-southeast-2.amazonaws.com` to:

- avoid the AWS default `XML` file showing a `s3 list` result to the user
- display the main `README.md` content so the user get information and links to this repository

## Deployment

The main `README.md` of this repository is converted to a HTML content in a `index.html` file and pushed to `s3://nz-imagery/`.
This is triggered by the GitHub Actions workflow `./github/workflows/publish-site.yml` when the `README.md` file is modified on the `master` branch.

## Development

- `generate.site.mjs` is the JS script to create the `index.html` page
- `default.html` is the HTML template where the `README.md` converted content is put in, replacing the string `CONTENT_PLACEHOLDER`
- `css/` and `img/` folders are where the static content is stored. The `index.html` page links directly to this content hosted on GitHub (rather than pushing these folders to `s3://nz-imagery/`)
- `update.sh` is a bash script to update the LINZ template assets (style and images) from the `@linzjs/lui` library
