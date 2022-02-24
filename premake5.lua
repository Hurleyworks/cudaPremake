-- Example configuration file for Premake5 using the CUDA module
-- To build this sample, run '.\premake5.exe vs2019' from the root of this project.

-- Include the premake5 CUDA module
require('premake5-cuda')

-- https://github.com/JohannesMP/Premake-for-Beginners

workspace "NVIDA"
	architecture "x64"
	location ("builds")
	
if _ACTION == "vs2019" then
   location ("builds/VisualStudio2019")
end

	

-- Premake5 writes these standard options for the host compiler. 
-- By default, optimization and debug settings are inherited by NVCC.
configurations 
	{ 
		"Debug", 
        "Release",
    }
	vectorextensions "AVX2"
	filter "configurations:Debug"    defines { "DEBUG" }  symbols  "On"
    filter "configurations:Release"  defines { "NDEBUG" } optimize "On"
    
	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


include "sandbox/example"