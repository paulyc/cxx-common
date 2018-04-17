set(LIBRARY_ROOT "${LIBRARY_REPOSITORY_ROOT}/cctz")

set(cctz_FOUND TRUE)
set(cctz_INCLUDE_DIRS "${LIBRARY_ROOT}/include")

set(cctz_LIBRARIES
    ${LIBRARY_ROOT}/lib/libcctz.a
)

mark_as_advanced(FORCE cctz_FOUND)
mark_as_advanced(FORCE cctz_INCLUDE_DIRS)
mark_as_advanced(FORCE cctz_LIBRARIES)

