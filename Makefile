cdb_wrapper: cdb_wrapper.d
	dmd $< -of$@ -L-lclang
