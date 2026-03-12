project "ImGui"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"
    staticruntime "off"

    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "imconfig.h",
        "imgui.h",
        "imgui.cpp",
        "imgui_draw.cpp",
        "imgui_internal.h",
		"imgui_tables.cpp",
        "imgui_widgets.cpp",
        "imstb_rectpack.h",
        "imstb_textedit.h",
        "imstb_truetype.h",
        "imgui_demo.cpp",
        "misc/cpp/imgui_stdlib.h",
        "misc/cpp/imgui_stdlib.cpp",

        -- Renderer backend (shared between GLFW and SDL3 paths)
        "backends/imgui_impl_opengl3.h",
        "backends/imgui_impl_opengl3.cpp",
    }

    -- Only enable test engine hooks when ImGui Test Engine is used (set in Dependencies.lua)
    if enable_imgui_test_engine then
        defines { "IMGUI_ENABLE_TEST_ENGINE" }
    end

    includedirs
    {
        ".",
        "%{IncludeDir.Glad}",
    }

    -- Platform backend is selected based on window backend
    if window_backend == "GLFW" then
        files
        {
            "backends/imgui_impl_glfw.h",
            "backends/imgui_impl_glfw.cpp",
        }
        includedirs
        {
            "%{IncludeDir.GLFW}",
        }
    elseif window_backend == "SDL3" then
        files
        {
            "backends/imgui_impl_sdl3.h",
            "backends/imgui_impl_sdl3.cpp",
        }
        includedirs
        {
            "%{IncludeDir.SDL3}",
        }
    end
    
    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"