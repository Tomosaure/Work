# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3

# Include any dependencies generated for this target.
include src/tutorials/CMakeFiles/load_modify_image.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/tutorials/CMakeFiles/load_modify_image.dir/compiler_depend.make

# Include the progress variables for this target.
include src/tutorials/CMakeFiles/load_modify_image.dir/progress.make

# Include the compile flags for this target's objects.
include src/tutorials/CMakeFiles/load_modify_image.dir/flags.make

src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o: src/tutorials/CMakeFiles/load_modify_image.dir/flags.make
src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o: src/tutorials/load_modify_image.cpp
src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o: src/tutorials/CMakeFiles/load_modify_image.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o -MF CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o.d -o CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o -c /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials/load_modify_image.cpp

src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/load_modify_image.dir/load_modify_image.cpp.i"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials/load_modify_image.cpp > CMakeFiles/load_modify_image.dir/load_modify_image.cpp.i

src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/load_modify_image.dir/load_modify_image.cpp.s"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials/load_modify_image.cpp -o CMakeFiles/load_modify_image.dir/load_modify_image.cpp.s

# Object files for target load_modify_image
load_modify_image_OBJECTS = \
"CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o"

# External object files for target load_modify_image
load_modify_image_EXTERNAL_OBJECTS =

bin/load_modify_image: src/tutorials/CMakeFiles/load_modify_image.dir/load_modify_image.cpp.o
bin/load_modify_image: src/tutorials/CMakeFiles/load_modify_image.dir/build.make
bin/load_modify_image: /usr/local/lib/libopencv_gapi.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_highgui.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_ml.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_objdetect.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_photo.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_stitching.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_video.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_videoio.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_imgcodecs.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_dnn.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_calib3d.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_features2d.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_flann.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_imgproc.so.4.7.0
bin/load_modify_image: /usr/local/lib/libopencv_core.so.4.7.0
bin/load_modify_image: src/tutorials/CMakeFiles/load_modify_image.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/load_modify_image"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/load_modify_image.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/tutorials/CMakeFiles/load_modify_image.dir/build: bin/load_modify_image
.PHONY : src/tutorials/CMakeFiles/load_modify_image.dir/build

src/tutorials/CMakeFiles/load_modify_image.dir/clean:
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials && $(CMAKE_COMMAND) -P CMakeFiles/load_modify_image.dir/cmake_clean.cmake
.PHONY : src/tutorials/CMakeFiles/load_modify_image.dir/clean

src/tutorials/CMakeFiles/load_modify_image.dir/depend:
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3 /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3 /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tutorials/CMakeFiles/load_modify_image.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/tutorials/CMakeFiles/load_modify_image.dir/depend
