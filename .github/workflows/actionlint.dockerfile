# Workaround for https://github.com/dependabot/dependabot-core/issues/8362.
# Once that is fixed, remove this file and replace the Docker build and run
# lines in `.github/workflows/*.yml` with a `uses: docker://rhysd/…` line.
FROM rhysd/actionlint:1.7.4@sha256:82244e1db1c60d82c7792180a48dd0bcb838370bb589d53ff132503fc9485868
