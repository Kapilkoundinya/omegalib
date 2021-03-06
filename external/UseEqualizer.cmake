# Equalizer support enabled: uncompress and prepare the external project.
if(APPLE)
    ExternalProject_Add(
		equalizer
		URL ${CMAKE_SOURCE_DIR}/external/equalizer.tar.gz
		#CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}
		CMAKE_ARGS 
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}
            -DCMAKE_OSX_SYSROOT:PATH=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${CURRENT_OSX_VERSION}.sdk
            -DCMAKE_OSX_DEPLOYMENT_TARGET:VAR=${CURRENT_OSX_VERSION}
			-DEQUALIZER_PREFER_AGL:BOOL=OFF
			-DEQUALIZER_USE_CUDA:BOOL=OFF
			-DEQUALIZER_USE_BOOST:BOOL=OFF
            -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
			INSTALL_COMMAND ""
            PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/external/equalizer.${CURRENT_OSX_VERSION}.patch
		)
else(APPLE)
	ExternalProject_Add(
		equalizer
		URL ${CMAKE_SOURCE_DIR}/external/equalizer.tar.gz
		#CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}
		CMAKE_ARGS 
			-DEQUALIZER_USE_CUDA:BOOL=OFF
			-DEQUALIZER_USE_BOOST:BOOL=OFF
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}
			-DCMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}
			-DCMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}
			-DCMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE:PATH=${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}
			INSTALL_COMMAND ""
			#PATCH_COMMAND patch < ${CMAKE_SOURCE_DIR}/external/equalizer.patch
		)
endif(APPLE)

set_target_properties(equalizer PROPERTIES FOLDER "3rdparty")
# define path to libraries built by the equalizer external project
set(EQUALIZER_BINARY_DIR ${CMAKE_BINARY_DIR}/src/omega/equalizer-prefix/src/equalizer-build)
# NEED SECTIONS DEPENDENT ON BUILD TOOL, NOT OS!
if(WIN32)
	set(EQUALIZER_EQ_LIB_DEBUG ${EQUALIZER_BINARY_DIR}/libs/client/Debug/Equalizer.lib)
	set(EQUALIZER_CO_LIB_DEBUG ${EQUALIZER_BINARY_DIR}/libs/collage/Debug/Collage.lib)
	set(EQUALIZER_LIBS_DEBUG debug ${EQUALIZER_EQ_LIB_DEBUG} debug ${EQUALIZER_CO_LIB_DEBUG})
	set(EQUALIZER_EQ_LIB_RELEASE ${EQUALIZER_BINARY_DIR}/libs/client/Release/Equalizer.lib)
	set(EQUALIZER_CO_LIB_RELEASE ${EQUALIZER_BINARY_DIR}/libs/collage/Release/Collage.lib)
	set(EQUALIZER_LIBS_RELEASE optimized ${EQUALIZER_EQ_LIB_RELEASE} optimized ${EQUALIZER_CO_LIB_RELEASE})
	# install(
		# FILES ${EQUALIZER_CLIENT_LIBS_DEBUG}
		# DESTINATION lib/Debug
		# COMPONENT omegalib
	# )
	# install(
		# FILES ${EQUALIZER_CLIENT_LIBS_RELEASE}
		# DESTINATION lib/Debug
		# COMPONENT omegalib
	# )
else(WIN32)
	if(APPLE)
		set(EQUALIZER_EQ_LIB_DEBUG ${EQUALIZER_BINARY_DIR}/libs/client/libEqualizer.dylib)
		set(EQUALIZER_CO_LIB_DEBUG ${EQUALIZER_BINARY_DIR}/libs/collage/libCollage.dylib)
		install(DIRECTORY ${EQUALIZER_BINARY_DIR}/libs/client/ DESTINATION omegalib/bin FILES_MATCHING PATTERN "*.dylib")
		install(DIRECTORY ${EQUALIZER_BINARY_DIR}/libs/server/ DESTINATION omegalib/bin FILES_MATCHING PATTERN "*.dylib")
		install(DIRECTORY ${EQUALIZER_BINARY_DIR}/libs/collage/ DESTINATION omegalib/bin FILES_MATCHING PATTERN "*.dylib")
	else(APPLE)
		set(EQUALIZER_EQ_LIB_DEBUG ${EQUALIZER_BINARY_DIR}/libs/client/libEqualizer.so)
		set(EQUALIZER_CO_LIB_DEBUG ${EQUALIZER_BINARY_DIR}/libs/collage/libCollage.so)
		install(DIRECTORY ${EQUALIZER_BINARY_DIR}/libs/client/ DESTINATION omegalib/bin FILES_MATCHING PATTERN "*.so*")
		install(DIRECTORY ${EQUALIZER_BINARY_DIR}/libs/server/ DESTINATION omegalib/bin FILES_MATCHING PATTERN "*.so*")
		install(DIRECTORY ${EQUALIZER_BINARY_DIR}/libs/collage/ DESTINATION omegalib/bin FILES_MATCHING PATTERN "*.so*")
	endif(APPLE)	
	set(EQUALIZER_LIBS_DEBUG ${EQUALIZER_EQ_LIB_DEBUG} ${EQUALIZER_CO_LIB_DEBUG})
	set(EQUALIZER_LIBS_RELEASE ${EQUALIZER_EQ_LIB_DEBUG} ${EQUALIZER_CO_LIB_DEBUG})
endif(WIN32)
set(EQUALIZER_LIBS ${EQUALIZER_LIBS_DEBUG} ${EQUALIZER_LIBS_RELEASE})
set(EQUALIZER_INCLUDES ${CMAKE_BINARY_DIR}/src/omega/equalizer-prefix/src/equalizer-build/include)
