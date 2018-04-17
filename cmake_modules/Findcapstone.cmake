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

set(LIBRARY_ROOT "${LIBRARY_REPOSITORY_ROOT}/capstone")

set(CAPSTONE_FOUND TRUE)
set(CAPSTONE_INCLUDE_DIRS "${LIBRARY_ROOT}/include")

set(CAPSTONE_LIBRARIES
    ${LIBRARY_ROOT}/lib/libcapstone.a
)

mark_as_advanced(FORCE CAPSTONE_FOUND)
mark_as_advanced(FORCE CAPSTONE_INCLUDE_DIRS)
mark_as_advanced(FORCE CAPSTONE_LIBRARIES)

