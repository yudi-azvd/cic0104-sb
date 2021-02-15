# https://codereview.stackexchange.com/questions/157780/generic-makefile-handling-unit-testing-and-folder-structure
# A pergunta desse post me ajudou MUITO.

## Não colocar './' no começo dos nomes de diretórios.

## É aconselhável que o nome do target seja diferente do nome do arquivo

MAIN_EXEC ?= main

TESTS_EXEC ?= test_exec

CXX = g++

BUILD_DIR ?= build
SRC_DIRS ?= src 

MAIN := src/$(MAIN_EXEC).c
# MAIN := src/main.c
SRCS := $(wildcard src/*.c)
OBJS := $(SRCS:%=$(BUILD_DIR)/src/%.o)

TEST_MAIN := ./tests/test_main.c
TEST_SRCS := $(wildcard tests/*.c)
# Por enquanto precisa ser o mesmo nome
# TEST_OBJS := $(filter-out build/src/$(MAIN_EXEC).c.o, $(OBJS)) \
						 $(TEST_SRCS:%=$(BUILD_DIR)/tests/%.o)

##                              src/src???
TEST_OBJS := $(filter-out build/src/src/$(MAIN_EXEC).c.o, $(OBJS)) \
						 $(TEST_SRCS:%=$(BUILD_DIR)/tests/%.o)


all: main tests


####################################
# Executável principal             #
####################################
main: $(BUILD_DIR)/$(MAIN_EXEC) 
	@echo "  > main: Done $@ => $<"
	@echo "--------------------------\n"

$(BUILD_DIR)/$(MAIN_EXEC): $(OBJS) $(MAIN) # 
	@echo ">>> main: Building executable"
	@$(CXX) $(OBJS) -o $@

# c source
$(BUILD_DIR)/src/%.c.o: %.c
	@echo " >> main: Building source file: $<"
	@echo "  > main: Output file: $@\n"
	@$(MKDIR_P) $(dir $@)
	@$(CXX) -c $< -o $@


####################################
# Executável do testes unitários	 #
####################################
tests: $(BUILD_DIR)/$(TESTS_EXEC)
	@echo " > test: Build done"

$(BUILD_DIR)/$(TESTS_EXEC): $(TEST_OBJS)
	@echo ">> test: Building TEST executable $@"
	@$(CXX) $(TEST_OBJS) -o $@

# test sources
$(BUILD_DIR)/tests/%.c.o: %.c
	@echo ">> test: Building test source: $<"
	@echo " > test: Output file: $@\n"
	@$(MKDIR_P) $(dir $@)
	@$(CXX) -c $< -o $@


.PHONY: clean test main

clean:
	rm -fr $(BUILD_DIR)/* $(MAIN_EXEC) $(TESTS_EXEC)


MKDIR_P ?= mkdir -p