# New Zealand Imagery TIFF Specifications 

## National Imagery Base Specification

Toitū Te Whenua Land Information New Zealand publishes a [National Imagery Base Specification](https://www.linz.govt.nz/products-services/data/types-linz-data/aerial-imagery/national-imagery-base-specification) which defines data quality requirements and some TIFF specifications that are also covered by the following data storage specification.

These include:
-  GeoTIFFs with georeferencing information contained within each raster file. Our data processing workflows will also handle TFW World File sidecar file containing georeferencing information but this is not encouraged.
-  Data provided in the NZTM2000 coordinate system.
-  Void areas coded using "NODATA" value equal to 255 in each band, identified in the appropriate location within the raster file header.

Cloud-Optimised GeoTIFFs and the specific compressions used for storage are not part of the base specification, and are outputs of LINZ data processing workflows.

## Imagery Data Storage Specification

Applies to all Imagery published in s3://nz-elevation after being processed by Toitū Te Whenua Land Information New Zealand.

For data processing scripts, see [`linz/topo-imagery`](https://github.com/linz/topo-imagery).  
For workflow configuration, see [`linz/topo-workflows`](https://github.com/linz/topo-workflows). 

### File Format

| Property | Value |
|---|---|
| Container | GeoTIFF (`.tiff`) |
| Profile | Cloud-Optimised GeoTIFF (COG) |
| GDAL Driver | `COG` (`-of COG`) |

A summary of Cloud-Optimised GeoTIFF characteristics is provided [in the GDAL docs](https://gdal.org/en/stable/drivers/raster/cog.html#file-format-details).

### Coordinate Reference Systems

| Type | Name | EPSG Code |
|---|---|---|
| Mainland New Zealand Projection | New Zealand Transverse Mercator 2000 (NZTM2000) | 2193 |
| Chatham Islands Projection | Chatham Islands Tranverse Mercator 2000 (CITM2000) | 3793 |

Each TIFF contains the spatial reference information for the appropriate projection.

### Spatial Resolution

Ranges from 0.04m (4cm) for small urban areas to 10m for national satellite imagery mosaics.

### Band Configuration

| Data Type | Bands | Bit Depth | Colour Interpretation | Interleave |
|---|---|---|---|---|
| RGB | 4 (red, green, blue, alpha) | `uint8` | `Red, Green, Blue, Alpha` | `Pixel` |
| Near-Infared | 5 (red, green, blue, near-infrared, alpha) | `uint8` | `Red, Green, Blue, NIR, Alpha` | `Pixel` |

Nodata values are not used for stored standardised imagery as the alpha band is used to designate nodata areas instead.

### COG Driver Options

The following [GDAL COG driver creation options](https://gdal.org/en/stable/drivers/raster/cog.html#creation-options) are applied to all TIFFs:

| GDAL Creation Option | Value | Notes |
|---|---|---|
| `-co BLOCKSIZE` | `512` | 512×512 pixel tiles (default) |
| `-co NUM_THREADS` | `ALL_CPUS` | Use all available CPUs for compression, overview generation, etc |
| `-co SPARSE_OK` | `TRUE` | Omit empty tiles (null byte) rather than writing blank data |
| `-co BIGTIFF` | `NO` | Classic TIFF only (GDAL will raise an error if output exceeds 4 GB and we target approx 1 GB TIFF sizes via automated tiling) |
| `-co OVERVIEWS` | `IGNORE_EXISTING` | Always regenerate overviews (never build from pre-existing lossy overviews) |
| `-co STATISTICS` | `YES` | Compute and embed raster statistics (ensures that GIS software can immediately accurately display the data) |

### Compression

See [Compression](./docs/compression.md) for further background on compression choices.

#### RGB - `WEBP Lossless`

| GDAL Creation Option | Value | Notes |
|---|---|---|
| `-co COMPRESS` | `WEBP` | [WEBP compression](https://developers.google.com/speed/webp/docs/compression) was designed to optimise image size and speed for the web |
| `-co QUALITY` | `100` | Main image is lossless |
| `-co OVERVIEW_COMPRESS` | `WEBP` | WEBP for overviews as well |
| `-co OVERVIEW_QUALITY` | `90` | Overviews use WEBP in lossy mode, further reducing file size |
| `-co OVERVIEW_RESAMPLING` | `LANCZOS` | Lanczos resampling for overview generation, provides a clear, crisp output |

Black-and-white scanned historical aerial imagery still uses WEBP Lossless compression as it is more effective than single-band greyscale image compression from other compression methods.

#### Near-Infrared - `ZSTD`

| GDAL Creation Option | Value | Notes |
|---|---|---|
| `-co COMPRESS` | `ZSTD` | [ZSTD compression](https://github.com/facebook/zstd) is a high-performance, fast, lossless compression algorithm |
| `-co LEVEL` | `17` | Highest compression level that produces a significantly smaller file size (at the cost of slower compression, which is acceptable for our use-cases) |
| `-co PREDICTOR` | `2` | Horizontal differencing predictor |
| `-co OVERVIEW_COMPRESS` | `ZSTD` | ZSTD compression for overviews as well |
| `-co OVERVIEW_RESAMPLING` | `LANCZOS` | Lanczos resampling for overview generation, provides a clear, crisp output |

WEBP does not support 4-band imagery, so we use `ZSTD` instead.

### File Naming Convention

Output files are named using the LINZ tile index grid name, e.g. `BK27_10000_0101.tiff`.

Individual survey outputs are tiled to a variety of tile indexes derived from the [NZ 1:50k Tile Index](https://data.linz.govt.nz/layer/104687). These are:
- [NZ 1:500 Tile Index](https://data.linz.govt.nz/layer/106965-nz-1500-tile-index/)
- [NZ 1:1k Tile Index](https://data.linz.govt.nz/layer/104692-nz-11k-tile-index/)
- [NZ 1:2k Tile Index](https://data.linz.govt.nz/layer/106966-nz-12k-tile-index/)
- [NZ 1:5k Tile Index](https://data.linz.govt.nz/layer/104691-nz-15k-tile-index/)
- [NZ 1:10k Tile Index](https://data.linz.govt.nz/layer/104690-nz-110k-tile-index/)

## GDAL Contributions

Toitū Te Whenua Land Information New Zealand has paid for the following contribution to GDAL:
- [`-of COG` driver](https://github.com/OSGeo/gdal/pull/1621), now the de facto raster data file format for geospatial data in cloud storage

Along with [ongoing maintenance sponsorship](https://gdal.org/en/stable/sponsors/index.html).

If you benefit from any of these tools, please also consider sponsoring GDAL.
