# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.7.6@sha256:e3856d413f923accc4120884ff79f6bdba3dd53fd42884d325f21af61cc15ce0
