# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.7.12@sha256:b1934ee5f1c509618f2508e6eb47ee0d3520686341fec936f3b79331f9315667
