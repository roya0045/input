# GPLv2 Licence

# not in linux input-SDK

if (LNX)
  find_path(Pq_INCLUDE_DIR postgres_ext.h /usr/include/postgresql)
  find_library(Pq_LIBRARY NAMES pq)
elseif (WIN)
  find_path(
    Pq_INCLUDE_DIR
    postgres_ext.h
    "${INPUT_SDK_PATH_MULTI}/include"
    NO_DEFAULT_PATH
  )

  find_library(
    Pq_LIBRARY
    NAMES libpq
    PATHS "${INPUT_SDK_PATH_MULTI}/lib"
    NO_DEFAULT_PATH
  )

else ()
  find_path(
    Pq_INCLUDE_DIR
    postgres_ext.h
    "${INPUT_SDK_PATH_MULTI}/include"
    NO_DEFAULT_PATH
  )

  find_library(
    Pq_LIBRARY
    NAMES pq
    PATHS "${INPUT_SDK_PATH_MULTI}/lib"
    NO_DEFAULT_PATH
  )
endif ()

find_package_handle_standard_args(Pq REQUIRED_VARS Pq_LIBRARY Pq_INCLUDE_DIR)

if (Pq_FOUND AND NOT TARGET Pq::Pq)
  add_library(Pq::Pq UNKNOWN IMPORTED)
  set_target_properties(
    Pq::Pq PROPERTIES IMPORTED_LOCATION "${Pq_LIBRARY}" INTERFACE_INCLUDE_DIRECTORIES
                                                        "${Pq_INCLUDE_DIR}"
  )
endif ()

mark_as_advanced(Pq_LIBRARY Pq_INCLUDE_DIR)