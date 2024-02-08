# Imagery Dataset Naming Conventions

Imagery dataset titles and S3 paths are constructed from metadata about each imagery survey so that they will be consistent and human readable. Imagery is stored according to the majority region that each dataset covers.

## Imagery Dataset Titles

The imagery dataset title is constructed from metadata that is entered when an imagery dataset is processed.

```
[<geographic_description>|<region>] <gsd>m [<geospatial_category>|<survey_number>] (<start_year>[-<end_year>?])[ - <lifecycle>?]
```

## Imagery Dataset S3 Paths

The imagery dataset S3 path is also constructed from similar metadata.

```
<region>/
  [<geographic_description>|<region>][_<survey_number>?]_<start_year>[-<end_year>?]_<gsd>m/
    <product>/
      <crs>/
```

### S3 Path Restrictions

#### Characters

The path is restricted to a limited set of characters (a-z, A-Z, 0-9, -, \_ ) and no whitespace.

#### Macrons

When a name contains macrons, for example "Ōtorohanga", the macron is removed from the path but retained in the STAC Collection's Title / Description.

#### Apostrophes

Where a name contains an apostrophe, for example "Hawke's Bay", the apostrophe is removed from the path but retained in the STAC Collection's Title / Description.

## Title and S3 Path Components

### `crs`

EPSG Code for the coordinate reference system of the imagery. Generally this is [`2193`](https://epsg.io/2193) as it is the primary projection for most of LINZ's imagery.

### `geographic_description`

This is free text and at the imagery maintainers discretion. A specific city or sub-region or event name may be used to help describe the imagery capture area. The [Gazetteer](https://gazetteer.linz.govt.nz/) is referenced to ensure official names with correct spelling are used. If the region has full coverage, then the geographic description can be empty and the region will be used instead.

### `geospatial_category`

A general categorisation of imagery held within our archive that includes the following possible values:

- Aerial Photos `aerial-photos`
- DEM `dem` (only used in nz-elevation bucket)
- DSM `dsm` (only used in nz-elevation bucket)
- Rural Aerial Photos `rural-aerial-photos`
- Scanned Aerial Photos `scanned-aerial-photos`
- Satellite Imagery `satellite-imagery`
- Urban Aerial Photos `urban-aerial-photos`

### `gsd`

The GSD or spatial resolution is the area covered on the ground by a single pixel. This is stored in metadata in metres with no trailing zeros after the decimal point.

### `lifecycle`

If `lifecycle = preview` then ` - Draft` is appended to the end of the imagery dataset title. 

### `product`

Imagery product type, generally this is `rgb` as it is the primary imagery type for LINZ. Black and white imagery scanned from the Crown Aerial Film Archive is still stored as RGB, given that WEBP Lossless compression is more effective on 3-band RGB than other compression options that support single-band TIFFs.

### `region`

Is taken from a list of regions:

- Antarctica `antarctica`
- Auckland `auckland`
- Bay of Plenty `bay-of-plenty`
- Canterbury `canterbury`
- Northland `northland`
- Gisborne `gisborne`
- Global `global`
- Hawke's Bay `hawkes-bay`
- Manawatū-Whanganui `manawatu-whanganui`
- Marlborough `marlborough`
- Nelson `nelson`
- New Zealand `new-zealand`
- Otago `otago`
- Pacific Islands `pacific-islands`
- Southland `southland`
- Taranaki `taranaki`
- Tasman `tasman`
- Waikato `waikato`
- Wellington `wellington`
- West Coast `west-coast`

### `start_year` and `end_year`

In both cases, the full four digits should be used. If the imagery dataset was entirely captured within one year, then only a `start_year` is provided.

As imagery can be updated after it is "named" for initial processing the `end_year` or lack of an `end_year` may be incorrect in the S3 Path. It is best to use this as a rough guideline and then use the STAC Collection for a more precise capture timeframe.

### `survey_number`

A survey number reference from the Crown Aerial Film Archive. This will only be included if the imagery dataset is georeferenced historical aerial imagery from the Archive. If it is available, it will replace the `geospatial_category` in the imagery dataset title, and optionally be included in the imagery dataset path.

## Examples

5cm Aerial RGB imagery covering Hamilton within the Waikato region captured in 2023

```
Title: Hamilton 0.05m Urban Aerial Photos (2023)
Path: s3://nz-imagery/waikato/hamilton_2023_0.05m/rgb/2193/collection.json
```

30cm Aerial RGB imagery covering the Waikato region captured in 2016-2019

```
Title: Waikato 0.3m Rural Aerial Photos (2016-2019)
Path: s3://nz-imagery/waikato/waikato_2016-2019_0.3m/rgb/2193/collection.json
```

10cm Aerial RGB imagery covering Ōtorohanga in the Waikato region captured in 2021 (macron removed in imagery dataset path)

```
Title: Ōtorohanga 0.1m Urban Aerial Photos (2021)
Path: s3://nz-imagery/waikato/otorohanga_2021_0.1m/rgb/2193/rgb/2193/collection.json
```

37.5cm Aerial RGB imagery covering Waikato (primarily) and the Bay of Plenty regions captured in 1981-1982 (scanned from the Crown Aerial Film Archive, recorded as SN5944)

```
Title: Waikato / Bay of Plenty 0.375m SN5944 (1981-1982)
Path: s3://nz-imagery/waikato/waikato_bay-of-plenty_sn5944_1981-1982_0.375m/rgb/2193/rgb/2193/collection.json
```

15cm Aerial RGB imagery covering Nelson (primarily) captured in 2022 

```
Title: Top of the South Flood 0.15m Aerial Photos (2022)
Path: s3://nz-imagery/nelson/top-of-the-south-flood_2022_0.15m/rgb/2193/collection.json
```

50cm Satellite RGB imagery covering a large part of the North Island captured in 2023

```
Title: Cyclone Gabrielle North Island 0.5m Satellite Imagery (2023)
Path: s3://nz-imagery/new-zealand/cyclone-gabrielle-north-island_2023_0.5m/rgb/2193/collection.json
```
