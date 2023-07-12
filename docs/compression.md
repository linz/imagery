# Imagery Compression


## Background

Toitū Te Whenua (LINZ) holds multiple imagery types data for [most of New Zealand](https://www.linz.govt.nz/products-services/data/types-linz-data/aerial-imagery).

This data is delivered to LINZ as GeoTiffs, LINZ is required to store the imagery data in a safe and secure manner while also providing access to the data.

To enable ease of access Imagery is [standardized](https://github.com/linz/topo-imagery) into [Cloud Optimised GeoTiff](https://www.cogeo.org/) using [GDAL](https://github.com/osgeo/gdal/)

### Imagery types

LINZ's imagery archive consists of

- 1 band 8bit grayscale [scanned historical imagery](https://www.linz.govt.nz/our-work/projects/crown-aerial-film-archive-historical-imagery-scanning-project)
- 3 band 8bit RGB [aerial imagery](https://data.linz.govt.nz/data/category/aerial-photos/) (Sometimes with NO_DATA) 
- 4 band 8bit RGB-NiR aerial imagery (Sometimes with NO_DATA) - Not currently published

Other types
- 16bit 4band+ RGB+ satellite imagery - Not currently published


### Goals

As most of the imagery we are working on right now is RGB, the following document is mostly related to 8bit RGB imagery.

LINZ uses GDAL for processing [COGs](https://gdal.org/drivers/raster/cog.html) which limits the compression types to LZW, DEFLATE, LERC, ZSTD and JpegXL

At the time of testing JpegXL is not supported by most of the tools LINZ uses and until the support improves it cannot be recommended as our archive compression format.

## Testing

The imagery compression needs to be lossless, converting to the format and back should create the exact same tiff.

### Process

```bash
docker run \
    -v tiffs-path:/input \
    ghcr.io/osgeo/gdal:ubuntu-full-3.7.0 \
    gdal_translate \
        -of COG \
        -co num_threads=all_cpus \
        -co sparse_ok=true \
        -co compression=${compression} \
        # options set per compression type
        -co level=${level} \  # (zstd,deflate,webp) if level was set
        -co predictor=${predictor} \  # (zstd,deflate,lzw)
        -co max_z_error=${max_z_error} \  # (lerc)
    /input/input.tiff
    /output/${compression}_predictor-${precdictor}_level-${level}_error-${error}.tiff
```

To ensure the imagery is lossless the imagery was converted back to a raw uncompressed imagery and then hashed

```bash
docker run \
    -v tiffs-path:/input \
    ghcr.io/osgeo/gdal:ubuntu-full-3.7.0 \
    gdal_translate \
        -of COG \
        -co num_threads=all_cpus \
        -co sparse_ok=true \
    /output/${compression}_predictor-${precdictor}_level-${level}_error-${error}.tiff
    /output/${compression}_predictor-${precdictor}_level-${level}_error-${error}-raw.tiff

sha256sum /output/${compression}_predictor-${precdictor}_level-${level}_error-${error}-raw.tiff
```


## Results

Key results

# TODO fill in table

WebP is by far the best compression, it does take significantly longer to compress, Most of the cost with imagery is storage and egress, so taking longer to compress is not a big issue.

## Recommendation



