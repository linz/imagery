# GitHub Copilot Review Instructions

This repository contains STAC Collection metadata for New Zealand aerial imagery datasets. It also contains configuration files for data publishing

## publish-odr-parameters

When aerial imagery is published to the Registry of Open Data on AWS, a configuration file is created here containing some parameters for the publishing process.

### Parameter Files

- Parameter files are named with the `id` from the `collection.json` at the start of the file name and then a timestamp appended to the end of the file name.
- There should be a maximum of one new `publish-odr-parameters` file added per Pull Request. If there is more than one, older parameter files should be deleted. There can also be zero parameter files, if only `collection.json` metadata is being updated.
- The `target` is `"s3://nz-imagery/{region}/{survey}/{product}/{projection}/"` which should align to the dataset metadata stored in this repository at `stac/{region}/{survey}/{product}/{projection}/collection.json`.
- The `region` in the parameter file must match the region directory name in the repository path `stac/{region}/`.
- The `copy_option` should be `--force-no-clobber` if there are any `file:checksum` values being modified in the `collection.json` file within the same Pull Request. If the Pull Request only contains links to new items with new `file:checksum` values, then the `copy_option` should be `--no-clobber`.

## stac

Each dataset's metadata lives under `stac/{region}/{survey}/{product}/{projection}/collection.json`. When reviewing changes to `collection.json` files, check the following rules.

### General Fields

- `id` must be a valid ULID: 26 characters using Crockford base32 (`[0-9A-HJKMNP-TV-Z]`). It must be unique across all collections in the repository.
- The `id` of a dataset must not change.
- `stac_extensions` must be present and must be an array (use `[]` if no extensions apply).
- `license` must be exactly `"CC-BY-4.0"`.
- `gsd` should not contain units of measurement.
- The `created` and `updated` datetimes must be present and valid and must not be future datetimes. The `created` date cannot be after the `updated` date.

### Title

- `title` must be present.
- The title must include a year or year range in parentheses, e.g. `(2026)` or `(2024-2025)`. Temporal extents are stored in UTC but titles reflect NZDT (UTC+13), so a 1-day difference between the temporal extent and the title at year boundaries is acceptable.
- If the title contains `"Draft"`, `linz:lifecycle` must be `"ongoing"`.
- If the title contains `"Near-Infrared"` then the repository path must be `stac/{region}/{survey}/rgbnir/`.
- If the repository path is `stac/{region}/{survey}/rgbnir/` then the title must contain `"Near-Infrared"`.
- If the title contains a survey number, it must match one of the following forms: `SN` or `SNC` followed by 1 to 5 digits (e.g. `SN167`, `SNC144`, `SN11624`, `SNC25049`). Any value that looks like a survey number but does not match this pattern (e.g. `SNCC100`, `SN4637C`, `SN1234567`) should be flagged.

### Links

- There must be a link with `rel: "root"` and a link with `rel: "self"`.
- There must be at least one link with `rel: "item"`.
- All link `href` values must start with `https` or `./`.
- The root link href must be `"https://nz-imagery.s3.ap-southeast-2.amazonaws.com/catalog.json"`.
- The self link href must be `"./collection.json"`.

### Providers

- `providers` must be a non-empty array.
- Every provider must have a `name` field.
- Provider `roles` must only contain values from the STAC spec: `producer`, `licensor`, `processor`, `host`.
- Provider names must be consistent with those used in other collections. Avoid near-duplicate names that differ only by punctuation, abbreviation, or capitalisation (e.g. `"Aerial Surveys Ltd"` vs `"Aerial Surveys"`). Use the form that appears most frequently across the repository.

### Extent

- `extent.spatial.bbox` must be present, contain exactly one bounding box of 4 elements `[west, south, east, north]`, and fall within the NZ region (longitude 160–180, latitude -48 to -34). West must be less than east; south must be less than north.
- `extent.temporal.interval` must be present and contain exactly one interval of 2 elements. The start datetime must be present and valid. If an end datetime is provided it must be valid and not before the start.

### Assets

- `capture_area` must be present and its `href` value should be exactly `"./capture-area.geojson"`.
- The `file:size` of the `capture_area` should not exceed 500000 (bytes).

### LINZ-specific Fields

- If `linz:lifecycle` is `"ongoing"`, the title must contain `"Draft"`.
- `linz:region` must be present and must match the region directory name in the repository path `stac/{region}/`.
- `linz:security_classification` must be present and must be exactly `"unclassified"`.
- `linz:slug` must be present and must match the survey directory name in the repository path `stac/{region}/{survey}/`.
- `linz:geographic_description`, if present, must be consistent with the same field in other collections. Avoid very-near-duplicate values that differ only by minor spelling or punctuation — use the form that appears most frequently across the repository.
- If `linz:geospatial_category` is `"urban-aerial-photos"` and a `gsd` field is present, the value must be less than `0.2` (20 cm).
- If the `gsd` field is less than `0.2` and a `linz:geographic_description` is present, the `linz:geospatial_category` should be `"urban-aerial-photos"`.
