# Imagery Compression


## Background

Toitū Te Whenua (LINZ) holds multiple imagery types data for [most of New Zealand](https://www.linz.govt.nz/products-services/data/types-linz-data/aerial-imagery).

This data is delivered to LINZ as GeoTiffs, LINZ is required to store the imagery data in a safe and secure manner while also providing access to the data.

To enable ease of access Imagery is [standardized](https://github.com/linz/topo-imagery) into [Cloud Optimised GeoTiff](https://www.cogeo.org/) using [GDAL](https://github.com/osgeo/gdal/)

### Imagery types

LINZ's imagery archive consists of

- 1-band 8-bit grayscale [scanned historical imagery](https://www.linz.govt.nz/our-work/projects/crown-aerial-film-archive-historical-imagery-scanning-project)
- 3-band 8-bit RGB [aerial imagery](https://data.linz.govt.nz/data/category/aerial-photos/) (Sometimes with `NO_DATA`) 
- 4-band 8-bit RGB-NiR aerial imagery (Sometimes with `NO_DATA`) - Not currently published

Other types
- 4-band+ 16-bit  RGB+ satellite imagery - Not currently published


### Goals

As most of the imagery we are working on right now is RGB, the following document is mostly related to 8bit RGB imagery.

LINZ uses GDAL for processing [COGs](https://gdal.org/drivers/raster/cog.html) which limits the compression types to LZW, DEFLATE, LERC, ZSTD and JPEG-XL

At the time of testing JPEG XL is not supported by most of the tools LINZ uses and until the support improves it cannot be recommended as our archive compression format.

## Testing

The imagery compression needs to be lossless, converting to the format and back should create the exact same tiff.

### Process

```bash
docker run \
    -v tiffs-path:/input \
    ghcr.io/osgeo/gdal:ubuntu-full-3.7.0 \
    gdal_translate \
        -of GTIFF \
        -co num_threads=all_cpus \
        -co sparse_ok=true \
        -co compression=${compression} \
        # options set per compression type
        -co level=${level} \  # (zstd,deflate,webp) if level was set
        -co predictor=${predictor} \  # (zstd,deflate,lzw)
        -co max_z_error=${max_z_error} \  # (lerc)
    /input/input.tiff
    /output/${compression}_predictor-${predictor}_level-${level}_error-${error}.tiff
```

To ensure the imagery is lossless the imagery was converted back to a lzw image and then hashed

```bash
docker run \
    -v tiffs-path:/input \
    ghcr.io/osgeo/gdal:ubuntu-full-3.7.0 \
    gdal_translate \
        -of GTIFF \
        -co num_threads=all_cpus \
        -co sparse_ok=true \
        -co compress=lzw \
    /output/${compression}_predictor-${predictor}_level-${level}_error-${error}.tiff
    /output/${compression}_predictor-${predictor}_level-${level}_error-${error}-lzw.tiff

sha256sum /output/${compression}_predictor-${predictor}_level-${level}_error-${error}-lzw.tiff
```

## Results

To start all tiffs were compressed as LZW to create a baseline

The output data can be found in [compression-output.tsv](./data/compression-output.tsv)

Below is a table showing the relative file sizes, 63% means the file is 63% of the size of the LZW source image.

| Imagery Type | LZW  | Zstd | WebP | Lerc |
|--------------|------|------|------|------|
| Grayscale    | 100% | 87%  | 63%  | 79%  |
| RGB (8bit)   | 100% | 66%  | 34%  | 57%  |
| RGBi (8bit)  | 100% | 79%  | NA   | 63%  |

Some key results:

RGB - WebP lossless is significantly better than all other types
Grayscale - WebP lossless beats all other compressions tested
RGBI - JPEG XL creates almost 50% smaller files than other compression types

## Recommendation

With RGB and Grayscale imagery: WebP lossless is by far the best compression to use.

WebP does not support 4 band imagery so cannot be used on RGBi, More investigation needs to be done on RGBi and high bit count imagery, JPEG XL could be very good for these use cases.


