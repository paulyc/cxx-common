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

set(LIBRARY_ROOT "${LIBRARY_REPOSITORY_ROOT}/googletest")

set(GMock_FOUND TRUE)
set(GTEST_FOUND TRUE)
set(GMOCK_LIBRARY ${LIBRARY_ROOT}/lib/libgmock.a)
set(GMOCK_MAIN_LIBRARY ${LIBRARY_ROOT}/lib/libgmock_main.a)
set(GMOCK_INCLUDE_DIR "${LIBRARY_ROOT}/include")

mark_as_advanced(FORCE GMock_FOUND)
mark_as_advanced(FORCE GTEST_FOUND)
mark_as_advanced(FORCE GMOCK_LIBRARY)
mark_as_advanced(FORCE GMOCK_MAIN_LIBRARY)
mark_as_advanced(FORCE GMOCK_INCLUDE_DIR)

