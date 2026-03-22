# Verify that the conda R installation is isolated from user libraries.
# .libPaths() should contain exactly one entry: the conda environment library.
stopifnot(length(.libPaths()) == 1)
