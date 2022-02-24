-- Include the premake5 CUDA module
require('premake5-cuda')


project "Example"

local ROOT = "../../"

kind "ConsoleApp"
    language "C++"
	defines {}
	flags { "MultiProcessorCompile", "NoMinimalRebuild" }
	
	if _ACTION == "vs2019" then
		cppdialect "C++17"
		location (ROOT .. "builds/VisualStudio2019/projects")
    end
	
	targetdir (ROOT .. "builds/bin/" .. outputdir .. "/%{prj.name}")
	objdir (ROOT .. "builds/bin-int/" .. outputdir .. "/%{prj.name}")

	local SOURCE_DIR = "source/"
	files
    { 
      SOURCE_DIR .. "**.h", 
      SOURCE_DIR .. "**.cpp",
    }
	includedirs
	{
		
	}

	buildcustomizations "BuildCustomizations/CUDA 11.6"

	cudaFiles {SOURCE_DIR .. "*.cu"} -- files NVCC compiles
	cudaMaxRegCount "32"

	cudaCompilerOptions {"-arch=sm_75", 
					     "-gencode=arch=compute_75,code=sm_75", 
					     "--extended-lambda",
                         "-t0"}                      

filter "configurations:release"
cudaFastMath "On"
filter ""
