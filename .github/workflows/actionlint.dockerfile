# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.7.3@sha256:7617f05bd698cd2f1c3aedc05bc733ccec92cca0738f3e8722c32c5b42c70ae6
