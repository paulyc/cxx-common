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

set(LIBRARY_REPOSITORY_ROOT $ENV{TRAILOFBITS_LIBRARIES})

if ("${LIBRARY_REPOSITORY_ROOT}" STREQUAL "")
    message(ERROR "The TRAILOFBITS_LIBRARIES environment variable is not defined!")
endif ()

list(APPEND CMAKE_MODULE_PATH "${LIBRARY_REPOSITORY_ROOT}/cmake_modules")

list(APPEND CMAKE_PREFIX_PATH "${LIBRARY_REPOSITORY_ROOT}/gflags")
list(APPEND CMAKE_PREFIX_PATH "${LIBRARY_REPOSITORY_ROOT}/llvm")
list(APPEND CMAKE_PREFIX_PATH "${LIBRARY_REPOSITORY_ROOT}/glog")
list(APPEND CMAKE_PREFIX_PATH "${LIBRARY_REPOSITORY_ROOT}/protobuf/lib/cmake/protobuf")
list(APPEND CMAKE_PREFIX_PATH "${LIBRARY_REPOSITORY_ROOT}/capnproto/lib/cmake/CapnProto")
set(BOOST_ROOT "${LIBRARY_REPOSITORY_ROOT}/boost")

list(APPEND CMAKE_PREFIX_PATH "${LIBRARY_REPOSITORY_ROOT}/cctz")
list(APPEND CMAKE_PREFIX_PATH "${LIBRARY_REPOSITORY_ROOT}/absl")
