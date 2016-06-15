all: cdb_wrapper cdb_path

#A tool that looks for compile_commands.json and append
#its contents onto the command line arguments
cdb_wrapper: cdb_wrapper.d
	dmd $< -of$@ -L-lclang
