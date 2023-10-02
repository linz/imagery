# NZ Imagery bucket website

## Description

This website is an `index.html` landing page deployed on `s3://nz-imagery/` S3 bucket. This page is displayed when accessing `https://nz-imagery.s3.ap-southeast-2.amazonaws.com` to:

- avoid the AWS default `XML` file showing an `s3 list` result to the user
- display the main `README.md` content so the user gets information and links to this repository

## Deployment

The main `README.md` of this repository is converted to a HTML content in an `index.html` file and pushed to `s3://nz-imagery/`.
This is triggered by the GitHub Actions workflow `./github/workflows/publish-site.yml` when the `README.md` file is modified on the `master` branch.

## Development

- `get.assets.sh` is a bash script to get the LINZ template assets (style and images) from the LINZ User Interface (LUI - `@linzjs/lui`) library. This ensure that the style and the logos are up-to-date with the LUI.
- `generate.site.mjs` is the JS script to create the `index.html` page
- `default.html` is the HTML template where the `README.md` converted content is put in, replacing the string `CONTENT_PLACEHOLDER`

## Testing

```shell
npm install
./site/get.assets.sh
node site/generate.site.mjs
```