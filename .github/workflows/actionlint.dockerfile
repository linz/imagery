# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.6.26@sha256:2362769b1d75056da70e7af1b12d9e52746f3a123b8f22a4322869e8f2cd45f2
