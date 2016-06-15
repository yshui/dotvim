import std.path, std.file;
import std.json, std.algorithm, std.string;
import std.process, std.stdio;

alias CXCompilationDatabase = void*;
alias CXCompileCommands = void*;
alias CXCompileCommand = void*;
struct CXString {
	const void *data;
	uint private_flags;
}
enum  CXCompilationDatabase_Error {
  CXCompilationDatabase_NoError = 0,
  CXCompilationDatabase_CanNotLoadDatabase = 1
}

extern(C) {
CXCompilationDatabase
clang_CompilationDatabase_fromDirectory(const char *BuildDir,
                                        CXCompilationDatabase_Error *ErrorCode);
CXCompileCommands
clang_CompilationDatabase_getCompileCommands(CXCompilationDatabase,
                                             const char *CompleteFileName);
uint clang_CompileCommands_getSize(CXCompileCommands);

CXCompileCommand
clang_CompileCommands_getCommand(CXCompileCommands, uint I);

uint
clang_CompileCommand_getNumArgs(CXCompileCommand);

CXString
clang_CompileCommand_getArg(CXCompileCommand, uint I);

const(char)*
clang_getCString(CXString);

CXString
clang_CompileCommand_getFilename(CXCompileCommand);
}
void main(string[] args) {
	immutable string[] source_ext = [
		".c", ".cc", ".cp", ".cpp", ".cxx", ".c++", ".m", ".mm", ".i", ".ii",
		".mii"
	];
	immutable string[] omit_arg = [
		"-c", "-rdynamic"
	];
	immutable string[] omit_arg_startwith = [
		"-Wl", "-l", "-g"
	];
	auto old_cwd = getcwd;
	string[] c_args = args[1..$];
	string file_name;
	src_search: foreach(x; c_args) {
		if (x[0] == '-')
			continue;
		foreach(y; source_ext)
			if (x.endsWith(y)) {
				if (x[0] == '/')
					file_name = x;
				else
					file_name = old_cwd~"/"~x;
				break src_search;
			}
	}
	JSONValue j;
	import core.stdc.string;
	try {
		do {
			if (exists("compile_commands.json") && isFile("compile_commands.json"))
				break;
			chdir("..");
		} while (getcwd != "/");
		if (getcwd == "/")
			throw new Exception("Can't find database");
		j = parseJSON(cast(ubyte[])read("compile_commands.json"));
		string build_dir = getcwd;
		chdir(old_cwd);

		CXCompilationDatabase_Error err;
		auto db = clang_CompilationDatabase_fromDirectory(build_dir.toStringz, &err);
		if (err != CXCompilationDatabase_Error.CXCompilationDatabase_NoError)
			throw new Exception("Failed to load database");
		auto cmds = clang_CompilationDatabase_getCompileCommands(db, file_name.toStringz);
		if (!cmds)
			throw new Exception("No entry found in database");
		auto cmd = clang_CompileCommands_getCommand(cmds, 0);
		uint nargs = clang_CompileCommand_getNumArgs(cmd);
		auto _cfilename = clang_CompileCommand_getFilename(cmd).clang_getCString;
		const(char)[] cfilename = _cfilename[0..strlen(_cfilename)];
		bool skip_next = false;
		get_args: foreach(i; 1..nargs) {
			if (skip_next) {
				skip_next = false;
				continue;
			}
			auto x = clang_CompileCommand_getArg(cmd, i).clang_getCString;
			const(char)[] sl = x[0..strlen(x)];
			if (sl == "-o") {
				skip_next = true;
				continue;
			}

			if (sl == cfilename)
				continue;

			foreach(o; omit_arg)
				if (sl == o)
					continue get_args;
			foreach(o; omit_arg_startwith)
				if (sl.startsWith(o))
					continue get_args;
			c_args ~= [sl.idup];
		}
	} catch(Exception e) {
	}
	wait(spawnProcess(c_args));
}
