# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.7.0@sha256:5acca218639222e4afbc82fc6e9ef56cbe646ade3b07f3f5ec364b638258a244
