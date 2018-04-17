# Copyright (c) 2017 Trail of Bits, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if(NOT Abseil_FOUND)
  option(BUILD_TOOLS "" OFF)
  option(BUILD_EXAMPLES "" OFF)
  option(BUILD_TESTING "" OFF)

  add_subdirectory("${LIBRARY_REPOSITORY_ROOT}/benchmark" benchmark_bin)
  add_subdirectory("${LIBRARY_REPOSITORY_ROOT}/cctz" cctz_bin)
  add_subdirectory("${LIBRARY_REPOSITORY_ROOT}/absl" absl_bin)
endif()

set(Abseil_FOUND TRUE)
set(Abseil_INCLUDE_DIRS "${LIBRARY_REPOSITORY_ROOT}/cctz/include" "${LIBRARY_REPOSITORY_ROOT}/benchmark/include" "${LIBRARY_REPOSITORY_ROOT}/absl")

mark_as_advanced(FORCE Abseil_FOUND)
mark_as_advanced(FORCE Abseil_INCLUDE_DIRS)
mark_as_advanced(FORCE Abseil_LIBRARIES)

