import os
import multiprocessing
from utils import *

def unix_installer_cmake(properties):
  repository_path = properties["repository_path"]
  verbose_output = properties["verbose"]
  debug = properties["debug"]

  if debug:
    print(" ! Debug mode is not supported")

  version = "3.9.3"
  url = "https://github.com/Kitware/CMake/archive/v" + version + ".tar.gz"

  source_tarball_path = download_file(url, "sources")
  if source_tarball_path is None:
    return False

  if not extract_archive(source_tarball_path, "build"):
    return False

  source_folder = os.path.join("build", "CMake-" + version)
  destination_path = os.path.join(repository_path, "cmake")

  if os.environ.get("CMAKE_C_COMPILER") is not None:
    os.environ["CC"] = os.environ["CMAKE_C_COMPILER"]

  if os.environ.get("CMAKE_CXX_COMPILER") is not None:
    os.environ["CXX"] = os.environ["CMAKE_CXX_COMPILER"]

  if not run_program("Running the bootstrap script...", ["./bootstrap", "--prefix=" + destination_path], source_folder, verbose=verbose_output):
    return False

  if not run_program("Building the source code...", ["make", "-j" + str(multiprocessing.cpu_count())], source_folder, verbose=verbose_output):
    return False

  if not run_program("Installing...", ["make", "install"], source_folder, verbose=verbose_output):
    return False

  return True

def unix_installer_llvm(properties):
  repository_path = properties["repository_path"]
  llvm_version = properties["llvm_version"]
  verbose_output = properties["verbose"]
  debug = properties["debug"]

  # download all source tarballs
  llvm_tarball_path = download_file("https://codeload.github.com/llvm-mirror/llvm/tar.gz/release_" + llvm_version, "sources", "llvm.tar.gz")
  if llvm_tarball_path is None:
    return False

  clang_tarball_path = download_file("https://codeload.github.com/llvm-mirror/clang/tar.gz/release_" + llvm_version, "sources", "clang.tar.gz")
  if clang_tarball_path is None:
    return False

  libcxx_tarball_path = download_file("https://codeload.github.com/llvm-mirror/libcxx/tar.gz/release_" + llvm_version, "sources", "libcxx.tar.gz")
  if libcxx_tarball_path is None:
    return False

  libcxxabi_tarball_path = download_file("https://codeload.github.com/llvm-mirror/libcxxabi/tar.gz/release_" + llvm_version, "sources", "libcxxabi.tar.gz")
  if libcxxabi_tarball_path is None:
    return False

  # extract the root llvm source folder
  if not os.path.isdir(os.path.join("sources", "llvm")):
    if not extract_archive(llvm_tarball_path, "sources"):
      return False

    try:
      shutil.move(os.path.join("sources", "llvm-release_40"), os.path.join("sources", "llvm"))
    except:
      print(" x Failed to rename the llvm source folder")
      return False

  else:
    print(" > llvm source folder already exists")

  # create the necessary subdirectories
  llvm_tools_folder = os.path.join("sources", "llvm", "tools")
  llvm_projects_folder = os.path.join("sources", "llvm", "projects")

  try:
    if not os.path.isdir(llvm_tools_folder):
      os.makedirs(llvm_tools_folder)
    
    if not os.path.isdir(llvm_projects_folder):
      os.makedirs(llvm_projects_folder)

  except:
    print(" x Failed to create the required folders")
    return False

  # extract and rename clang
  if not os.path.isdir(os.path.join(llvm_tools_folder, "clang")):
    if not extract_archive(clang_tarball_path, llvm_tools_folder):
      return False

    try:
      shutil.move(os.path.join(llvm_tools_folder, "clang-release_40"), os.path.join(llvm_tools_folder, "clang"))
    except:
      print(" x Failed to rename the clang source folder")
      return False

  else:
    print(" > clang source folder already exists")

  # extract and rename libcxx
  if not os.path.isdir(os.path.join(llvm_projects_folder, "libcxx")):
    if not extract_archive(libcxx_tarball_path, llvm_projects_folder):
      return False

    try:
      shutil.move(os.path.join(llvm_projects_folder, "libcxx-release_40"), os.path.join(llvm_projects_folder, "libcxx"))
    except:
      print(" x Failed to rename the libcxx source folder")
      return False

  else:
    print(" > libcxx source folder already exists")

  # extract and rename libcxxabi
  if not os.path.isdir(os.path.join(llvm_projects_folder, "libcxxabi")):
    if not extract_archive(libcxxabi_tarball_path, llvm_projects_folder):
      return False

    try:
      shutil.move(os.path.join(llvm_projects_folder, "libcxxabi-release_40"), os.path.join(llvm_projects_folder, "libcxxabi"))
    except:
      print(" x Failed to rename the libcxxabi source folder")
      return False

  else:
    print(" > libcxxabi source folder already exists")

  # create the build directory and compile the package
  llvm_build_path = os.path.join("build", "llvm")
  if not os.path.isdir(llvm_build_path):
    try:
      os.makedirs(llvm_build_path)
    except:
      print(" x Failed to create the build folder")
      return False

  source_path = os.path.realpath(os.path.join("sources", "llvm"))
  destination_path = os.path.join(repository_path, "llvm")

  cmake_command = ["cmake"] + get_env_compiler_settings() + get_cmake_build_type(debug)
  cmake_command += ["-DCMAKE_INSTALL_PREFIX=" + os.path.join(repository_path, "llvm"),
                    "-DCMAKE_CXX_STANDARD=11",
                    "-DLLVM_TARGETS_TO_BUILD='X86;AArch64'",
                    "-DLLVM_INCLUDE_EXAMPLES=OFF",
                    "-DLLVM_INCLUDE_TESTS=OFF", "-DLIBCXX_ENABLE_STATIC=YES",
                    "-DLIBCXX_ENABLE_SHARED=YES",
                    "-DLIBCXX_ENABLE_EXPERIMENTAL_LIBRARY=NO",
                    "-LIBCXX_INCLUDE_BENCHMARKS=NO", source_path]

  if not run_program("Configuring...", cmake_command, llvm_build_path, verbose=verbose_output):
    return False

  cmake_command = ["cmake", "--build", "."] + get_cmake_build_configuration(debug) + [ "--", get_parallel_build_options()]
  if not run_program("Building...", cmake_command, llvm_build_path, verbose=verbose_output):
    return False

  cmake_command = ["cmake", "--build", ".", "--target", "install"]
  if not run_program("Installing...", cmake_command, llvm_build_path, verbose=verbose_output):
    return False

  return True

def macos_installer_cmake(properties):
  return unix_installer_cmake(properties)

def linux_installer_cmake(properties):
  return unix_installer_cmake(properties)

def macos_installer_llvm(properties):
  return unix_installer_llvm(properties)

def linux_installer_llvm(properties):
  return unix_installer_llvm(properties)