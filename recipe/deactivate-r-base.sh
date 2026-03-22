# shellcheck shell=sh

# restore pre-existing RSTUDIO_WHICH_R
if [ -n "${RSTUDIO_WHICH_R_PREV+x}" ]; then
  export RSTUDIO_WHICH_R="${RSTUDIO_WHICH_R_PREV}"
  unset RSTUDIO_WHICH_R_PREV
else
  unset RSTUDIO_WHICH_R
fi

# Restore pre-existing R_LIBS_USER
if [ -n "${R_LIBS_USER_CONDA_PREV+x}" ]; then
  export R_LIBS_USER="${R_LIBS_USER_CONDA_PREV}"
  unset R_LIBS_USER_CONDA_PREV
else
  unset R_LIBS_USER
fi
