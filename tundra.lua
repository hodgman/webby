local CFiles = { ".c", ".h" }
Build {
	Configs = {
		Config {
			Name = "generic-gcc",
			DefaultOnHost = "linux",
			Tools = { "gcc" },
		},
		Config {
			Name = "macosx-gcc",
			DefaultOnHost = "macosx",
			Tools = { "gcc-osx" },
			Env = {
				CCOPTS = {
					{ '-Wall', '-Werror' },
					{ '-g'; Config = "*-*-debug" },
				},
			},
		},
		Config {
			Name = "win64-msvc",
			DefaultOnHost = "windows",
			Tools = { "msvc-winsdk"; TargetPlatform = "x64" },
			Env = {
				CPPDEFS = { "_CRT_SECURE_NO_WARNINGS" },
				CCOPTS = { '/W4', '/wd4127', '/wd4100' },
				{ GENERATE_PDB = 1; Config = "*-*-debug" },
			},
		},
	},
	Units = function()
		require "tundra.syntax.glob"
		Program {
			Name = "a.out",
			Sources = { Glob { Dir = ".", Extensions = CFiles } },
			Libs = { { "ws2_32.lib"; Config = "win64-msvc" } },
		}

		Default "a.out"
	end,
}
