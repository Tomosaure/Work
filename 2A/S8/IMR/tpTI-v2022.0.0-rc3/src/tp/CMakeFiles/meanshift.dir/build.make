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
include src/tp/CMakeFiles/meanshift.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/tp/CMakeFiles/meanshift.dir/compiler_depend.make

# Include the progress variables for this target.
include src/tp/CMakeFiles/meanshift.dir/progress.make

# Include the compile flags for this target's objects.
include src/tp/CMakeFiles/meanshift.dir/flags.make

src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.o: src/tp/CMakeFiles/meanshift.dir/flags.make
src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.o: src/tp/meanshift.cpp
src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.o: src/tp/CMakeFiles/meanshift.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.o"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.o -MF CMakeFiles/meanshift.dir/meanshift.cpp.o.d -o CMakeFiles/meanshift.dir/meanshift.cpp.o -c /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp/meanshift.cpp

src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/meanshift.dir/meanshift.cpp.i"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp/meanshift.cpp > CMakeFiles/meanshift.dir/meanshift.cpp.i

src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/meanshift.dir/meanshift.cpp.s"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp/meanshift.cpp -o CMakeFiles/meanshift.dir/meanshift.cpp.s

src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.o: src/tp/CMakeFiles/meanshift.dir/flags.make
src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.o: src/tp/ocv_utils.cpp
src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.o: src/tp/CMakeFiles/meanshift.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.o"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.o -MF CMakeFiles/meanshift.dir/ocv_utils.cpp.o.d -o CMakeFiles/meanshift.dir/ocv_utils.cpp.o -c /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp/ocv_utils.cpp

src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/meanshift.dir/ocv_utils.cpp.i"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp/ocv_utils.cpp > CMakeFiles/meanshift.dir/ocv_utils.cpp.i

src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/meanshift.dir/ocv_utils.cpp.s"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp/ocv_utils.cpp -o CMakeFiles/meanshift.dir/ocv_utils.cpp.s

# Object files for target meanshift
meanshift_OBJECTS = \
"CMakeFiles/meanshift.dir/meanshift.cpp.o" \
"CMakeFiles/meanshift.dir/ocv_utils.cpp.o"

# External object files for target meanshift
meanshift_EXTERNAL_OBJECTS =

bin/meanshift: src/tp/CMakeFiles/meanshift.dir/meanshift.cpp.o
bin/meanshift: src/tp/CMakeFiles/meanshift.dir/ocv_utils.cpp.o
bin/meanshift: src/tp/CMakeFiles/meanshift.dir/build.make
bin/meanshift: /usr/local/lib/libopencv_gapi.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_highgui.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_ml.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_objdetect.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_photo.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_stitching.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_video.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_videoio.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_imgcodecs.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_dnn.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_calib3d.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_features2d.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_flann.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_imgproc.so.4.7.0
bin/meanshift: /usr/local/lib/libopencv_core.so.4.7.0
bin/meanshift: src/tp/CMakeFiles/meanshift.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable ../../bin/meanshift"
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/meanshift.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/tp/CMakeFiles/meanshift.dir/build: bin/meanshift
.PHONY : src/tp/CMakeFiles/meanshift.dir/build

src/tp/CMakeFiles/meanshift.dir/clean:
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp && $(CMAKE_COMMAND) -P CMakeFiles/meanshift.dir/cmake_clean.cmake
.PHONY : src/tp/CMakeFiles/meanshift.dir/clean

src/tp/CMakeFiles/meanshift.dir/depend:
	cd /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3 /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3 /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp /mnt/c/Users/bonet/Documents/Work/2A/S8/IMR/tpTI-v2022.0.0-rc3/src/tp/CMakeFiles/meanshift.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/tp/CMakeFiles/meanshift.dir/depend

