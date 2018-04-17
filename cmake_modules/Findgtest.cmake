set(LIBRARY_ROOT "${LIBRARY_REPOSITORY_ROOT}/googletest")

set(GTest_FOUND TRUE)
set(GTest_INCLUDE_DIRS "${LIBRARY_ROOT}/include")

set(GTest_LIBRARIES
    ${LIBRARY_ROOT}/lib/libGTest.a
)

mark_as_advanced(FORCE GTest_FOUND)
mark_as_advanced(FORCE GTest_INCLUDE_DIRS)
mark_as_advanced(FORCE GTest_LIBRARIES)

