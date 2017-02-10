#!/usr/bin/env bash
#!/bin/bash
# This script will build the project.

#set -ev
EXIT_STATUS=0

function strongEcho {
  echo ""
  echo "================ $1 ================="
}

if [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_SECURE_ENV_VARS" == "true" ]; then

	strongEcho 'Build Branch ['$TRAVIS_BRANCH']'

	./gradlew release \
	-Dorg.ajoberstar.grgit.auth.username=${GH_TOKEN} \
	-Dorg.ajoberstar.grgit.auth.password --info --stacktrace || EXIT_STATUS=$?

else

    strongEcho 'Build, no analysis => Branch ['$TRAVIS_BRANCH'] Pull Request ['$TRAVIS_PULL_REQUEST']'

    # Build branch, without any analysis
    ./gradlew build || EXIT_STATUS=$?
fi

exit $EXIT_STATUS

