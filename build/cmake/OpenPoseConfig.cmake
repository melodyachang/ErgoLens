# Compute and install package configuration and version files
get_filename_component(_dir "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_prefix "${_dir}/../.." ABSOLUTE)

# Import the targets
include("${_prefix}/lib/OpenPose/OpenPose.cmake")
if (ON)
  set(Caffe_INCLUDE_DIRS "${_prefix}/include/")
  # set(Caffe_LIBS "${_prefix}/lib/libcaffe.so")
endif (ON)

# Report other information
set(OpenPose_INCLUDE_DIRS "${_prefix}/include/")
set(OpenPose_VERSION_MAJOR 1)
set(OpenPose_VERSION_MINOR 5)
set(OpenPose_VERSION_PATCH 0)
set(OpenPose_VERSION 1.5.0)

# Check that the user requested components 
# are actually targets that are part of this build
if (OpenPose_FIND_COMPONENTS)
  foreach (comp ${OpenPose_FIND_COMPONENTS})
    if (NOT TARGET ${comp})
      set (OpenPose_${comp}_FOUND 0)
      if (OpenPose_FIND_REQUIRED_${comp})
        message(FATAL_ERROR "OpenPose ${comp} not available.")
      endif (OpenPose_FIND_REQUIRED_${comp})
    else (NOT TARGET ${comp})
      set(OpenPose_${comp}_FOUND 1)
      set(OpenPose_LIBS "${comp};${OpenPose_LIBS}")
    endif (NOT TARGET ${comp})
  endforeach ()
else (OpenPose_FIND_COMPONENTS)
  set(OpenPose_LIBS "openpose")
endif (OpenPose_FIND_COMPONENTS)

if (OpenPose_INCLUDE_DIRS AND OpenPose_LIBS)
  set(OpenPose_FOUND 1)
endif (OpenPose_INCLUDE_DIRS AND OpenPose_LIBS)
