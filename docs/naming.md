# Imagery naming conventions

Imagery is named according to the majority region that imagery covers while also adhering to a few naming conventions.

## Imagery Path

```
<region>/
  <city-or-sub-region>_<year>_<resolution>/
    <product>/
      <crs>/
```

### Examples

7.5cm RGB imagery covering Auckland captured in 2022

```
s3://nz-imagery/auckland/auckland_2022_0.075m/rgb/2193/collection.json
```

10m Satellite RGB imagery covering the North Island captured in 2023

```
s3://nz-imagery/new-zealand/north-island_2023_10m/rgb/2193/collection.json
```

### Characters

The path is restricted to a limited set of characters (a-z, A-Z, 0-9, -, \_ ) and no whitespace.

### Macrons

When a name contains macrons "Ōtorohanga" the macron is removed from the path but retained in the metadata's Title / Description.

### Apostrophes

Where a name contains an apostrophe "Hawke's Bay" the apostrophe is removed from the path but retained in the metadata's Title / Description.

### Path components

#### `region`

Is taken from a list of regions

- New Zealand `new-zealand`
- Northland `northland`
- Auckland `auckland`
- Waikato `waikato`
- Bay of Plenty `bay-of-plenty`
- Gisborne `gisborne`
- Taranaki `taranaki`
- Manawatu-Whanganui `manawatu-whanganui`
- Wellington `wellington`
- Nelson `nelson`
- Tasman `tasman`
- Marlborough `marlborough`
- Canterbury `canterbury`
- West Coast `west-coast`
- Otago `otago`
- Southland `southland`
- Offshore Islands `offshore-islands`
- Pacific Islands `pacific-islands`
- Antarctica `antarctica`

#### `city-or-sub-region`

This is free text and at the Imagery maintainers discretion. Unless the region has full coverage, a specific sub-region is used to help describe the dataset. The [Gazetteer](https://gazetteer.linz.govt.nz/) is referenced to ensure official names with correct spelling are used. If the region has full coverage, then the region name should be repeated in place of the city or sub-region in order to keep naming consistent.

#### `years`

If the "year" is part of the imagery path, it is the full four digits should be used even when a range is provided, and in the majority of cases it should be year(s) of capture.

As imagery can be updated after it is "named" the years may be incorrect it is best to use is as a rough guideline and then use the STAC collection.json for more precise timing.

### `resolution`

The resolution of the imagery in meters with no trailing zeros after the decimal point.

### `product`

Imagery product type, Generally this is `rgb` as is the primary imagery type for LINZ

### `crs`

EPSG Code for the coordinate reference system of the imagery, Generally this is [`2193`](https://epsg.io/2193) as it is the primary projection for most of LINZ's imagery.
