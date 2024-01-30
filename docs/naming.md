# Imagery naming conventions

Imagery is stored according to the majority region that imagery covers while also adhering to a few naming conventions.

## Imagery Path

```
<region>/
  <geographic_description><_survey_number?>_<years>_<resolution>/
    <product>/
      <crs>/
```

### Examples

5cm Aerial RGB imagery covering Hamilton within the Waikato region captured in 2023

```
s3://nz-imagery/waikato/hamilton_2023_0.05m/rgb/2193/collection.json
```

30cm Aerial RGB imagery covering the Waikato region captured in 2016-2019

```
s3://nz-imagery/waikato/waikato_2016-2019_0.3m/rgb/2193/collection.json
```

10cm Aerial RGB imagery covering Ōtorohanga in the Waikaro region captured in 2021 (macron removed)

```
s3://nz-imagery/waikato/otorohanga_2021_0.1m/rgb/2193/rgb/2193/collection.json
```

37.5cm Aerial RGB imagery covering Waikato (primarily) and the Bay of Plenty regions captured in 1981-1982 (scanned from the Crown Aerial Film Archive, recorded as SN5944)

```
s3://nz-imagery/waikato/waikato_bay-of-plenty_sn5944_1981-1982_0.375m/rgb/2193/rgb/2193/collection.json
```

50cm Satellite RGB imagery covering a large part of the North Island captured in 2023

```
s3://nz-imagery/new-zealand/north-island_2023_0.5m/rgb/2193/collection.json
```

### Characters

The path is restricted to a limited set of characters (a-z, A-Z, 0-9, -, \_ ) and no whitespace.

### Macrons

When a name contains macrons "Ōtorohanga" the macron is removed from the path but retained in the STAC Collection's Title / Description.

### Apostrophes

Where a name contains an apostrophe "Hawke's Bay" the apostrophe is removed from the path but retained in the STAC Collection's Title / Description.

### Path components

#### `region`

Is taken from a list of regions

- Northland `northland`
- Auckland `auckland`
- Waikato `waikato`
- Bay of Plenty `bay-of-plenty`
- Gisborne `gisborne`
- Hawke's Bay `hawkes-bay`
- Taranaki `taranaki`
- Manawatū-Whanganui `manawatu-whanganui`
- Wellington `wellington`
- West Coast `west-coast`
- Canterbury `canterbury`
- Otago `otago`
- Southland `southland`
- Tasman `tasman`
- Nelson `nelson`
- Marlborough `marlborough`
- New Zealand `new-zealand`
- Antarctica `antarctica`
- Pacific Islands `pacific-islands`
- Global `global`

#### `geographic_description`

This is free text and at the imagery maintainers discretion. A specific city or sub-region or event name may be used to help describe the imagery capture area. The [Gazetteer](https://gazetteer.linz.govt.nz/) is referenced to ensure official names with correct spelling are used. If the region has full coverage, then the region name should be repeated as the geographic description in order to keep naming consistent.

#### `years`

If the "year" is part of the imagery path, the full four digits should be used even when a range is provided, and in the majority of cases it should be year(s) of capture.

As imagery can be updated after it is "named" the years may be incorrect. It is best to use this as a rough guideline and then use the STAC Collection for a more precise capture timeframe.

### `resolution`

The spatial resolution is the area covered on the ground by a single pixel. This is shown in meters with no trailing zeros after the decimal point.

### `product`

Imagery product type, generally this is `rgb` as it is the primary imagery type for LINZ. Black and white imagery scanned from the Crown Aerial Film Archive is still stored as RGB, given that WEBP Lossless compression is more effective on 3-band RGB than other compression options that support single-band TIFFs.

### `crs`

EPSG Code for the coordinate reference system of the imagery. Generally this is [`2193`](https://epsg.io/2193) as it is the primary projection for most of LINZ's imagery.
