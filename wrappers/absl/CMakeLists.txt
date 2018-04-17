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

option(BUILD_TOOLS "" OFF)
option(BUILD_EXAMPLES "" OFF)
option(BUILD_TESTING "" OFF)

add_subdirectory("${CCTZ_SOURCE_FOLDER}" cctz_bin)
add_subdirectory("${ABSL_SOURCE_FOLDER}" absl_bin)

set(TARGET_LIST cctz::cctz absl::base absl::algorithm absl::container absl::debugging absl::memory absl::meta absl::numeric absl::strings absl::synchronization absl::time absl::types absl::utility)

foreach(lib ${TARGET_LIST})
  install(${lib} EXPORT “Find${lib}“)
  install(
    TARGETS ${lib}
    EXPORT “Find${lib}” DESTINATION "${CXX_COMMON_CMAKE_MODULES_DIR}"
    INCLUDES DESTINATION include
    LIBRARY DESTINATION lib)
endforeach()

install(
  TARGETS  
  INCLUDES DESTINATION include
  )

