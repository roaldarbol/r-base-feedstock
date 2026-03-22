# shellcheck shell=sh

# BUILD_PREFIX is set by both conda-build and rattler-build during build/test.
# Outside of a build context this script is a no-op.
if [ -z "${CONDA_BUILD:+x}" ] && [ -z "${BUILD_PREFIX:+x}" ]; then
  return 0 2>/dev/null || exit 0
fi

# shellcheck disable=SC2154  # assume variables are set at this point
if [ "${CONDA_BUILD_STATE-}" != "TEST" ] && [ "${build_platform}" != "${target_platform}" ]; then
  export R="${BUILD_PREFIX}/bin/R"
  export R_ARGS="--library=${PREFIX}/lib/R/library --no-test-load"
  # Keep these around if we want to build a native version
  cp "${BUILD_PREFIX}/lib/R/etc/Makeconf" "${BUILD_PREFIX}/lib/R/etc/Makeconf.${build_platform}"
  echo "R_HOME=${PREFIX}/lib/R"       > "${BUILD_PREFIX}/lib/R/etc/Makeconf"
  cat "${PREFIX}/lib/R/etc/Makeconf" >> "${BUILD_PREFIX}/lib/R/etc/Makeconf"
  cp "${BUILD_PREFIX}/lib/R/etc/Makeconf" "${BUILD_PREFIX}/lib/R/etc/Makeconf.${target_platform}"
  if [ -d "${BUILD_PREFIX}/lib/R/library" ]; then
    rsync -a -I "${BUILD_PREFIX}/lib/R/library/" "${PREFIX}/lib/R/library/"
  fi
fi
