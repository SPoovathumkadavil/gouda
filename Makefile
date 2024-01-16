
MAKEFLAGS = -s

SRC_DIR = src
OBJ_DIR = build
BIN_DIR = bin
INCL_DIR = include

CPP_SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp) $(wildcard $(SRC_DIR)/*/*.cpp) $(wildcard $(SRC_DIR)/*/*/*.cpp)

OBJ_FILES := $(subst $(SRC_DIR), $(OBJ_DIR), $(addsuffix .o, $(basename $(CPP_SRC_FILES))))

OUT = $(BIN_DIR)/gouda

CC = gcc
CPP = c++
CPPFLAGS = -std=c++17 -Wall -r
LDFLAGS =

build: $(OUT)

$(OUT) : $(OBJ_FILES)
	echo "Making Output"
	$(CC) $(LDFLAGS) $(OBJ_FILES) -o $(OUT)
	echo "Linking $(OBJ_FILES) -------> $(OUT)"

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp 
	mkdir -p $(dir $@)
	$(CPP) $(CPPFLAGS) $< -o $@
	echo "$<  ----->  $@"


files:	
	echo "<----- .cpp ----->"
	echo $(CPP_SRC_FILES)  "\n"
	echo "<----- objects ----->"
	echo $(OBJ_FILES) "\n"
	echo "<----- Output File ----->"
	echo $(OUTPUT_FILE)


list:
	echo "list    --> list all options"
	echo "build   --> build any changes"
	echo "clean   --> remove all compiled files"
	echo "rebuild --> clean, then build"
	echo "run     --> run output"
	echo "all     --> clean, build, then run"
	echo "files   --> show what source files will be used when building"
	echo "print   --> prints a the name of a the a thing"

print:
		if which figlet >/dev/null; then figlet -c Gouda; else echo "Gouda"; fi

run:
	$(OUT)

clean:
	echo "Remaking Build Directory"
	rm -rf $(OBJ_DIR)
	mkdir -p $(OBJ_DIR)
	echo "Remaking Bin Directory"
	rm -rf $(BIN_DIR)
	mkdir -p $(BIN_DIR)

.PHONY: clean print run all list files

rebuild : print clean build

all : rebuild run

