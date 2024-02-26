# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.6.27@sha256:d84eca815fc24f72546ec1f2f416d9500ad3349ce7db098cf7a52256f5fd4384
