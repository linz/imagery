# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.7.2@sha256:89d3f90f82781dee3c8724651129634b08cf2241bbd67fcd02a1c5198119fc5e
