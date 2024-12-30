# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.7.5@sha256:d1b3d067b912ea4cbf697750cee80f59114414365b916167b4c7b4cf9504ca9a
