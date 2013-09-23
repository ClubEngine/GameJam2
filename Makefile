EXEC := main.love

SRC_DIR	:= src/

ifdef SystemRoot
# Pure Windows, no Cygwin
	RM	:= del /Q
	ZIP_CMD	:= 7z a
else
	ifeq (,$(findstring Linux,$(shell uname -o)))
	# Cygwin
		ZIP_CMD	:= 7z a > /dev/null
	else
		ZIP_CMD	:= zip > /dev/null
	endif
endif

all: $(EXEC)

$(EXEC):
	@cd $(SRC_DIR) && $(ZIP_CMD) ../$(EXEC) *

clean:
	@$(RM) $(EXEC)

go:
	@love $(EXEC)

help:
	@echo "NOTE: Need 'zip' command under Linux, '7z' under Windows"
	@echo "Targets :"
	@echo "			-> compile LOVE file"
	@echo "	clean	-> remove LOVE file"
	@echo "	go		-> launch LOVE file"
	@echo "	help"
